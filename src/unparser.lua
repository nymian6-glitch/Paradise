-- Aegis LuaU Obfuscator
-- unparser.lua -- Convert AST back to LuaU source

local Ast = require("ast")
local AstKind = Ast.AstKind

local Unparser = {}

function Unparser:new(options)
    local unparser = {
        options = options or {},
        prettyPrint = options and options.PrettyPrint or false,
        indent = 0,
        nameMap = {},
        nameCounter = 0,
        output = {},
    }
    setmetatable(unparser, self)
    self.__index = self
    return unparser
end

function Unparser:emit(str)
    self.output[#self.output + 1] = str
end

function Unparser:newline()
    if self.prettyPrint then
        self:emit("\n" .. string.rep("    ", self.indent))
    else
        self:emit(" ")
    end
end

function Unparser:getName(id)
    if not id then return "_" end
    if id.obfuscatedName then return id.obfuscatedName end
    if id.name then return id.name end
    if self.nameMap[id] then return self.nameMap[id] end
    self.nameCounter = self.nameCounter + 1
    local name = "v" .. self.nameCounter
    self.nameMap[id] = name
    return name
end

function Unparser:unparse(ast)
    self.output = {}
    self.nameCounter = 0
    self.nameMap = {}
    self:emitNode(ast)
    return table.concat(self.output)
end

function Unparser:escapeString(s)
    local result = {}
    for i = 1, #s do
        local b = s:byte(i)
        if b == 0 then result[#result + 1] = "\\0"
        elseif b == 7 then result[#result + 1] = "\\a"
        elseif b == 8 then result[#result + 1] = "\\b"
        elseif b == 9 then result[#result + 1] = "\\t"
        elseif b == 10 then result[#result + 1] = "\\n"
        elseif b == 11 then result[#result + 1] = "\\v"
        elseif b == 12 then result[#result + 1] = "\\f"
        elseif b == 13 then result[#result + 1] = "\\r"
        elseif b == 34 then result[#result + 1] = "\\\""
        elseif b == 92 then result[#result + 1] = "\\\\"
        elseif b < 32 or b > 126 then
            result[#result + 1] = string.format("\\%d", b)
        else
            result[#result + 1] = s:sub(i, i)
        end
    end
    return table.concat(result)
end

function Unparser:emitNode(node)
    if not node then return end
    local kind = node.kind
    local handler = self["emit_" .. kind]
    if handler then
        handler(self, node)
    else
        error("Unparser: unhandled node kind: " .. tostring(kind))
    end
end

-- Block
function Unparser:emit_Block(node)
    for i, stmt in ipairs(node.body) do
        if i > 1 then self:emit(";") end
        self:newline()
        self:emitNode(stmt)
    end
end

-- Expressions
function Unparser:emit_NumberExpression(node)
    if type(node.value) == "string" then
        self:emit(node.value)
    else
        local n = node.value
        if n == math.floor(n) and math.abs(n) < 2^53 then
            self:emit(string.format("%.0f", n))
        else
            self:emit(string.format("%.17g", n))
        end
    end
end

function Unparser:emit_StringExpression(node)
    self:emit("\"" .. self:escapeString(node.value) .. "\"")
end

function Unparser:emit_BooleanExpression(node)
    self:emit(tostring(node.value))
end

function Unparser:emit_NilExpression()
    self:emit("nil")
end

function Unparser:emit_VarargExpression()
    self:emit("...")
end

function Unparser:emit_VariableExpression(node)
    self:emit(self:getName(node.id))
end

function Unparser:emit_IndexExpression(node)
    self:emitNode(node.base)
    self:emit("[")
    self:emitNode(node.index)
    self:emit("]")
end

function Unparser:emit_MemberExpression(node)
    self:emitNode(node.base)
    self:emit(".")
    self:emit(node.member)
end

function Unparser:emit_FunctionCallExpression(node)
    local needsParens = node.base and node.base.kind == AstKind.FunctionLiteralExpression
    if needsParens then self:emit("(") end
    self:emitNode(node.base)
    if needsParens then self:emit(")") end
    self:emit("(")
    for i, arg in ipairs(node.args) do
        if i > 1 then self:emit(",") end
        self:emitNode(arg)
    end
    self:emit(")")
end

function Unparser:emit_PassSelfFunctionCallExpression(node)
    self:emitNode(node.base)
    self:emit(":")
    self:emit(node.passSelfFunctionName)
    self:emit("(")
    for i, arg in ipairs(node.args) do
        if i > 1 then self:emit(",") end
        self:emitNode(arg)
    end
    self:emit(")")
end

function Unparser:emit_FunctionLiteralExpression(node)
    self:emit("function(")
    for i, arg in ipairs(node.args) do
        if i > 1 then self:emit(",") end
        self:emitNode(arg)
    end
    self:emit(")")
    self.indent = self.indent + 1
    self:emitNode(node.body)
    self.indent = self.indent - 1
    self:newline()
    self:emit("end")
end

function Unparser:emit_TableConstructorExpression(node)
    self:emit("{")
    for i, entry in ipairs(node.entries) do
        if i > 1 then self:emit(",") end
        self:emitNode(entry)
    end
    self:emit("}")
end

function Unparser:emit_TableEntry(node)
    self:emitNode(node.value)
end

function Unparser:emit_KeyedTableEntry(node)
    if node.key.kind == AstKind.StringExpression and node.key.value:match("^[%a_][%w_]*$") then
        self:emit(node.key.value)
    else
        self:emit("[")
        self:emitNode(node.key)
        self:emit("]")
    end
    self:emit("=")
    self:emitNode(node.value)
end

function Unparser:emit_IfElseExpression(node)
    self:emit("if ")
    self:emitNode(node.condition)
    self:emit(" then ")
    self:emitNode(node.ifExpr)
    self:emit(" else ")
    self:emitNode(node.elseExpr)
end

function Unparser:emit_InterpolatedStringExpression(node)
    self:emit("`")
    for _, part in ipairs(node.parts) do
        if part.type == "string" then
            self:emit(part.value)
        else
            self:emit("{" .. part.value .. "}")
        end
    end
    self:emit("`")
end

-- Binary expressions
local precedence = {
    ["or"]  = 1,
    ["and"] = 2,
    ["<"]   = 3, [">"]  = 3, ["<="] = 3, [">="] = 3, ["=="] = 3, ["~="] = 3,
    [".."]  = 4,
    ["+"]   = 5, ["-"]  = 5,
    ["*"]   = 6, ["/"]  = 6, ["//"] = 6, ["%"] = 6,
    ["^"]   = 8,
}
local rightAssoc = { [".."] = true, ["^"] = true }

local function isUnaryNode(node)
    return node.kind == Ast.AstKind.NegateExpression
        or node.kind == Ast.AstKind.NotExpression
        or node.kind == Ast.AstKind.LenExpression
end

local function needsParens(childNode, parentOp, isRight)
    -- Unary minus before ^ needs parens: (-x)^y
    if not isRight and parentOp == "^" and isUnaryNode(childNode) then
        return true
    end
    if not Ast.isBinaryExpression(childNode) then return false end
    local childOp = Ast.getBinaryOperator(childNode)
    local parentPrec = precedence[parentOp] or 0
    local childPrec = precedence[childOp] or 0
    if childPrec < parentPrec then return true end
    if childPrec == parentPrec then
        if isRight and not rightAssoc[parentOp] then return true end
        if not isRight and rightAssoc[parentOp] then return true end
    end
    return false
end

local function emitBinary(self, node, op)
    local wrapLhs = needsParens(node.lhs, op, false)
    local wrapRhs = needsParens(node.rhs, op, true)

    if wrapLhs then self:emit("(") end
    self:emitNode(node.lhs)
    if wrapLhs then self:emit(")") end
    self:emit(" " .. op .. " ")
    if wrapRhs then self:emit("(") end
    self:emitNode(node.rhs)
    if wrapRhs then self:emit(")") end
end

for kind, op in pairs(Ast.BinaryKinds) do
    Unparser["emit_" .. kind] = function(self, node)
        emitBinary(self, node, op)
    end
end

-- Unary expressions
function Unparser:emit_NotExpression(node)
    self:emit("not ")
    self:emitNode(node.expression)
end

function Unparser:emit_NegateExpression(node)
    self:emit("-")
    self:emitNode(node.expression)
end

function Unparser:emit_LenExpression(node)
    self:emit("#")
    self:emitNode(node.expression)
end

-- Statements
function Unparser:emit_AssignmentStatement(node)
    for i, lhs in ipairs(node.lhs) do
        if i > 1 then self:emit(",") end
        self:emitNode(lhs)
    end
    self:emit("=")
    for i, rhs in ipairs(node.rhs) do
        if i > 1 then self:emit(",") end
        self:emitNode(rhs)
    end
end

function Unparser:emit_AssignmentVariable(node)
    self:emit(self:getName(node.id))
end

function Unparser:emit_AssignmentIndexing(node)
    self:emitNode(node.base)
    self:emit("[")
    self:emitNode(node.index)
    self:emit("]")
end

function Unparser:emit_AssignmentMember(node)
    self:emitNode(node.base)
    self:emit(".")
    self:emit(node.member)
end

function Unparser:emit_LocalVariableDeclaration(node)
    self:emit("local ")
    for i, id in ipairs(node.ids) do
        if i > 1 then self:emit(",") end
        self:emit(self:getName(id))
    end
    if #node.values > 0 then
        self:emit("=")
        for i, val in ipairs(node.values) do
            if i > 1 then self:emit(",") end
            self:emitNode(val)
        end
    end
end

function Unparser:emit_DoStatement(node)
    self:emit("do")
    self.indent = self.indent + 1
    self:emitNode(node.body)
    self.indent = self.indent - 1
    self:newline()
    self:emit("end")
end

function Unparser:emit_WhileStatement(node)
    self:emit("while ")
    self:emitNode(node.condition)
    self:emit(" do")
    self.indent = self.indent + 1
    self:emitNode(node.body)
    self.indent = self.indent - 1
    self:newline()
    self:emit("end")
end

function Unparser:emit_RepeatStatement(node)
    self:emit("repeat")
    self.indent = self.indent + 1
    self:emitNode(node.body)
    self.indent = self.indent - 1
    self:newline()
    self:emit("until ")
    self:emitNode(node.condition)
end

function Unparser:emit_IfStatement(node)
    self:emit("if ")
    self:emitNode(node.condition)
    self:emit(" then")
    self.indent = self.indent + 1
    self:emitNode(node.body)
    self.indent = self.indent - 1

    for _, elif in ipairs(node.elseifs) do
        self:newline()
        self:emit("elseif ")
        self:emitNode(elif.condition)
        self:emit(" then")
        self.indent = self.indent + 1
        self:emitNode(elif.body)
        self.indent = self.indent - 1
    end

    if node.elseBody then
        self:newline()
        self:emit("else")
        self.indent = self.indent + 1
        self:emitNode(node.elseBody)
        self.indent = self.indent - 1
    end

    self:newline()
    self:emit("end")
end

function Unparser:emit_ForStatement(node)
    self:emit("for ")
    self:emit(self:getName(node.varId))
    self:emit("=")
    self:emitNode(node.start)
    self:emit(",")
    self:emitNode(node.stop)
    if node.step then
        self:emit(",")
        self:emitNode(node.step)
    end
    self:emit(" do")
    self.indent = self.indent + 1
    self:emitNode(node.body)
    self.indent = self.indent - 1
    self:newline()
    self:emit("end")
end

function Unparser:emit_ForInStatement(node)
    self:emit("for ")
    for i, id in ipairs(node.ids) do
        if i > 1 then self:emit(",") end
        self:emit(self:getName(id))
    end
    self:emit(" in ")
    for i, iter in ipairs(node.iterators) do
        if i > 1 then self:emit(",") end
        self:emitNode(iter)
    end
    self:emit(" do")
    self.indent = self.indent + 1
    self:emitNode(node.body)
    self.indent = self.indent - 1
    self:newline()
    self:emit("end")
end

function Unparser:emit_ReturnStatement(node)
    self:emit("return")
    if #node.values > 0 then
        self:emit(" ")
        for i, val in ipairs(node.values) do
            if i > 1 then self:emit(",") end
            self:emitNode(val)
        end
    end
end

function Unparser:emit_BreakStatement()
    self:emit("break")
end

function Unparser:emit_ContinueStatement()
    self:emit("continue")
end

function Unparser:emit_FunctionDeclaration(node)
    self:emit("function ")
    self:emit(self:getName(node.id))
    self:emit("(")
    for i, arg in ipairs(node.args) do
        if i > 1 then self:emit(",") end
        self:emitNode(arg)
    end
    self:emit(")")
    self.indent = self.indent + 1
    self:emitNode(node.body)
    self.indent = self.indent - 1
    self:newline()
    self:emit("end")
end

function Unparser:emit_LocalFunctionDeclaration(node)
    self:emit("local function ")
    self:emit(self:getName(node.id))
    self:emit("(")
    for i, arg in ipairs(node.args) do
        if i > 1 then self:emit(",") end
        self:emitNode(arg)
    end
    self:emit(")")
    self.indent = self.indent + 1
    self:emitNode(node.body)
    self.indent = self.indent - 1
    self:newline()
    self:emit("end")
end

function Unparser:emit_FunctionCallStatement(node)
    local needsParens = node.base and node.base.kind == AstKind.FunctionLiteralExpression
    if needsParens then self:emit("(") end
    self:emitNode(node.base)
    if needsParens then self:emit(")") end
    self:emit("(")
    for i, arg in ipairs(node.args) do
        if i > 1 then self:emit(",") end
        self:emitNode(arg)
    end
    self:emit(")")
end

function Unparser:emit_PassSelfFunctionCallStatement(node)
    self:emitNode(node.base)
    self:emit(":")
    self:emit(node.passSelfFunctionName)
    self:emit("(")
    for i, arg in ipairs(node.args) do
        if i > 1 then self:emit(",") end
        self:emitNode(arg)
    end
    self:emit(")")
end

function Unparser:emit_CompoundAssignment(node)
    self:emitNode(node.lhs)
    self:emit(node.op .. "=")
    self:emitNode(node.rhs)
end

return Unparser
