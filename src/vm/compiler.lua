-- Aegis LuaU Obfuscator
-- vm/compiler.lua -- Compiles AST into custom bytecode for the VM

local Ast = require("ast")
local Scope = require("scope")
local Opcodes = require("vm.opcodes")
local util = require("util")
local logger = require("logger")
local AstKind = Ast.AstKind
local Op = Opcodes.Op

local Compiler = {}

function Compiler:new()
    local compiler = {
        instructions = {},
        constants = {},
        constantLookup = {},
        prototypes = {},
        registers = 0,
        maxRegisters = 0,
        locals = {},
        upvalues = {},
        pendingJumps = {},
        loopStack = {},
    }
    setmetatable(compiler, self)
    self.__index = self
    return compiler
end

function Compiler:emit(op, a, b, c)
    local instr = Opcodes.newInstruction(op, a, b, c)
    self.instructions[#self.instructions + 1] = instr
    return #self.instructions
end

function Compiler:patchJump(instrIdx, target)
    local instr = self.instructions[instrIdx]
    instr.b = target - instrIdx - 1
end

function Compiler:currentPos()
    return #self.instructions + 1
end

function Compiler:allocRegister()
    local reg = self.registers
    self.registers = self.registers + 1
    if self.registers > self.maxRegisters then
        self.maxRegisters = self.registers
    end
    return reg
end

function Compiler:freeRegister()
    self.registers = self.registers - 1
end

function Compiler:freeRegisters(n)
    self.registers = self.registers - n
end

function Compiler:addConstant(value)
    local key = type(value) .. ":" .. tostring(value)
    if self.constantLookup[key] then
        return self.constantLookup[key]
    end
    local idx = #self.constants
    self.constants[idx + 1] = value
    self.constantLookup[key] = idx
    return idx
end

function Compiler:declareLocal(id)
    local reg = self:allocRegister()
    self.locals[id] = reg
    return reg
end

function Compiler:resolveLocal(id)
    return self.locals[id]
end

function Compiler:resolveUpvalue(id)
    if not self.parentLocals then return nil end
    -- Check direct parent locals
    local parentReg = self.parentLocals[id]
    if parentReg then
        if not self.upvalues[id] then
            local idx = #self.upvalueList
            self.upvalueList[idx + 1] = { inParent = true, reg = parentReg }
            self.upvalues[id] = idx
        end
        return self.upvalues[id]
    end
    -- Check grandparent (parent's upvalues)
    if self.parentUpvalues and self.parentUpvalues[id] ~= nil then
        local parentUpIdx = self.parentUpvalues[id]
        if not self.upvalues[id] then
            local idx = #self.upvalueList
            self.upvalueList[idx + 1] = { inParent = false, idx = parentUpIdx }
            self.upvalues[id] = idx
        end
        return self.upvalues[id]
    end
    -- Check grandparent locals
    if self.parentParentLocals then
        local gpReg = self.parentParentLocals[id]
        if gpReg then
            if not self.upvalues[id] then
                local idx = #self.upvalueList
                self.upvalueList[idx + 1] = { inParent = false, reg = gpReg }
                self.upvalues[id] = idx
            end
            return self.upvalues[id]
        end
    end
    return nil
end

function Compiler:compileChunk(ast)
    self.instructions = {}
    self.constants = {}
    self.constantLookup = {}
    self.prototypes = {}
    self.registers = 0
    self.maxRegisters = 0
    self.locals = {}

    self:compileBlock(ast)
    self:emit(Op.RETURN, 0, 1, 0)

    return {
        instructions = self.instructions,
        constants = self.constants,
        prototypes = self.prototypes,
        maxRegisters = self.maxRegisters,
        numParams = 0,
    }
end

function Compiler:compileBlock(block)
    if not block or not block.body then return end
    for _, stmt in ipairs(block.body) do
        self:compileStatement(stmt)
    end
end

function Compiler:compileStatement(stmt)
    local kind = stmt.kind

    if kind == AstKind.LocalVariableDeclaration then
        self:compileLocalDecl(stmt)
    elseif kind == AstKind.AssignmentStatement then
        self:compileAssignment(stmt)
    elseif kind == AstKind.FunctionCallStatement then
        self:compileFunctionCall(stmt, nil)
    elseif kind == AstKind.PassSelfFunctionCallStatement then
        self:compilePassSelfCall(stmt, nil)
    elseif kind == AstKind.ReturnStatement then
        self:compileReturn(stmt)
    elseif kind == AstKind.IfStatement then
        self:compileIf(stmt)
    elseif kind == AstKind.WhileStatement then
        self:compileWhile(stmt)
    elseif kind == AstKind.RepeatStatement then
        self:compileRepeat(stmt)
    elseif kind == AstKind.ForStatement then
        self:compileFor(stmt)
    elseif kind == AstKind.ForInStatement then
        self:compileForIn(stmt)
    elseif kind == AstKind.DoStatement then
        self:compileBlock(stmt.body)
    elseif kind == AstKind.BreakStatement then
        self:compileBreak()
    elseif kind == AstKind.ContinueStatement then
        self:compileContinue()
    elseif kind == AstKind.CompoundAssignment then
        self:compileCompoundAssignment(stmt)
    elseif kind == AstKind.FunctionDeclaration or kind == AstKind.LocalFunctionDeclaration then
        self:compileFunctionDecl(stmt)
    end
end

function Compiler:compileExpression(node, dest)
    local kind = node.kind

    if kind == AstKind.NumberExpression then
        local k = self:addConstant(node.value)
        self:emit(Op.LOADK, dest, k)
    elseif kind == AstKind.StringExpression then
        local k = self:addConstant(node.value)
        self:emit(Op.LOADK, dest, k)
    elseif kind == AstKind.BooleanExpression then
        self:emit(Op.LOADBOOL, dest, node.value and 1 or 0, 0)
    elseif kind == AstKind.NilExpression then
        self:emit(Op.LOADNIL, dest, 0)
    elseif kind == AstKind.VariableExpression then
        local reg = self:resolveLocal(node.id)
        if reg then
            if reg ~= dest then
                self:emit(Op.MOVE, dest, reg)
            end
        else
            local upIdx = self:resolveUpvalue(node.id)
            if upIdx then
                self:emit(Op.GETUPVAL, dest, upIdx)
            else
                local k = self:addConstant(node.id.name or "_")
                self:emit(Op.GETGLOBAL, dest, k)
            end
        end
    elseif kind == AstKind.FunctionCallExpression then
        self:compileFunctionCall(node, dest)
    elseif kind == AstKind.PassSelfFunctionCallExpression then
        self:compilePassSelfCall(node, dest)
    elseif Ast.isBinaryExpression(node) then
        self:compileBinaryExpr(node, dest)
    elseif Ast.isUnaryExpression(node) then
        self:compileUnaryExpr(node, dest)
    elseif kind == AstKind.FunctionLiteralExpression then
        self:compileFunctionLiteral(node, dest)
    elseif kind == AstKind.TableConstructorExpression then
        self:compileTableConstructor(node, dest)
    elseif kind == AstKind.IndexExpression then
        local baseReg = self:allocRegister()
        self:compileExpression(node.base, baseReg)
        local indexReg = self:allocRegister()
        self:compileExpression(node.index, indexReg)
        self:emit(Op.GETTABLE, dest, baseReg, indexReg)
        self:freeRegisters(2)
    elseif kind == AstKind.MemberExpression then
        local baseReg = self:allocRegister()
        self:compileExpression(node.base, baseReg)
        local k = self:addConstant(node.member)
        self:emit(Op.GETTABLE, dest, baseReg, k + 256)
        self:freeRegister()
    elseif kind == AstKind.VarargExpression then
        self:emit(Op.VARARG, dest, 2)
    elseif kind == AstKind.IfElseExpression then
        self:compileIfElseExpr(node, dest)
    end
end

function Compiler:compileLocalDecl(stmt)
    for i, id in ipairs(stmt.ids) do
        local reg = self:declareLocal(id)
        if stmt.values[i] then
            self:compileExpression(stmt.values[i], reg)
        else
            self:emit(Op.LOADNIL, reg, 0)
        end
    end
end

function Compiler:compileAssignment(stmt)
    for i, lhs in ipairs(stmt.lhs) do
        local rhs = stmt.rhs[i]
        if not rhs then break end

        if lhs.kind == AstKind.AssignmentVariable then
            local reg = self:resolveLocal(lhs.id)
            if reg then
                self:compileExpression(rhs, reg)
            else
                local upIdx = self:resolveUpvalue(lhs.id)
                if upIdx then
                    local tempReg = self:allocRegister()
                    self:compileExpression(rhs, tempReg)
                    self:emit(Op.SETUPVAL, tempReg, upIdx)
                    self:freeRegister()
                else
                    local tempReg = self:allocRegister()
                    self:compileExpression(rhs, tempReg)
                    local k = self:addConstant(lhs.id.name or "_")
                    self:emit(Op.SETGLOBAL, tempReg, k)
                    self:freeRegister()
                end
            end
        elseif lhs.kind == AstKind.AssignmentIndexing then
            local baseReg = self:allocRegister()
            self:compileExpression(lhs.base, baseReg)
            local indexReg = self:allocRegister()
            self:compileExpression(lhs.index, indexReg)
            local valReg = self:allocRegister()
            self:compileExpression(rhs, valReg)
            self:emit(Op.SETTABLE, baseReg, indexReg, valReg)
            self:freeRegisters(3)
        elseif lhs.kind == AstKind.AssignmentMember then
            local baseReg = self:allocRegister()
            self:compileExpression(lhs.base, baseReg)
            local k = self:addConstant(lhs.member)
            local valReg = self:allocRegister()
            self:compileExpression(rhs, valReg)
            self:emit(Op.SETTABLE, baseReg, k + 256, valReg)
            self:freeRegisters(2)
        end
    end
end

function Compiler:compileFunctionCall(node, destBase)
    local baseReg = self:allocRegister()
    self:compileExpression(node.base, baseReg)

    for i, arg in ipairs(node.args) do
        local argReg = self:allocRegister()
        self:compileExpression(arg, argReg)
    end

    local nargs = #node.args + 1
    local nresults = destBase and 2 or 1
    self:emit(Op.CALL, baseReg, nargs, nresults)

    self:freeRegisters(#node.args)

    if destBase and destBase ~= baseReg then
        self:emit(Op.MOVE, destBase, baseReg)
    end
    if not destBase or destBase ~= baseReg then
        self:freeRegister()
    end
end

function Compiler:compilePassSelfCall(node, destBase)
    local baseReg = self:allocRegister()
    self:compileExpression(node.base, baseReg)
    local selfReg = self:allocRegister()
    local k = self:addConstant(node.passSelfFunctionName)
    self:emit(Op.SELF, selfReg, baseReg, k + 256)

    for i, arg in ipairs(node.args) do
        local argReg = self:allocRegister()
        self:compileExpression(arg, argReg)
    end

    local nargs = #node.args + 2
    self:emit(Op.CALL, selfReg, nargs, destBase and 2 or 1)
    self:freeRegisters(#node.args + 1)

    if destBase and destBase ~= baseReg then
        self:emit(Op.MOVE, destBase, baseReg)
    end
    if not destBase or destBase ~= baseReg then
        self:freeRegister()
    end
end

function Compiler:compileReturn(stmt)
    if #stmt.values == 0 then
        self:emit(Op.RETURN, 0, 1)
    else
        local baseReg = self:allocRegister()
        self:compileExpression(stmt.values[1], baseReg)
        for i = 2, #stmt.values do
            local reg = self:allocRegister()
            self:compileExpression(stmt.values[i], reg)
        end
        self:emit(Op.RETURN, baseReg, #stmt.values + 1)
        self:freeRegisters(#stmt.values)
    end
end

function Compiler:compileIf(stmt)
    local condReg = self:allocRegister()
    self:compileExpression(stmt.condition, condReg)
    local jumpFalse = self:emit(Op.TEST, condReg, 0, 0)
    local jumpOver = self:emit(Op.JMP, 0, 0)
    self:freeRegister()

    self:compileBlock(stmt.body)
    local jumpEnd = self:emit(Op.JMP, 0, 0)

    self:patchJump(jumpOver, self:currentPos())

    for _, elif in ipairs(stmt.elseifs) do
        condReg = self:allocRegister()
        self:compileExpression(elif.condition, condReg)
        local ejf = self:emit(Op.TEST, condReg, 0, 0)
        local ejo = self:emit(Op.JMP, 0, 0)
        self:freeRegister()
        self:compileBlock(elif.body)
        local prevEnd = jumpEnd
        jumpEnd = self:emit(Op.JMP, 0, 0)
        self:patchJump(ejo, self:currentPos())
        self:patchJump(prevEnd, self:currentPos())
    end

    if stmt.elseBody then
        self:compileBlock(stmt.elseBody)
    end

    self:patchJump(jumpEnd, self:currentPos())
end

function Compiler:compileWhile(stmt)
    local loopStart = self:currentPos()
    table.insert(self.loopStack, { breakJumps = {}, continueJumps = {}, start = loopStart })

    local condReg = self:allocRegister()
    self:compileExpression(stmt.condition, condReg)
    local jf = self:emit(Op.TEST, condReg, 0, 0)
    local jo = self:emit(Op.JMP, 0, 0)
    self:freeRegister()

    self:compileBlock(stmt.body)
    self:emit(Op.JMP, 0, loopStart - self:currentPos() - 1)
    self:patchJump(jo, self:currentPos())

    local loop = table.remove(self.loopStack)
    for _, j in ipairs(loop.breakJumps) do
        self:patchJump(j, self:currentPos())
    end
    for _, j in ipairs(loop.continueJumps) do
        self:patchJump(j, loopStart)
    end
end

function Compiler:compileRepeat(stmt)
    local loopStart = self:currentPos()
    table.insert(self.loopStack, { breakJumps = {}, continueJumps = {}, start = loopStart })

    self:compileBlock(stmt.body)

    local condReg = self:allocRegister()
    self:compileExpression(stmt.condition, condReg)
    self:emit(Op.TEST, condReg, 0, 0)
    self:emit(Op.JMP, 0, loopStart - self:currentPos() - 1)
    self:freeRegister()

    local loop = table.remove(self.loopStack)
    for _, j in ipairs(loop.breakJumps) do
        self:patchJump(j, self:currentPos())
    end
    for _, j in ipairs(loop.continueJumps) do
        self:patchJump(j, loopStart)
    end
end

function Compiler:compileFor(stmt)
    local initReg = self:declareLocal(stmt.varId)
    self:compileExpression(stmt.start, initReg)
    local limitReg = self:allocRegister()
    self:compileExpression(stmt.stop, limitReg)
    local stepReg = self:allocRegister()
    if stmt.step then
        self:compileExpression(stmt.step, stepReg)
    else
        self:emit(Op.LOADK, stepReg, self:addConstant(1))
    end

    local prepJump = self:emit(Op.FORPREP, initReg, 0)
    local loopStart = self:currentPos()
    table.insert(self.loopStack, { breakJumps = {}, continueJumps = {}, start = loopStart })

    self:compileBlock(stmt.body)

    local loop = table.remove(self.loopStack)
    for _, j in ipairs(loop.continueJumps) do
        self:patchJump(j, self:currentPos())
    end

    self:emit(Op.FORLOOP, initReg, loopStart - self:currentPos() - 1)
    self:patchJump(prepJump, self:currentPos() - 1)

    for _, j in ipairs(loop.breakJumps) do
        self:patchJump(j, self:currentPos())
    end

    self:freeRegisters(2)
end

function Compiler:compileForIn(stmt)
    local baseReg = self:allocRegister()
    local numIters = #stmt.iterators
    if numIters == 1 and (stmt.iterators[1].kind == AstKind.FunctionCallExpression or stmt.iterators[1].kind == AstKind.PassSelfFunctionCallExpression) then
        -- Single function call iterator: compile to fill 3 registers (iter, state, control)
        local node = stmt.iterators[1]
        self:compileExpression(node.base, baseReg)
        for _, arg in ipairs(node.args) do
            local argReg = self:allocRegister()
            self:compileExpression(arg, argReg)
        end
        local nargs = #node.args + 1
        self:emit(Op.CALL, baseReg, nargs, 4) -- 4 = 3 results
        self:freeRegisters(#node.args)
        while self.registers < baseReg + 3 do self:allocRegister() end
    else
        for i, iter in ipairs(stmt.iterators) do
            if i == 1 then
                self:compileExpression(iter, baseReg)
            else
                local reg = self:allocRegister()
                self:compileExpression(iter, reg)
            end
        end
        while self.registers < baseReg + 3 do
            self:allocRegister()
        end
    end

    for _, id in ipairs(stmt.ids) do
        self:declareLocal(id)
    end

    local loopStart = self:currentPos()
    table.insert(self.loopStack, { breakJumps = {}, continueJumps = {}, start = loopStart })

    local tfJump = self:emit(Op.TFORLOOP, baseReg, 0, #stmt.ids)
    local jmpOut = self:emit(Op.JMP, 0, 0)

    self:compileBlock(stmt.body)
    self:emit(Op.JMP, 0, loopStart - self:currentPos() - 1)
    self:patchJump(jmpOut, self:currentPos())

    local loop = table.remove(self.loopStack)
    for _, j in ipairs(loop.breakJumps) do
        self:patchJump(j, self:currentPos())
    end
end

function Compiler:compileBreak()
    if #self.loopStack == 0 then
        logger:error("break outside loop")
    end
    local loop = self.loopStack[#self.loopStack]
    local j = self:emit(Op.JMP, 0, 0)
    table.insert(loop.breakJumps, j)
end

function Compiler:compileContinue()
    if #self.loopStack == 0 then
        logger:error("continue outside loop")
    end
    local loop = self.loopStack[#self.loopStack]
    local j = self:emit(Op.JMP, 0, 0)
    table.insert(loop.continueJumps, j)
end

function Compiler:compileCompoundAssignment(stmt)
    local opMap = {
        ["+"] = Op.ADD, ["-"] = Op.SUB, ["*"] = Op.MUL,
        ["/"] = Op.DIV, ["//"] = Op.FLOORDIV, ["%"] = Op.MOD,
        ["^"] = Op.POW, [".."] = Op.CONCAT,
    }

    local lhsReg
    if stmt.lhs.kind == AstKind.VariableExpression then
        lhsReg = self:resolveLocal(stmt.lhs.id)
    end

    if lhsReg then
        local rhsReg = self:allocRegister()
        self:compileExpression(stmt.rhs, rhsReg)
        local vmOp = opMap[stmt.op] or Op.ADD
        self:emit(vmOp, lhsReg, lhsReg, rhsReg)
        self:freeRegister()
    end
end

local binOpMap = {
    [AstKind.AddExpression]    = Op.ADD,
    [AstKind.SubExpression]    = Op.SUB,
    [AstKind.MulExpression]    = Op.MUL,
    [AstKind.DivExpression]    = Op.DIV,
    [AstKind.FloorDivExpression] = Op.FLOORDIV,
    [AstKind.ModExpression]    = Op.MOD,
    [AstKind.PowExpression]    = Op.POW,
    [AstKind.StrCatExpression] = Op.CONCAT,
    [AstKind.LessThanExpression] = Op.LT,
    [AstKind.GreaterThanExpression] = Op.LT,
    [AstKind.LessThanOrEqualsExpression] = Op.LE,
    [AstKind.GreaterThanOrEqualsExpression] = Op.LE,
    [AstKind.EqualsExpression] = Op.EQ,
    [AstKind.NotEqualsExpression] = Op.EQ,
}

function Compiler:compileBinaryExpr(node, dest)
    local kind = node.kind

    if kind == AstKind.AndExpression then
        self:compileExpression(node.lhs, dest)
        local jmp = self:emit(Op.TEST, dest, 0, 0)
        local skip = self:emit(Op.JMP, 0, 0)
        self:compileExpression(node.rhs, dest)
        self:patchJump(skip, self:currentPos())
        return
    end

    if kind == AstKind.OrExpression then
        self:compileExpression(node.lhs, dest)
        local jmp = self:emit(Op.TEST, dest, 0, 1)
        local skip = self:emit(Op.JMP, 0, 0)
        self:compileExpression(node.rhs, dest)
        self:patchJump(skip, self:currentPos())
        return
    end

    local op = binOpMap[kind]
    if not op then
        logger:error("Unknown binary op: " .. kind)
    end

    local lhsReg = self:allocRegister()
    self:compileExpression(node.lhs, lhsReg)
    local rhsReg = self:allocRegister()
    self:compileExpression(node.rhs, rhsReg)

    if kind == AstKind.GreaterThanExpression or kind == AstKind.GreaterThanOrEqualsExpression then
        self:emit(op, 1, rhsReg, lhsReg)
    elseif kind == AstKind.NotEqualsExpression then
        self:emit(op, 0, lhsReg, rhsReg)
    else
        if op == Op.LT or op == Op.LE or op == Op.EQ then
            self:emit(op, 1, lhsReg, rhsReg)
        else
            self:emit(op, dest, lhsReg, rhsReg)
            self:freeRegisters(2)
            return
        end
    end

    local jmpTrue = self:emit(Op.JMP, 0, 1)
    self:emit(Op.LOADBOOL, dest, 0, 1)
    self:emit(Op.LOADBOOL, dest, 1, 0)
    self:freeRegisters(2)
end

function Compiler:compileUnaryExpr(node, dest)
    local exprReg = self:allocRegister()
    self:compileExpression(node.expression, exprReg)

    if node.kind == AstKind.NegateExpression then
        self:emit(Op.UNM, dest, exprReg)
    elseif node.kind == AstKind.NotExpression then
        self:emit(Op.NOT, dest, exprReg)
    elseif node.kind == AstKind.LenExpression then
        self:emit(Op.LEN, dest, exprReg)
    end

    self:freeRegister()
end

function Compiler:compileFunctionLiteral(node, dest)
    local subCompiler = Compiler:new()
    subCompiler.instructions = {}
    subCompiler.constants = {}
    subCompiler.constantLookup = {}
    subCompiler.prototypes = {}
    subCompiler.registers = 0
    subCompiler.maxRegisters = 0
    subCompiler.locals = {}
    subCompiler.loopStack = {}
    subCompiler.parentLocals = self.locals
    subCompiler.parentUpvalues = self.upvalues or {}
    subCompiler.parentParentLocals = self.parentLocals
    subCompiler.upvalues = {}
    subCompiler.upvalueList = {}

    -- Declare params AFTER init so they aren't cleared
    for _, arg in ipairs(node.args) do
        if arg.kind == AstKind.VariableExpression then
            subCompiler:declareLocal(arg.id)
        end
    end

    subCompiler:compileBlock(node.body)
    subCompiler:emit(Op.RETURN, 0, 1, 0)

    local proto = {
        instructions = subCompiler.instructions,
        constants = subCompiler.constants,
        prototypes = subCompiler.prototypes,
        numParams = #node.args,
        upvalues = subCompiler.upvalueList,
    }

    local protoIdx = #self.prototypes
    self.prototypes[protoIdx + 1] = proto
    self:emit(Op.CLOSURE, dest, protoIdx)
end

function Compiler:compileFunctionDecl(stmt)
    local reg
    if stmt.kind == AstKind.LocalFunctionDeclaration then
        reg = self:declareLocal(stmt.id)
    else
        reg = self:allocRegister()
    end
    self:compileFunctionLiteral({
        kind = AstKind.FunctionLiteralExpression,
        args = stmt.args,
        body = stmt.body,
    }, reg)

    if stmt.kind == AstKind.FunctionDeclaration then
        local k = self:addConstant(stmt.id.name or "_")
        self:emit(Op.SETGLOBAL, reg, k)
        self:freeRegister()
    end
end

function Compiler:compileTableConstructor(node, dest)
    self:emit(Op.NEWTABLE, dest, #node.entries, 0)
    local arrayIdx = 1
    for _, entry in ipairs(node.entries) do
        if entry.kind == AstKind.TableEntry then
            local valReg = self:allocRegister()
            self:compileExpression(entry.value, valReg)
            local keyConst = self:addConstant(arrayIdx)
            self:emit(Op.SETTABLE, dest, keyConst + 256, valReg)
            self:freeRegister()
            arrayIdx = arrayIdx + 1
        elseif entry.kind == AstKind.KeyedTableEntry then
            local keyReg = self:allocRegister()
            self:compileExpression(entry.key, keyReg)
            local valReg = self:allocRegister()
            self:compileExpression(entry.value, valReg)
            self:emit(Op.SETTABLE, dest, keyReg, valReg)
            self:freeRegisters(2)
        end
    end
end

function Compiler:compileIfElseExpr(node, dest)
    local condReg = self:allocRegister()
    self:compileExpression(node.condition, condReg)
    self:emit(Op.TEST, condReg, 0, 0)
    local jmpElse = self:emit(Op.JMP, 0, 0)
    self:freeRegister()

    self:compileExpression(node.ifExpr, dest)
    local jmpEnd = self:emit(Op.JMP, 0, 0)

    self:patchJump(jmpElse, self:currentPos())
    self:compileExpression(node.elseExpr, dest)
    self:patchJump(jmpEnd, self:currentPos())
end

return Compiler
