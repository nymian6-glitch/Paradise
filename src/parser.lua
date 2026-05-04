-- Aegis LuaU Obfuscator
-- parser.lua -- LuaU parser producing AST

local Ast = require("ast")
local Scope = require("scope")
local Lexer = require("lexer")
local logger = require("logger")

local AstKind = Ast.AstKind
local TK = Lexer.TokenKind

local Parser = {}

function Parser:new(options)
    local parser = {
        options = options or {},
    }
    setmetatable(parser, self)
    self.__index = self
    return parser
end

function Parser:parse(source, filename)
    self.lexer = Lexer:new(source, filename)
    self.globalScope = Scope:newGlobal()
    self.currentScope = self.globalScope

    local block = self:parseBlock()
    self.lexer:expect(TK.Eof)
    return block
end

function Parser:pushScope()
    self.currentScope = Scope:new(self.currentScope)
    return self.currentScope
end

function Parser:popScope()
    self.currentScope = self.currentScope:getParent()
end

function Parser:error(msg)
    local tok = self.lexer:peekToken()
    logger:error(string.format("%s:%d:%d: %s (got %s '%s')",
        self.lexer.filename, tok.line, tok.col, msg, tok.kind, tostring(tok.value)))
end

-- Skip LuaU type annotations
function Parser:skipTypeAnnotation()
    if self.lexer:check(TK.Symbol, ":") then
        self.lexer:nextToken()
        self:skipType()
    end
end

function Parser:skipReturnTypeAnnotation()
    if self.lexer:check(TK.Symbol, "->") then
        self.lexer:nextToken()
        self:skipType()
    end
end

function Parser:skipType()
    self:skipSimpleType()
    while self.lexer:consume(TK.Symbol, "|") or self.lexer:consume(TK.Symbol, "&") do
        self:skipSimpleType()
    end
    if self.lexer:check(TK.Symbol, "->") then
        self.lexer:nextToken()
        self:skipType()
    end
end

function Parser:skipSimpleType()
    if self.lexer:consume(TK.Symbol, "(") then
        if not self.lexer:check(TK.Symbol, ")") then
            self:skipType()
            while self.lexer:consume(TK.Symbol, ",") do
                self:skipType()
            end
        end
        self.lexer:expect(TK.Symbol, ")")
        return
    end

    if self.lexer:consume(TK.Symbol, "{") then
        if not self.lexer:check(TK.Symbol, "}") then
            if self.lexer:check(TK.Symbol, "[") then
                self.lexer:nextToken()
                self:skipType()
                self.lexer:expect(TK.Symbol, "]")
                self.lexer:expect(TK.Symbol, ":")
                self:skipType()
            else
                self:skipType()
                if self.lexer:consume(TK.Symbol, ",") then
                    self:skipType()
                    while self.lexer:consume(TK.Symbol, ",") do
                        self:skipType()
                    end
                end
            end
        end
        self.lexer:expect(TK.Symbol, "}")
        return
    end

    if self.lexer:consume(TK.Keyword, "typeof") then
        self.lexer:expect(TK.Symbol, "(")
        self:parseExpression()
        self.lexer:expect(TK.Symbol, ")")
        return
    end

    if self.lexer:consume(TK.Keyword, "nil") then return end
    if self.lexer:consume(TK.Keyword, "true") then return end
    if self.lexer:consume(TK.Keyword, "false") then return end
    if self.lexer:check(TK.String) then self.lexer:nextToken(); return end

    if self.lexer:check(TK.Name) then
        self.lexer:nextToken()
        while self.lexer:consume(TK.Symbol, ".") do
            self.lexer:expect(TK.Name)
        end
        if self.lexer:consume(TK.Symbol, "<") then
            self:skipType()
            while self.lexer:consume(TK.Symbol, ",") do
                self:skipType()
            end
            self.lexer:expect(TK.Symbol, ">")
        end
    end

    if self.lexer:consume(TK.Symbol, "?") then end
end

function Parser:skipGenericParams()
    if self.lexer:consume(TK.Symbol, "<") then
        self.lexer:expect(TK.Name)
        while self.lexer:consume(TK.Symbol, ",") do
            self.lexer:expect(TK.Name)
        end
        self.lexer:expect(TK.Symbol, ">")
    end
end

-- Parsing
function Parser:parseBlock()
    local scope = self:pushScope()
    local body = {}

    while true do
        local tok = self.lexer:peekToken()
        if tok.kind == TK.Eof then break end
        if tok.kind == TK.Keyword then
            if tok.value == "end" or tok.value == "else" or tok.value == "elseif" or tok.value == "until" then
                break
            end
        end

        local stmt = self:parseStatement()
        if stmt then
            body[#body + 1] = stmt
        end

        self.lexer:consume(TK.Symbol, ";")
    end

    self:popScope()
    return Ast.Block(body, scope)
end

function Parser:parseStatement()
    local tok = self.lexer:peekToken()

    if tok.kind == TK.Keyword then
        if tok.value == "local" then return self:parseLocal()
        elseif tok.value == "if" then return self:parseIf()
        elseif tok.value == "while" then return self:parseWhile()
        elseif tok.value == "repeat" then return self:parseRepeat()
        elseif tok.value == "for" then return self:parseFor()
        elseif tok.value == "do" then return self:parseDo()
        elseif tok.value == "function" then return self:parseFunctionDeclaration()
        elseif tok.value == "return" then return self:parseReturn()
        elseif tok.value == "break" then
            self.lexer:nextToken()
            return Ast.BreakStatement()
        elseif tok.value == "continue" then
            self.lexer:nextToken()
            return Ast.ContinueStatement()
        end
    end

    -- Handle LuaU 'type' and 'export type' as contextual keywords
    if tok.kind == TK.Name then
        if tok.value == "type" and self.lexer:peekToken(1).kind == TK.Name then
            return self:parseTypeStatement()
        elseif tok.value == "export" and self.lexer:peekToken(1).kind == TK.Name
            and self.lexer:peekToken(1).value == "type" then
            return self:parseTypeStatement()
        end
    end

    return self:parseExpressionStatement()
end

function Parser:parseLocal()
    self.lexer:expect(TK.Keyword, "local")

    if self.lexer:check(TK.Keyword, "function") then
        return self:parseLocalFunction()
    end

    local ids = {}
    local names = {}
    repeat
        local name = self.lexer:expect(TK.Name).value
        local id = self.currentScope:addVariable(name)
        ids[#ids + 1] = id
        names[#names + 1] = name
        self:skipTypeAnnotation()
    until not self.lexer:consume(TK.Symbol, ",")

    local values = {}
    if self.lexer:consume(TK.Symbol, "=") then
        repeat
            values[#values + 1] = self:parseExpression()
        until not self.lexer:consume(TK.Symbol, ",")
    end

    return Ast.LocalVariableDeclaration(self.currentScope, ids, values)
end

function Parser:parseLocalFunction()
    self.lexer:expect(TK.Keyword, "function")
    local name = self.lexer:expect(TK.Name).value
    local id = self.currentScope:addVariable(name)
    self:skipGenericParams()

    local scope = self:pushScope()
    self.lexer:expect(TK.Symbol, "(")
    local args = self:parseArgList()
    self.lexer:expect(TK.Symbol, ")")
    self:skipReturnTypeAnnotation()

    local body = self:parseBlock()
    self.lexer:expect(TK.Keyword, "end")
    self:popScope()

    return Ast.LocalFunctionDeclaration(self.currentScope, id, args, body)
end

function Parser:parseFunctionDeclaration()
    self.lexer:expect(TK.Keyword, "function")
    local name = self.lexer:expect(TK.Name).value
    local baseScope, baseId = self.currentScope:resolve(name)

    while self.lexer:consume(TK.Symbol, ".") do
        name = self.lexer:expect(TK.Name).value
    end

    local isSelf = false
    if self.lexer:consume(TK.Symbol, ":") then
        name = self.lexer:expect(TK.Name).value
        isSelf = true
    end

    self:skipGenericParams()
    local scope = self:pushScope()

    if isSelf then
        scope:addVariable("self")
    end

    self.lexer:expect(TK.Symbol, "(")
    local args = self:parseArgList()
    self.lexer:expect(TK.Symbol, ")")
    self:skipReturnTypeAnnotation()

    local body = self:parseBlock()
    self.lexer:expect(TK.Keyword, "end")
    self:popScope()

    return Ast.FunctionDeclaration(baseScope, baseId, false, args, body)
end

function Parser:parseArgList()
    local args = {}
    if not self.lexer:check(TK.Symbol, ")") then
        if self.lexer:check(TK.Symbol, "...") then
            self.lexer:nextToken()
            self:skipTypeAnnotation()
            args[#args + 1] = Ast.VarargExpression()
            return args
        end

        repeat
            if self.lexer:check(TK.Symbol, "...") then
                self.lexer:nextToken()
                self:skipTypeAnnotation()
                args[#args + 1] = Ast.VarargExpression()
                break
            end
            local name = self.lexer:expect(TK.Name).value
            local id = self.currentScope:addVariable(name)
            self:skipTypeAnnotation()
            args[#args + 1] = Ast.VariableExpression(self.currentScope, id)
        until not self.lexer:consume(TK.Symbol, ",")
    end
    return args
end

function Parser:parseIf()
    self.lexer:expect(TK.Keyword, "if")
    local condition = self:parseExpression()
    self.lexer:expect(TK.Keyword, "then")
    local body = self:parseBlock()

    local elseifs = {}
    while self.lexer:consume(TK.Keyword, "elseif") do
        local elifCond = self:parseExpression()
        self.lexer:expect(TK.Keyword, "then")
        local elifBody = self:parseBlock()
        elseifs[#elseifs + 1] = { condition = elifCond, body = elifBody }
    end

    local elseBody = nil
    if self.lexer:consume(TK.Keyword, "else") then
        elseBody = self:parseBlock()
    end

    self.lexer:expect(TK.Keyword, "end")
    return Ast.IfStatement(condition, body, elseifs, elseBody)
end

function Parser:parseWhile()
    self.lexer:expect(TK.Keyword, "while")
    local condition = self:parseExpression()
    self.lexer:expect(TK.Keyword, "do")
    local body = self:parseBlock()
    self.lexer:expect(TK.Keyword, "end")
    return Ast.WhileStatement(condition, body)
end

function Parser:parseRepeat()
    self.lexer:expect(TK.Keyword, "repeat")
    local body = self:parseBlock()
    self.lexer:expect(TK.Keyword, "until")
    local condition = self:parseExpression()
    return Ast.RepeatStatement(condition, body)
end

function Parser:parseFor()
    self.lexer:expect(TK.Keyword, "for")

    local firstName = self.lexer:expect(TK.Name).value

    if self.lexer:check(TK.Symbol, "=") then
        return self:parseNumericFor(firstName)
    else
        return self:parseGenericFor(firstName)
    end
end

function Parser:parseNumericFor(varName)
    self.lexer:expect(TK.Symbol, "=")
    local scope = self:pushScope()
    local varId = scope:addVariable(varName)

    local startExpr = self:parseExpression()
    self.lexer:expect(TK.Symbol, ",")
    local stopExpr = self:parseExpression()

    local stepExpr = nil
    if self.lexer:consume(TK.Symbol, ",") then
        stepExpr = self:parseExpression()
    end

    self.lexer:expect(TK.Keyword, "do")
    local body = self:parseBlock()
    self.lexer:expect(TK.Keyword, "end")
    self:popScope()

    return Ast.ForStatement(scope, varId, startExpr, stopExpr, stepExpr, body)
end

function Parser:parseGenericFor(firstName)
    local scope = self:pushScope()
    local ids = {}
    local firstId = scope:addVariable(firstName)
    ids[#ids + 1] = firstId

    self:skipTypeAnnotation()
    while self.lexer:consume(TK.Symbol, ",") do
        local name = self.lexer:expect(TK.Name).value
        local id = scope:addVariable(name)
        ids[#ids + 1] = id
        self:skipTypeAnnotation()
    end

    self.lexer:expect(TK.Keyword, "in")

    local iterators = {}
    repeat
        iterators[#iterators + 1] = self:parseExpression()
    until not self.lexer:consume(TK.Symbol, ",")

    self.lexer:expect(TK.Keyword, "do")
    local body = self:parseBlock()
    self.lexer:expect(TK.Keyword, "end")
    self:popScope()

    return Ast.ForInStatement(scope, ids, iterators, body)
end

function Parser:parseDo()
    self.lexer:expect(TK.Keyword, "do")
    local body = self:parseBlock()
    self.lexer:expect(TK.Keyword, "end")
    return Ast.DoStatement(body)
end

function Parser:parseReturn()
    self.lexer:expect(TK.Keyword, "return")
    local values = {}

    local tok = self.lexer:peekToken()
    if tok.kind ~= TK.Eof
        and not (tok.kind == TK.Keyword and (tok.value == "end" or tok.value == "else" or tok.value == "elseif" or tok.value == "until"))
        and not (tok.kind == TK.Symbol and tok.value == ";") then
        repeat
            values[#values + 1] = self:parseExpression()
        until not self.lexer:consume(TK.Symbol, ",")
    end

    return Ast.ReturnStatement(values)
end

function Parser:parseTypeStatement()
    if self.lexer:check(TK.Name, "export") then
        self.lexer:nextToken()
    end
    -- 'type' is a contextual keyword, comes as Name token
    self.lexer:expect(TK.Name, "type")
    self.lexer:expect(TK.Name)
    self:skipGenericParams()
    self.lexer:expect(TK.Symbol, "=")
    self:skipType()
    return nil
end

function Parser:parseExpressionStatement()
    local expr = self:parseSuffixExpression()

    -- Compound assignment
    local compoundOps = { ["+="] = "+", ["-="] = "-", ["*="] = "*", ["/="] = "/",
        ["//="] = "//", ["%="] = "%", ["^="] = "^", ["..="] = ".." }
    local tok = self.lexer:peekToken()
    if tok.kind == TK.Symbol and compoundOps[tok.value] then
        self.lexer:nextToken()
        local rhs = self:parseExpression()
        return Ast.CompoundAssignment(compoundOps[tok.value], expr, rhs)
    end

    if self.lexer:check(TK.Symbol, "=") or self.lexer:check(TK.Symbol, ",") then
        local lhs = { self:exprToAssignment(expr) }
        while self.lexer:consume(TK.Symbol, ",") do
            lhs[#lhs + 1] = self:exprToAssignment(self:parseSuffixExpression())
        end
        self.lexer:expect(TK.Symbol, "=")
        local rhs = {}
        repeat
            rhs[#rhs + 1] = self:parseExpression()
        until not self.lexer:consume(TK.Symbol, ",")
        return Ast.AssignmentStatement(lhs, rhs)
    end

    if expr.kind == AstKind.FunctionCallExpression then
        return Ast.FunctionCallStatement(expr.base, expr.args)
    elseif expr.kind == AstKind.PassSelfFunctionCallExpression then
        return Ast.PassSelfFunctionCallStatement(expr.base, expr.passSelfFunctionName, expr.args)
    end

    self:error("unexpected expression statement")
end

function Parser:exprToAssignment(expr)
    if expr.kind == AstKind.VariableExpression then
        return Ast.AssignmentVariable(expr.scope, expr.id)
    elseif expr.kind == AstKind.IndexExpression then
        return Ast.AssignmentIndexing(expr.base, expr.index)
    elseif expr.kind == AstKind.MemberExpression then
        return Ast.AssignmentMember(expr.base, expr.member)
    end
    self:error("invalid assignment target")
end

-- Expression parsing (precedence climbing)
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

local binOpToAst = {
    ["+"]   = Ast.AddExpression,
    ["-"]   = Ast.SubExpression,
    ["*"]   = Ast.MulExpression,
    ["/"]   = Ast.DivExpression,
    ["//"]  = Ast.FloorDivExpression,
    ["%"]   = Ast.ModExpression,
    ["^"]   = Ast.PowExpression,
    [".."]  = Ast.StrCatExpression,
    ["<"]   = Ast.LessThanExpression,
    [">"]   = Ast.GreaterThanExpression,
    ["<="]  = Ast.LessThanOrEqualsExpression,
    [">="]  = Ast.GreaterThanOrEqualsExpression,
    ["=="]  = Ast.EqualsExpression,
    ["~="]  = Ast.NotEqualsExpression,
    ["and"] = Ast.AndExpression,
    ["or"]  = Ast.OrExpression,
}

function Parser:parseExpression(minPrec)
    minPrec = minPrec or 0
    local lhs = self:parseUnary()

    while true do
        local tok = self.lexer:peekToken()
        local op = nil
        if tok.kind == TK.Symbol then
            op = tok.value
        elseif tok.kind == TK.Keyword and (tok.value == "and" or tok.value == "or") then
            op = tok.value
        end

        if not op or not precedence[op] then break end

        local prec = precedence[op]
        if prec < minPrec then break end

        self.lexer:nextToken()
        local nextMinPrec = rightAssoc[op] and prec or (prec + 1)
        local rhs = self:parseExpression(nextMinPrec)

        local constructor = binOpToAst[op]
        if not constructor then
            self:error("unknown binary operator: " .. op)
        end
        lhs = constructor(lhs, rhs, false)
    end

    -- LuaU if-then-else expression
    if self.lexer:check(TK.Keyword, "if") and minPrec == 0 then
        -- Actually 'if expr then expr else expr' as expression is different
        -- This is handled in parseUnary when we see 'if' at expression start
    end

    return lhs
end

function Parser:parseUnary()
    local tok = self.lexer:peekToken()

    if tok.kind == TK.Keyword and tok.value == "not" then
        self.lexer:nextToken()
        return Ast.NotExpression(self:parseUnary())
    end

    if tok.kind == TK.Symbol and tok.value == "-" then
        self.lexer:nextToken()
        return Ast.NegateExpression(self:parseUnary())
    end

    if tok.kind == TK.Symbol and tok.value == "#" then
        self.lexer:nextToken()
        return Ast.LenExpression(self:parseUnary())
    end

    return self:parseSuffixExpression()
end

function Parser:parseSuffixExpression()
    local expr = self:parsePrimary()

    while true do
        local tok = self.lexer:peekToken()

        if tok.kind == TK.Symbol and tok.value == "." then
            self.lexer:nextToken()
            local member = self.lexer:expect(TK.Name).value
            expr = Ast.MemberExpression(expr, member)

        elseif tok.kind == TK.Symbol and tok.value == "[" then
            self.lexer:nextToken()
            local index = self:parseExpression()
            self.lexer:expect(TK.Symbol, "]")
            expr = Ast.IndexExpression(expr, index)

        elseif tok.kind == TK.Symbol and tok.value == ":" then
            self.lexer:nextToken()
            local methodName = self.lexer:expect(TK.Name).value
            local args = self:parseCallArgs()
            expr = Ast.PassSelfFunctionCallExpression(expr, methodName, args)

        elseif tok.kind == TK.Symbol and tok.value == "(" then
            local args = self:parseCallArgs()
            expr = Ast.FunctionCallExpression(expr, args)

        elseif tok.kind == TK.String then
            local str = self.lexer:nextToken().value
            expr = Ast.FunctionCallExpression(expr, { Ast.StringExpression(str) })

        elseif tok.kind == TK.Symbol and tok.value == "{" then
            local tbl = self:parseTableConstructor()
            expr = Ast.FunctionCallExpression(expr, { tbl })

        else
            break
        end
    end

    return expr
end

function Parser:parseCallArgs()
    self.lexer:expect(TK.Symbol, "(")
    local args = {}
    if not self.lexer:check(TK.Symbol, ")") then
        repeat
            args[#args + 1] = self:parseExpression()
        until not self.lexer:consume(TK.Symbol, ",")
    end
    self.lexer:expect(TK.Symbol, ")")
    return args
end

function Parser:parsePrimary()
    local tok = self.lexer:peekToken()

    if tok.kind == TK.Name then
        self.lexer:nextToken()
        local scope, id = self.currentScope:resolve(tok.value)
        return Ast.VariableExpression(scope, id)

    elseif tok.kind == TK.Number then
        self.lexer:nextToken()
        return Ast.NumberExpression(tok.value)

    elseif tok.kind == TK.String then
        self.lexer:nextToken()
        if type(tok.value) == "table" then
            return Ast.InterpolatedStringExpression(tok.value)
        end
        return Ast.StringExpression(tok.value)

    elseif tok.kind == TK.Keyword and tok.value == "true" then
        self.lexer:nextToken()
        return Ast.BooleanExpression(true)

    elseif tok.kind == TK.Keyword and tok.value == "false" then
        self.lexer:nextToken()
        return Ast.BooleanExpression(false)

    elseif tok.kind == TK.Keyword and tok.value == "nil" then
        self.lexer:nextToken()
        return Ast.NilExpression()

    elseif tok.kind == TK.Symbol and tok.value == "..." then
        self.lexer:nextToken()
        return Ast.VarargExpression()

    elseif tok.kind == TK.Symbol and tok.value == "(" then
        self.lexer:nextToken()
        local expr = self:parseExpression()
        self.lexer:expect(TK.Symbol, ")")
        return expr

    elseif tok.kind == TK.Symbol and tok.value == "{" then
        return self:parseTableConstructor()

    elseif tok.kind == TK.Keyword and tok.value == "function" then
        return self:parseFunctionLiteral()

    elseif tok.kind == TK.Keyword and tok.value == "if" then
        return self:parseIfElseExpression()

    else
        self:error("unexpected token: " .. tok.kind .. " '" .. tostring(tok.value) .. "'")
    end
end

function Parser:parseFunctionLiteral()
    self.lexer:expect(TK.Keyword, "function")
    self:skipGenericParams()
    local scope = self:pushScope()
    self.lexer:expect(TK.Symbol, "(")
    local args = self:parseArgList()
    self.lexer:expect(TK.Symbol, ")")
    self:skipReturnTypeAnnotation()
    local body = self:parseBlock()
    self.lexer:expect(TK.Keyword, "end")
    self:popScope()
    return Ast.FunctionLiteralExpression(args, body)
end

function Parser:parseIfElseExpression()
    self.lexer:expect(TK.Keyword, "if")
    local condition = self:parseExpression()
    self.lexer:expect(TK.Keyword, "then")
    local ifExpr = self:parseExpression()
    local elseExpr
    if self.lexer:consume(TK.Keyword, "elseif") then
        -- Treat as nested if-else expression
        -- We've already consumed 'elseif', so reconstruct
        local nestedCond = self:parseExpression()
        self.lexer:expect(TK.Keyword, "then")
        local nestedIf = self:parseExpression()
        self.lexer:expect(TK.Keyword, "else")
        local nestedElse = self:parseExpression()
        elseExpr = Ast.IfElseExpression(nestedCond, nestedIf, nestedElse)
    else
        self.lexer:expect(TK.Keyword, "else")
        elseExpr = self:parseExpression()
    end
    return Ast.IfElseExpression(condition, ifExpr, elseExpr)
end

function Parser:parseTableConstructor()
    self.lexer:expect(TK.Symbol, "{")
    local entries = {}

    while not self.lexer:check(TK.Symbol, "}") do
        if self.lexer:check(TK.Symbol, "[") then
            self.lexer:nextToken()
            local key = self:parseExpression()
            self.lexer:expect(TK.Symbol, "]")
            self.lexer:expect(TK.Symbol, "=")
            local value = self:parseExpression()
            entries[#entries + 1] = Ast.KeyedTableEntry(key, value)
        elseif self.lexer:check(TK.Name) and self.lexer:peekToken(1).kind == TK.Symbol
            and self.lexer:peekToken(1).value == "=" then
            local key = self.lexer:nextToken().value
            self.lexer:nextToken()
            local value = self:parseExpression()
            entries[#entries + 1] = Ast.KeyedTableEntry(Ast.StringExpression(key), value)
        else
            local value = self:parseExpression()
            entries[#entries + 1] = Ast.TableEntry(value)
        end

        if not self.lexer:consume(TK.Symbol, ",") and not self.lexer:consume(TK.Symbol, ";") then
            break
        end
    end

    self.lexer:expect(TK.Symbol, "}")
    return Ast.TableConstructorExpression(entries)
end

return Parser
