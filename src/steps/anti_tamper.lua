-- Aegis LuaU Obfuscator
-- steps/anti_tamper.lua -- Inserts integrity checks that break the script if modified

local Step = require("steps.step")
local Ast = require("ast")
local Scope = require("scope")
local Parser = require("parser")
local util = require("util")
local AstKind = Ast.AstKind

local AntiTamper = Step:extend()
AntiTamper.Name = "AntiTamper"
AntiTamper.Description = "Inserts tamper detection checks"
AntiTamper.SettingsDescriptor = {
    Intensity = { type = "number", default = 3, min = 1, max = 10 },
}

function AntiTamper:init() end

function AntiTamper:generateChecks()
    local key1 = math.random(100000, 999999)
    local key2 = math.random(100000, 999999)
    local checkSum = key1 + key2

    local parts = {}
    parts[#parts + 1] = "do"
    -- Verify standard library integrity
    parts[#parts + 1] = "if type(pcall) ~= 'function' then while true do end end"
    parts[#parts + 1] = "if type(tostring) ~= 'function' then while true do end end"
    -- Anti-hook: pcall should work (no closures - avoid upvalue issues with VM)
    parts[#parts + 1] = "local AEGIS_OK = pcall(type, nil)"
    parts[#parts + 1] = "if not AEGIS_OK then while true do end end"
    -- Numeric integrity check
    parts[#parts + 1] = "local AEGIS_A = " .. key1
    parts[#parts + 1] = "local AEGIS_B = " .. key2
    parts[#parts + 1] = "if AEGIS_A + AEGIS_B ~= " .. checkSum .. " then while true do end end"
    parts[#parts + 1] = "end"

    return table.concat(parts, "\n")
end

function AntiTamper:apply(ast, pipeline)
    local code = self:generateChecks()
    local parser = Parser:new()
    local tamperAst = parser:parse(code, "<anti_tamper>")

    for i = #tamperAst.body, 1, -1 do
        table.insert(ast.body, 1, tamperAst.body[i])
    end

    return ast
end

return AntiTamper
