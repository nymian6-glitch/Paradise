-- Aegis LuaU Obfuscator
-- steps/encrypt_strings.lua -- Encrypts string literals using seeded XOR cipher

local Step = require("steps.step")
local Ast = require("ast")
local Scope = require("scope")
local Parser = require("parser")
local visitast = require("visitor")
local util = require("util")
local AstKind = Ast.AstKind

local EncryptStrings = Step:extend()
EncryptStrings.Name = "EncryptStrings"
EncryptStrings.Description = "Encrypts string constants using seeded XOR cipher"
EncryptStrings.SettingsDescriptor = {}

function EncryptStrings:init() end

function EncryptStrings:createEncryptionService()
    local usedSeeds = {}
    local globalKey = math.random(1, 255)

    local function xorByte(a, b)
        local p, c = 1, 0
        while a > 0 and b > 0 do
            local ra, rb = a % 2, b % 2
            if ra ~= rb then c = c + p end
            a, b, p = (a - ra) / 2, (b - rb) / 2, p * 2
        end
        if a < b then a = b end
        while a > 0 do
            local ra = a % 2
            if ra > 0 then c = c + p end
            a, p = (a - ra) / 2, p * 2
        end
        return c
    end

    local function genSeed()
        local seed
        repeat
            seed = math.random(1, 2^24)
        until not usedSeeds[seed]
        usedSeeds[seed] = true
        return seed
    end

    local function encrypt(str)
        local seed = genSeed()
        local len = #str
        local out = {}
        local state = seed
        for i = 1, len do
            state = (state * 1103515245 + 12345) % (2^31)
            local key = math.floor(state / 65536) % 256
            out[i] = string.char(xorByte(string.byte(str, i), xorByte(key, globalKey)))
        end
        return table.concat(out), seed
    end

    local function genDecryptCode()
        -- Use a single expression for XOR to avoid nested function/upvalue issues
        -- bxor is inlined using arithmetic: ((a+b) - 2*AND(a,b))
        -- but for simplicity, use bit-by-bit in a flat loop without nested functions
        return
            "function AEGIS_DECRYPT(s,seed)" ..
            " local o={};local st=seed" ..
            " for i=1,#s do" ..
            " st=(st*1103515245+12345)%2147483648" ..
            " local k=math.floor(st/65536)%256" ..
            " local v=string.byte(s,i)" ..
            " local kk=k" ..
            " local a1=v;local b1=" .. globalKey ..
            " local p1,c1=1,0" ..
            " while a1>0 and b1>0 do local ra1,rb1=a1%2,b1%2 if ra1~=rb1 then c1=c1+p1 end a1,b1,p1=(a1-ra1)/2,(b1-rb1)/2,p1*2 end" ..
            " if a1<b1 then a1=b1 end while a1>0 do local ra1=a1%2 if ra1>0 then c1=c1+p1 end a1,p1=(a1-ra1)/2,p1*2 end" ..
            " local a2=c1;local b2=kk" ..
            " local p2,c2=1,0" ..
            " while a2>0 and b2>0 do local ra2,rb2=a2%2,b2%2 if ra2~=rb2 then c2=c2+p2 end a2,b2,p2=(a2-ra2)/2,(b2-rb2)/2,p2*2 end" ..
            " if a2<b2 then a2=b2 end while a2>0 do local ra2=a2%2 if ra2>0 then c2=c2+p2 end a2,p2=(a2-ra2)/2,p2*2 end" ..
            " o[i]=string.char(c2)" ..
            " end" ..
            " return table.concat(o)" ..
            " end"
    end

    return {
        encrypt = encrypt,
        genDecryptCode = genDecryptCode,
    }
end

function EncryptStrings:apply(ast, pipeline)
    local service = self:createEncryptionService()

    local decryptCodeStr = service.genDecryptCode()
    local decryptParser = Parser:new()
    local decryptAst = decryptParser:parse(decryptCodeStr, "<decrypt>")

    visitast(ast, nil, function(node)
        if node.kind == AstKind.StringExpression and type(node.value) == "string" and #node.value > 0 then
            local encrypted, seed = service.encrypt(node.value)
            local globalScope = ast.scope:getParent() or ast.scope
            local _, decryptId = globalScope:resolve("AEGIS_DECRYPT")
            return Ast.FunctionCallExpression(
                Ast.VariableExpression(globalScope, decryptId),
                {
                    Ast.StringExpression(encrypted),
                    Ast.NumberExpression(seed),
                }
            )
        end
    end)

    table.insert(ast.body, 1, decryptAst.body[1])
    return ast
end

return EncryptStrings
