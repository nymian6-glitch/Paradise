-- Aegis LuaU Obfuscator
-- vm/emitter.lua -- Generates the runtime VM with super operators, mutations, and binary search dispatch

local Opcodes = require("vm.opcodes")
local util = require("util")
local Op = Opcodes.Op

local Emitter = {}

function Emitter:new(options)
    local emitter = {
        options = options or {},
        maxSuperOpSize = options and options.maxSuperOpSize or 10,
        maxMutations = options and options.maxMutations or 100,
        useSuperOps = options and options.superOperators ~= false,
        useMutations = options and options.mutations ~= false,
        xorKey = math.random(0, 255),
    }
    setmetatable(emitter, self)
    self.__index = self
    return emitter
end

function Emitter:emit(chunk)
    local opcodeHandlers, opcodeMap = self:generateOpcodeHandlers(chunk)
    local bytecodeStr = self:serializeChunk(chunk)
    local vmCode = self:generateVM(bytecodeStr, opcodeHandlers, opcodeMap, chunk)
    return vmCode
end

-- Serialize chunk to bytecode string
function Emitter:serializeChunk(chunk)
    local bytes = {}

    local function writeByte(b)
        bytes[#bytes + 1] = string.char(util.bitxor(b % 256, self.xorKey))
    end

    local function writeInt32(n)
        writeByte(n % 256)
        writeByte(math.floor(n / 256) % 256)
        writeByte(math.floor(n / 65536) % 256)
        writeByte(math.floor(n / 16777216) % 256)
    end

    local function writeInt16(n)
        writeByte(n % 256)
        writeByte(math.floor(n / 256) % 256)
    end

    local function writeDouble(n)
        local sign = 0
        if n < 0 then sign = 1; n = -n end
        local mantissa, exponent = math.frexp(n)
        if n == 0 then
            writeInt32(0); writeInt32(0)
            return
        end
        mantissa = (mantissa * 2 - 1) * 2^52
        exponent = exponent - 1 + 1023
        local low = mantissa % 2^32
        local high = sign * 2^31 + exponent * 2^20 + math.floor(mantissa / 2^32)
        writeInt32(math.floor(low))
        writeInt32(math.floor(high))
    end

    local function writeString(s)
        writeInt32(#s)
        for i = 1, #s do
            writeByte(string.byte(s, i))
        end
    end

    local function serializeProto(proto)
        -- Num params
        writeByte(proto.numParams or 0)

        -- Constants
        writeInt32(#proto.constants)
        for _, c in ipairs(proto.constants) do
            local t = type(c)
            if t == "boolean" then
                writeByte(1); writeByte(c and 1 or 0)
            elseif t == "number" then
                writeByte(2); writeDouble(c)
            elseif t == "string" then
                writeByte(3); writeString(c)
            else
                writeByte(0)
            end
        end

        -- Instructions
        writeInt32(#proto.instructions)
        for _, instr in ipairs(proto.instructions) do
            local mappedOp = self.opcodeMap and self.opcodeMap[instr.op] or instr.op
            writeInt16(mappedOp)
            writeInt16(instr.a)
            writeInt32(instr.b)
            writeInt16(instr.c)
        end

        -- Sub-prototypes
        writeInt32(#proto.prototypes)
        for _, sub in ipairs(proto.prototypes) do
            serializeProto(sub)
        end

        -- Upvalue definitions
        local upvals = proto.upvalues or {}
        writeInt32(#upvals)
        for _, uv in ipairs(upvals) do
            if uv.inParent then
                writeByte(1)
                writeInt16(uv.reg)
            else
                writeByte(0)
                writeInt16(uv.idx or uv.reg or 0)
            end
        end
    end

    serializeProto(chunk)
    return table.concat(bytes)
end

-- Generate opcode handlers with optional mutations
function Emitter:generateOpcodeHandlers(chunk)
    local usedOps = {}
    local function scanOps(proto)
        for _, instr in ipairs(proto.instructions) do
            usedOps[instr.op] = true
        end
        for _, sub in ipairs(proto.prototypes) do
            scanOps(sub)
        end
    end
    scanOps(chunk)

    local handlers = {}
    local opcodeMap = {}
    local nextId = 0

    local opList = {}
    for op in pairs(usedOps) do
        opList[#opList + 1] = op
    end
    util.shuffle(opList)

    for _, op in ipairs(opList) do
        opcodeMap[op] = nextId
        handlers[nextId] = self:getHandler(op)
        nextId = nextId + 1

        -- Generate mutations (randomized register access order)
        if self.useMutations then
            local numMuts = math.random(2, 5)
            for m = 1, numMuts do
                if nextId >= self.maxMutations then break end
                local orders = {{0,1,2}, {0,2,1}, {1,0,2}, {1,2,0}, {2,0,1}, {2,1,0}}
                local order = orders[math.random(1, #orders)]
                opcodeMap[op .. "_mut" .. m] = nextId
                handlers[nextId] = self:getHandler(op, order)
                nextId = nextId + 1
            end
        end
    end

    self.opcodeMap = opcodeMap
    return handlers, opcodeMap
end

-- Get handler code for a specific opcode
function Emitter:getHandler(op, regOrder)
    regOrder = regOrder or {0, 1, 2}
    local ra = ({"Inst[2]", "Inst[3]", "Inst[4]"})[regOrder[1] + 1]
    local rb = ({"Inst[2]", "Inst[3]", "Inst[4]"})[regOrder[2] + 1]
    local rc = ({"Inst[2]", "Inst[3]", "Inst[4]"})[regOrder[3] + 1]

    -- For default ordering, use standard names
    if regOrder[1] == 0 and regOrder[2] == 1 and regOrder[3] == 2 then
        ra, rb, rc = "Inst[2]", "Inst[3]", "Inst[4]"
    end

    local templates = {
        [Op.MOVE]     = "Stk[" .. ra .. "]=Stk[" .. rb .. "]",
        [Op.LOADK]    = "Stk[" .. ra .. "]=Consts[" .. rb .. "+1]",
        [Op.LOADBOOL] = "Stk[" .. ra .. "]=(" .. rb .. "~=0);if " .. rc .. "~=0 then IP=IP+1 end",
        [Op.LOADNIL]  = "Stk[" .. ra .. "]=nil",
        [Op.GETUPVAL] = "Stk[" .. ra .. "]=Upvals[" .. rb .. "]()",
        [Op.GETGLOBAL]= "Stk[" .. ra .. "]=Env[Consts[" .. rb .. "+1]]",
        [Op.GETTABLE] = "local idx=" .. rc .. ";if idx>255 then Stk[" .. ra .. "]=Stk[" .. rb .. "][Consts[idx-255]] else Stk[" .. ra .. "]=Stk[" .. rb .. "][Stk[idx]] end",
        [Op.SETGLOBAL]= "Env[Consts[" .. rb .. "+1]]=Stk[" .. ra .. "]",
        [Op.SETUPVAL] = "Upvals[-(" .. rb .. "+1)](Stk[" .. ra .. "])",
        [Op.SETTABLE] = "local idx=" .. rb .. ";local val=Stk[" .. rc .. "];if idx>255 then Stk[" .. ra .. "][Consts[idx-255]]=val else Stk[" .. ra .. "][Stk[idx]]=val end",
        [Op.NEWTABLE] = "Stk[" .. ra .. "]={}",
        [Op.SELF]     = "local A=" .. ra .. ";Stk[A+1]=Stk[" .. rb .. "];local idx=" .. rc .. ";if idx>255 then Stk[A]=Stk[" .. rb .. "][Consts[idx-255]] else Stk[A]=Stk[" .. rb .. "][Stk[idx]] end",
        [Op.ADD]      = "Stk[" .. ra .. "]=Stk[" .. rb .. "]+Stk[" .. rc .. "]",
        [Op.SUB]      = "Stk[" .. ra .. "]=Stk[" .. rb .. "]-Stk[" .. rc .. "]",
        [Op.MUL]      = "Stk[" .. ra .. "]=Stk[" .. rb .. "]*Stk[" .. rc .. "]",
        [Op.DIV]      = "Stk[" .. ra .. "]=Stk[" .. rb .. "]/Stk[" .. rc .. "]",
        [Op.MOD]      = "Stk[" .. ra .. "]=Stk[" .. rb .. "]%Stk[" .. rc .. "]",
        [Op.POW]      = "Stk[" .. ra .. "]=Stk[" .. rb .. "]^Stk[" .. rc .. "]",
        [Op.UNM]      = "Stk[" .. ra .. "]=-Stk[" .. rb .. "]",
        [Op.NOT]      = "Stk[" .. ra .. "]=not Stk[" .. rb .. "]",
        [Op.LEN]      = "Stk[" .. ra .. "]=#Stk[" .. rb .. "]",
        [Op.CONCAT]   = "local r=\"\";for i=" .. rb .. "," .. rc .. " do r=r..Stk[i] end;Stk[" .. ra .. "]=r",
        [Op.JMP]      = "IP=IP+" .. rb,
        [Op.EQ]       = "if (Stk[" .. rb .. "]==Stk[" .. rc .. "])~=(" .. ra .. "~=0) then IP=IP+1 end",
        [Op.LT]       = "if (Stk[" .. rb .. "]<Stk[" .. rc .. "])~=(" .. ra .. "~=0) then IP=IP+1 end",
        [Op.LE]       = "if (Stk[" .. rb .. "]<=Stk[" .. rc .. "])~=(" .. ra .. "~=0) then IP=IP+1 end",
        [Op.TEST]     = "if (not Stk[" .. ra .. "])==(" .. rc .. "~=0) then IP=IP+1 end",
        [Op.TESTSET]  = "if (not Stk[" .. rb .. "])==(" .. rc .. "~=0) then IP=IP+1 else Stk[" .. ra .. "]=Stk[" .. rb .. "] end",
        [Op.CALL]     = "local A=" .. ra .. ";local B=" .. rb .. ";local C=" .. rc .. ";local n=0;if B>1 then n=B-1 elseif B==0 then n=Top-A end;local rets={Stk[A](unpack(Stk,A+1,A+n))};if C>1 then for i=1,C-1 do Stk[A+i-1]=rets[i] end elseif C==0 then for i=1,#rets do Stk[A+i-1]=rets[i] end;Top=A+#rets-1 end",
        [Op.TAILCALL] = "local A=" .. ra .. ";local B=" .. rb .. ";local n=0;if B>1 then n=B-1 else n=Top-A end;return Stk[A](unpack(Stk,A+1,A+n))",
        [Op.RETURN]   = "local A=" .. ra .. ";local B=" .. rb .. ";if B==1 then return elseif B==0 then return unpack(Stk,A,Top) else return unpack(Stk,A,A+B-2) end",
        [Op.FORLOOP]  = "local A=" .. ra .. ";Stk[A]=Stk[A]+Stk[A+2];if Stk[A+2]>0 then if Stk[A]<=Stk[A+1] then IP=IP+" .. rb .. ";Stk[A+3]=Stk[A] end else if Stk[A]>=Stk[A+1] then IP=IP+" .. rb .. ";Stk[A+3]=Stk[A] end end",
        [Op.FORPREP]  = "local A=" .. ra .. ";Stk[A]=Stk[A]-Stk[A+2];IP=IP+" .. rb,
        [Op.TFORLOOP] = "local A=" .. ra .. ";local C=" .. rc .. ";local rets={Stk[A](Stk[A+1],Stk[A+2])};for i=1,C do Stk[A+2+i]=rets[i] end;if Stk[A+3]~=nil then Stk[A+2]=Stk[A+3];IP=IP+1 end",
        [Op.SETLIST]  = "local A=" .. ra .. ";local B=" .. rb .. ";local C=" .. rc .. ";local offset=(C-1)*50;for i=1,B do Stk[A][offset+i]=Stk[A+i] end",
        [Op.CLOSURE]  = "local proto=Protos[" .. rb .. "+1];Stk[" .. ra .. "]=Wrap(proto,Env,Stk,Upvals)",
        [Op.VARARG]   = "local A=" .. ra .. ";local B=" .. rb .. ";if B==0 then for i=0,#Vararg do Stk[A+i]=Vararg[i] end;Top=A+#Vararg else for i=1,B-1 do Stk[A+i-1]=Vararg[i-1] end end",
        [Op.FLOORDIV] = "Stk[" .. ra .. "]=math.floor(Stk[" .. rb .. "]/Stk[" .. rc .. "])",
    }

    return templates[op] or ("--unknown op " .. tostring(op))
end

-- Generate binary search dispatch
function Emitter:generateDispatch(handlers)
    local ids = {}
    for id in pairs(handlers) do
        ids[#ids + 1] = id
    end
    table.sort(ids)

    local function buildTree(lo, hi)
        if lo > hi then return "" end
        if lo == hi then
            return handlers[ids[lo]]
        end
        if hi - lo == 1 then
            return "if Enum==" .. ids[lo] .. " then " .. handlers[ids[lo]] ..
                " else " .. handlers[ids[hi]] .. " end"
        end
        local mid = math.floor((lo + hi) / 2)
        return "if Enum<" .. ids[mid] .. " then " ..
            buildTree(lo, mid - 1) ..
            " elseif Enum>" .. ids[mid] .. " then " ..
            buildTree(mid + 1, hi) ..
            " else " .. handlers[ids[mid]] .. " end"
    end

    return buildTree(1, #ids)
end

-- Generate complete VM code
function Emitter:generateVM(bytecodeStr, handlers, opcodeMap, chunk)
    local parts = {}

    -- LZW compress the bytecode
    local compressed = self:lzwCompress(bytecodeStr)
    local xorKey = self.xorKey

    parts[#parts + 1] = "local Byte=string.byte"
    parts[#parts + 1] = "local Char=string.char"
    parts[#parts + 1] = "local Sub=string.sub"
    parts[#parts + 1] = "local Concat=table.concat"
    parts[#parts + 1] = "local Insert=table.insert"
    parts[#parts + 1] = "local Floor=math.floor"
    parts[#parts + 1] = "local GetFEnv=getfenv or function() return _ENV end"
    parts[#parts + 1] = "local Select=select"
    parts[#parts + 1] = "local unpack=unpack or table.unpack"

    -- XOR function
    parts[#parts + 1] = [[local function BitXOR(a,b) local p,c=1,0 while a>0 and b>0 do local ra,rb=a%2,b%2 if ra~=rb then c=c+p end a,b,p=(a-ra)/2,(b-rb)/2,p*2 end if a<b then a=b end while a>0 do local ra=a%2 if ra>0 then c=c+p end a,p=(a-ra)/2,p*2 end return c end]]

    -- LZW decompress
    parts[#parts + 1] = [[local function Decompress(b) local c,d,e="","",{} local f=256 local g={} for h=0,f-1 do g[h]=Char(h) end local i=1 local function k() local l=tonumber(Sub(b,i,i),36) i=i+1 local m=tonumber(Sub(b,i,i+l-1),36) i=i+l return m end c=Char(k()) e[1]=c while i<#b do local n=k() if g[n] then d=g[n] else d=c..Sub(c,1,1) end g[f]=c..Sub(d,1,1) e[#e+1],c,f=d,d,f+1 end return Concat(e) end]]

    -- Bytecode string
    parts[#parts + 1] = "local ByteString=Decompress('" .. compressed .. "')"

    -- Deserializer
    parts[#parts + 1] = "local Pos=1"
    parts[#parts + 1] = "local function gBits8() local F=BitXOR(Byte(ByteString,Pos,Pos)," .. xorKey .. ") Pos=Pos+1 return F end"
    parts[#parts + 1] = "local function gBits16() local W,X=Byte(ByteString,Pos,Pos+1) W=BitXOR(W," .. xorKey .. ") X=BitXOR(X," .. xorKey .. ") Pos=Pos+2 return X*256+W end"
    parts[#parts + 1] = "local function gBits32() local W,X,Y,Z=Byte(ByteString,Pos,Pos+3) W=BitXOR(W," .. xorKey .. ") X=BitXOR(X," .. xorKey .. ") Y=BitXOR(Y," .. xorKey .. ") Z=BitXOR(Z," .. xorKey .. ") Pos=Pos+4 return Z*16777216+Y*65536+X*256+W end"
    parts[#parts + 1] = [[local function gFloat() local Left=gBits32() local Right=gBits32() local IsNormal=1 local Mantissa=(Right%1048576)*4294967296+Left local Exponent=Floor(Right/1048576)%2048 local Sign=(-1)^Floor(Right/2147483648) if Exponent==0 then if Mantissa==0 then return Sign*0 else Exponent=1 IsNormal=0 end elseif Exponent==2047 then return Mantissa==0 and Sign*(1/0) or Sign*(0/0) end return math.ldexp(Sign,Exponent-1023)*(IsNormal+Mantissa/4503599627370496) end]]
    parts[#parts + 1] = [[local function gString() local Len=gBits32() if Len==0 then return'' end local s=Sub(ByteString,Pos,Pos+Len-1) Pos=Pos+Len local t={} for i=1,#s do t[i]=Char(BitXOR(Byte(s,i,i),]] .. xorKey .. [[)) end return Concat(t) end]]

    -- Deserialize function
    parts[#parts + 1] = [[local function Deserialize()
local Instrs={} local Protos={} local Params=gBits8()
local ConstCount=gBits32() local Consts={}
for i=1,ConstCount do local T=gBits8() if T==1 then Consts[i]=(gBits8()~=0) elseif T==2 then Consts[i]=gFloat() elseif T==3 then Consts[i]=gString() else Consts[i]=nil end end
local InstrCount=gBits32()
for i=1,InstrCount do local Op=gBits16() local A=gBits16() local B=gBits32() if B>=2147483648 then B=B-4294967296 end local C=gBits16() Instrs[i]={Op,A,B,C} end
local ProtoCount=gBits32()
for i=1,ProtoCount do Protos[i]=Deserialize() end
local UpCount=gBits32() local UpDefs=nil
if UpCount>0 then UpDefs={} for i=1,UpCount do local t=gBits8() local r=gBits16() UpDefs[i]={t,r} end end
return {Instrs,Protos,Params,Consts,UpDefs} end]]

    -- VM Wrap function
    local dispatch = self:generateDispatch(handlers)

    parts[#parts + 1] = [=[local function Wrap(Chunk,Env,PStk,PUpvals)
local Instr=Chunk[1] local Proto=Chunk[2] local Params=Chunk[3] local Consts=Chunk[4] local UpDefs=Chunk[5]
local Upvals={}
if UpDefs then for i=1,#UpDefs do local d=UpDefs[i] if d[1]==1 then Upvals[i-1]=function() return PStk[d[2]] end Upvals[-i]=function(v) PStk[d[2]]=v end else Upvals[i-1]=function() return PUpvals[d[2]] end Upvals[-i]=function(v) PUpvals[d[2]]=v end end end end
return function(...)
local Stk={} local Top=-1 local Vararg={} local Args={...}
local PCount=Select('#',...)-1
for i=0,PCount do if i>=Params then Vararg[i-Params]=Args[i+1] else Stk[i]=Args[i+1] end end
local IP=1 local Protos=Proto
while true do
local Inst=Instr[IP] local Enum=Inst[1]
]=] .. dispatch .. [=[

IP=IP+1
end end end]=]

    parts[#parts + 1] = "return Wrap(Deserialize(),GetFEnv())(...)"

    return table.concat(parts, "\n")
end

-- LZW compression
function Emitter:lzwCompress(input)
    local dict = {}
    for i = 0, 255 do
        dict[string.char(i)] = i
    end

    local w = ""
    local compressed = {}
    local dictSize = 256

    for i = 1, #input do
        local c = input:sub(i, i)
        local wc = w .. c
        if dict[wc] then
            w = wc
        else
            compressed[#compressed + 1] = dict[w]
            dict[wc] = dictSize
            dictSize = dictSize + 1
            w = c
        end
    end

    if w ~= "" then
        compressed[#compressed + 1] = dict[w]
    end

    -- Encode to base36
    local function toBase36(n)
        local digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        if n == 0 then return "0" end
        local result = {}
        while n > 0 do
            local rem = n % 36
            table.insert(result, 1, digits:sub(rem + 1, rem + 1))
            n = math.floor(n / 36)
        end
        return table.concat(result)
    end

    local parts = {}
    for _, code in ipairs(compressed) do
        local s = toBase36(code)
        parts[#parts + 1] = toBase36(#s)
        parts[#parts + 1] = s
    end

    return table.concat(parts)
end

return Emitter
