-- Aegis LuaU Obfuscator
-- vm/opcodes.lua -- Custom opcode definitions for the VM

local Opcodes = {}

-- Custom opcode enum (NOT matching Lua's opcodes)
Opcodes.Op = {
    MOVE        = 0,
    LOADK       = 1,
    LOADBOOL    = 2,
    LOADNIL     = 3,
    GETUPVAL    = 4,
    GETGLOBAL   = 5,
    GETTABLE    = 6,
    SETGLOBAL   = 7,
    SETUPVAL    = 8,
    SETTABLE    = 9,
    NEWTABLE    = 10,
    SELF        = 11,
    ADD         = 12,
    SUB         = 13,
    MUL         = 14,
    DIV         = 15,
    MOD         = 16,
    POW         = 17,
    UNM         = 18,
    NOT         = 19,
    LEN         = 20,
    CONCAT      = 21,
    JMP         = 22,
    EQ          = 23,
    LT          = 24,
    LE          = 25,
    TEST        = 26,
    TESTSET     = 27,
    CALL        = 28,
    TAILCALL    = 29,
    RETURN      = 30,
    FORLOOP     = 31,
    FORPREP     = 32,
    TFORLOOP    = 33,
    SETLIST     = 34,
    CLOSE       = 35,
    CLOSURE     = 36,
    VARARG      = 37,
    -- LuaU extensions
    FLOORDIV    = 38,
    IDIV        = 39,
    CONTINUE    = 40,
    -- Custom super-opcodes are numbered starting from 100
    SUPER_BASE  = 100,
}

-- Instruction format:
-- Each instruction is { opcode, A, B, C }
-- A = destination register (0-based)
-- B, C = operands (registers, constants, or jump targets)

Opcodes.InstrType = {
    ABC  = 0,  -- A, B, C are all used
    ABx  = 1,  -- A and Bx (B as extended value)
    AsBx = 2,  -- A and signed Bx
}

local instrTypes = {}
local Op = Opcodes.Op
for k, v in pairs(Op) do
    if v <= 37 then
        instrTypes[v] = Opcodes.InstrType.ABC
    end
end
instrTypes[Op.LOADK]     = Opcodes.InstrType.ABx
instrTypes[Op.GETGLOBAL] = Opcodes.InstrType.ABx
instrTypes[Op.SETGLOBAL] = Opcodes.InstrType.ABx
instrTypes[Op.JMP]       = Opcodes.InstrType.AsBx
instrTypes[Op.FORLOOP]   = Opcodes.InstrType.AsBx
instrTypes[Op.FORPREP]   = Opcodes.InstrType.AsBx
instrTypes[Op.CLOSURE]   = Opcodes.InstrType.ABx

Opcodes.InstrTypes = instrTypes

function Opcodes.newInstruction(op, a, b, c)
    return { op = op, a = a or 0, b = b or 0, c = c or 0 }
end

return Opcodes
