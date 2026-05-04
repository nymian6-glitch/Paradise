-- Aegis LuaU Obfuscator
-- ast.lua -- AST node definitions for LuaU

local Ast = {}

Ast.AstKind = {
    -- Expressions
    NumberExpression       = "NumberExpression",
    StringExpression       = "StringExpression",
    BooleanExpression      = "BooleanExpression",
    NilExpression          = "NilExpression",
    VarargExpression       = "VarargExpression",
    VariableExpression     = "VariableExpression",
    IndexExpression        = "IndexExpression",
    MemberExpression       = "MemberExpression",
    FunctionCallExpression = "FunctionCallExpression",
    PassSelfFunctionCallExpression = "PassSelfFunctionCallExpression",
    FunctionLiteralExpression = "FunctionLiteralExpression",
    TableConstructorExpression = "TableConstructorExpression",
    -- Binary
    AddExpression          = "AddExpression",
    SubExpression          = "SubExpression",
    MulExpression          = "MulExpression",
    DivExpression          = "DivExpression",
    FloorDivExpression     = "FloorDivExpression",
    ModExpression          = "ModExpression",
    PowExpression          = "PowExpression",
    StrCatExpression       = "StrCatExpression",
    -- Comparison
    LessThanExpression     = "LessThanExpression",
    GreaterThanExpression  = "GreaterThanExpression",
    LessThanOrEqualsExpression = "LessThanOrEqualsExpression",
    GreaterThanOrEqualsExpression = "GreaterThanOrEqualsExpression",
    EqualsExpression       = "EqualsExpression",
    NotEqualsExpression    = "NotEqualsExpression",
    -- Logical
    AndExpression          = "AndExpression",
    OrExpression           = "OrExpression",
    -- Unary
    NotExpression          = "NotExpression",
    NegateExpression       = "NegateExpression",
    LenExpression          = "LenExpression",
    -- Statements
    Block                  = "Block",
    AssignmentStatement    = "AssignmentStatement",
    LocalVariableDeclaration = "LocalVariableDeclaration",
    DoStatement            = "DoStatement",
    WhileStatement         = "WhileStatement",
    RepeatStatement        = "RepeatStatement",
    IfStatement            = "IfStatement",
    ForStatement           = "ForStatement",
    ForInStatement         = "ForInStatement",
    ReturnStatement        = "ReturnStatement",
    BreakStatement         = "BreakStatement",
    ContinueStatement      = "ContinueStatement",
    FunctionDeclaration    = "FunctionDeclaration",
    LocalFunctionDeclaration = "LocalFunctionDeclaration",
    FunctionCallStatement  = "FunctionCallStatement",
    PassSelfFunctionCallStatement = "PassSelfFunctionCallStatement",
    -- Compound assignment (LuaU)
    CompoundAssignment     = "CompoundAssignment",
    -- Type annotation (LuaU) - stored but ignored in obfuscation
    TypeAnnotation         = "TypeAnnotation",
    -- Table
    TableEntry             = "TableEntry",
    KeyedTableEntry        = "KeyedTableEntry",
    -- Special
    AssignmentVariable     = "AssignmentVariable",
    AssignmentIndexing     = "AssignmentIndexing",
    AssignmentMember       = "AssignmentMember",
    -- If-else expression (LuaU)
    IfElseExpression       = "IfElseExpression",
    -- Interpolated string (LuaU)
    InterpolatedStringExpression = "InterpolatedStringExpression",
}

local AstKind = Ast.AstKind

local function node(kind, data)
    data = data or {}
    data.kind = kind
    return data
end

-- Expression constructors
function Ast.NumberExpression(value)
    return node(AstKind.NumberExpression, { value = value })
end

function Ast.StringExpression(value)
    return node(AstKind.StringExpression, { value = value })
end

function Ast.BooleanExpression(value)
    return node(AstKind.BooleanExpression, { value = value })
end

function Ast.NilExpression()
    return node(AstKind.NilExpression)
end

function Ast.VarargExpression()
    return node(AstKind.VarargExpression)
end

function Ast.VariableExpression(scope, id)
    return node(AstKind.VariableExpression, { scope = scope, id = id })
end

function Ast.IndexExpression(base, index)
    return node(AstKind.IndexExpression, { base = base, index = index })
end

function Ast.MemberExpression(base, member)
    return node(AstKind.MemberExpression, { base = base, member = member })
end

function Ast.FunctionCallExpression(base, args)
    return node(AstKind.FunctionCallExpression, { base = base, args = args or {} })
end

function Ast.PassSelfFunctionCallExpression(base, passSelfFunctionName, args)
    return node(AstKind.PassSelfFunctionCallExpression, {
        base = base, passSelfFunctionName = passSelfFunctionName, args = args or {}
    })
end

function Ast.FunctionLiteralExpression(args, body)
    return node(AstKind.FunctionLiteralExpression, { args = args or {}, body = body })
end

function Ast.TableConstructorExpression(entries)
    return node(AstKind.TableConstructorExpression, { entries = entries or {} })
end

-- Binary expression constructors
local function binExpr(kind)
    return function(lhs, rhs, parens)
        return node(kind, { lhs = lhs, rhs = rhs, parens = parens })
    end
end

Ast.AddExpression = binExpr(AstKind.AddExpression)
Ast.SubExpression = binExpr(AstKind.SubExpression)
Ast.MulExpression = binExpr(AstKind.MulExpression)
Ast.DivExpression = binExpr(AstKind.DivExpression)
Ast.FloorDivExpression = binExpr(AstKind.FloorDivExpression)
Ast.ModExpression = binExpr(AstKind.ModExpression)
Ast.PowExpression = binExpr(AstKind.PowExpression)
Ast.StrCatExpression = binExpr(AstKind.StrCatExpression)
Ast.LessThanExpression = binExpr(AstKind.LessThanExpression)
Ast.GreaterThanExpression = binExpr(AstKind.GreaterThanExpression)
Ast.LessThanOrEqualsExpression = binExpr(AstKind.LessThanOrEqualsExpression)
Ast.GreaterThanOrEqualsExpression = binExpr(AstKind.GreaterThanOrEqualsExpression)
Ast.EqualsExpression = binExpr(AstKind.EqualsExpression)
Ast.NotEqualsExpression = binExpr(AstKind.NotEqualsExpression)
Ast.AndExpression = binExpr(AstKind.AndExpression)
Ast.OrExpression = binExpr(AstKind.OrExpression)

-- Unary expression constructors
function Ast.NotExpression(expr)
    return node(AstKind.NotExpression, { expression = expr })
end

function Ast.NegateExpression(expr)
    return node(AstKind.NegateExpression, { expression = expr })
end

function Ast.LenExpression(expr)
    return node(AstKind.LenExpression, { expression = expr })
end

-- Statement constructors
function Ast.Block(body, scope)
    return node(AstKind.Block, { body = body or {}, scope = scope })
end

function Ast.AssignmentStatement(lhs, rhs)
    return node(AstKind.AssignmentStatement, { lhs = lhs, rhs = rhs })
end

function Ast.LocalVariableDeclaration(scope, ids, values)
    return node(AstKind.LocalVariableDeclaration, { scope = scope, ids = ids or {}, values = values or {} })
end

function Ast.DoStatement(body)
    return node(AstKind.DoStatement, { body = body })
end

function Ast.WhileStatement(condition, body)
    return node(AstKind.WhileStatement, { condition = condition, body = body })
end

function Ast.RepeatStatement(condition, body)
    return node(AstKind.RepeatStatement, { condition = condition, body = body })
end

function Ast.IfStatement(condition, body, elseifs, elseBody)
    return node(AstKind.IfStatement, {
        condition = condition, body = body,
        elseifs = elseifs or {}, elseBody = elseBody
    })
end

function Ast.ForStatement(scope, varId, start, stop, step, body)
    return node(AstKind.ForStatement, {
        scope = scope, varId = varId,
        start = start, stop = stop, step = step, body = body
    })
end

function Ast.ForInStatement(scope, ids, iterators, body)
    return node(AstKind.ForInStatement, {
        scope = scope, ids = ids, iterators = iterators, body = body
    })
end

function Ast.ReturnStatement(values)
    return node(AstKind.ReturnStatement, { values = values or {} })
end

function Ast.BreakStatement()
    return node(AstKind.BreakStatement)
end

function Ast.ContinueStatement()
    return node(AstKind.ContinueStatement)
end

function Ast.FunctionDeclaration(scope, id, isLocal, args, body)
    return node(AstKind.FunctionDeclaration, {
        scope = scope, id = id, isLocal = isLocal,
        args = args or {}, body = body
    })
end

function Ast.LocalFunctionDeclaration(scope, id, args, body)
    return node(AstKind.LocalFunctionDeclaration, {
        scope = scope, id = id, args = args or {}, body = body
    })
end

function Ast.FunctionCallStatement(base, args)
    return node(AstKind.FunctionCallStatement, { base = base, args = args or {} })
end

function Ast.PassSelfFunctionCallStatement(base, passSelfFunctionName, args)
    return node(AstKind.PassSelfFunctionCallStatement, {
        base = base, passSelfFunctionName = passSelfFunctionName, args = args or {}
    })
end

function Ast.CompoundAssignment(op, lhs, rhs)
    return node(AstKind.CompoundAssignment, { op = op, lhs = lhs, rhs = rhs })
end

-- Table entries
function Ast.TableEntry(value)
    return node(AstKind.TableEntry, { value = value })
end

function Ast.KeyedTableEntry(key, value)
    return node(AstKind.KeyedTableEntry, { key = key, value = value })
end

-- Assignment targets
function Ast.AssignmentVariable(scope, id)
    return node(AstKind.AssignmentVariable, { scope = scope, id = id })
end

function Ast.AssignmentIndexing(base, index)
    return node(AstKind.AssignmentIndexing, { base = base, index = index })
end

function Ast.AssignmentMember(base, member)
    return node(AstKind.AssignmentMember, { base = base, member = member })
end

-- LuaU specific
function Ast.IfElseExpression(condition, ifExpr, elseExpr)
    return node(AstKind.IfElseExpression, {
        condition = condition, ifExpr = ifExpr, elseExpr = elseExpr
    })
end

function Ast.InterpolatedStringExpression(parts)
    return node(AstKind.InterpolatedStringExpression, { parts = parts or {} })
end

function Ast.ConstantNode(value)
    local t = type(value)
    if t == "number" then
        return Ast.NumberExpression(value)
    elseif t == "string" then
        return Ast.StringExpression(value)
    elseif t == "boolean" then
        return Ast.BooleanExpression(value)
    else
        return Ast.NilExpression()
    end
end

-- Helpers to check node categories
local binaryKinds = {
    [AstKind.AddExpression] = "+",
    [AstKind.SubExpression] = "-",
    [AstKind.MulExpression] = "*",
    [AstKind.DivExpression] = "/",
    [AstKind.FloorDivExpression] = "//",
    [AstKind.ModExpression] = "%",
    [AstKind.PowExpression] = "^",
    [AstKind.StrCatExpression] = "..",
    [AstKind.LessThanExpression] = "<",
    [AstKind.GreaterThanExpression] = ">",
    [AstKind.LessThanOrEqualsExpression] = "<=",
    [AstKind.GreaterThanOrEqualsExpression] = ">=",
    [AstKind.EqualsExpression] = "==",
    [AstKind.NotEqualsExpression] = "~=",
    [AstKind.AndExpression] = "and",
    [AstKind.OrExpression] = "or",
}

Ast.BinaryKinds = binaryKinds

function Ast.isBinaryExpression(node)
    return binaryKinds[node.kind] ~= nil
end

function Ast.getBinaryOperator(node)
    return binaryKinds[node.kind]
end

local unaryKinds = {
    [AstKind.NotExpression] = "not ",
    [AstKind.NegateExpression] = "-",
    [AstKind.LenExpression] = "#",
}

Ast.UnaryKinds = unaryKinds

function Ast.isUnaryExpression(node)
    return unaryKinds[node.kind] ~= nil
end

function Ast.isExpression(node)
    local k = node.kind
    return k == AstKind.NumberExpression
        or k == AstKind.StringExpression
        or k == AstKind.BooleanExpression
        or k == AstKind.NilExpression
        or k == AstKind.VarargExpression
        or k == AstKind.VariableExpression
        or k == AstKind.IndexExpression
        or k == AstKind.MemberExpression
        or k == AstKind.FunctionCallExpression
        or k == AstKind.PassSelfFunctionCallExpression
        or k == AstKind.FunctionLiteralExpression
        or k == AstKind.TableConstructorExpression
        or k == AstKind.IfElseExpression
        or k == AstKind.InterpolatedStringExpression
        or Ast.isBinaryExpression(node)
        or Ast.isUnaryExpression(node)
end

function Ast.isStatement(node)
    local k = node.kind
    return k == AstKind.AssignmentStatement
        or k == AstKind.LocalVariableDeclaration
        or k == AstKind.DoStatement
        or k == AstKind.WhileStatement
        or k == AstKind.RepeatStatement
        or k == AstKind.IfStatement
        or k == AstKind.ForStatement
        or k == AstKind.ForInStatement
        or k == AstKind.ReturnStatement
        or k == AstKind.BreakStatement
        or k == AstKind.ContinueStatement
        or k == AstKind.FunctionDeclaration
        or k == AstKind.LocalFunctionDeclaration
        or k == AstKind.FunctionCallStatement
        or k == AstKind.PassSelfFunctionCallStatement
        or k == AstKind.CompoundAssignment
end

return Ast
