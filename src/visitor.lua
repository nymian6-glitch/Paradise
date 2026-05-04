-- Aegis LuaU Obfuscator
-- visitor.lua -- AST visitor/walker

local Ast = require("ast")
local AstKind = Ast.AstKind

local function visitast(node, preVisit, postVisit)
    if not node then return node end

    if preVisit then
        local replacement = preVisit(node)
        if replacement then
            node = replacement
        end
    end

    local kind = node.kind

    -- Recurse into children
    if kind == AstKind.Block then
        for i, stmt in ipairs(node.body) do
            node.body[i] = visitast(stmt, preVisit, postVisit)
        end

    elseif kind == AstKind.AssignmentStatement then
        for i, lhs in ipairs(node.lhs) do
            node.lhs[i] = visitast(lhs, preVisit, postVisit)
        end
        for i, rhs in ipairs(node.rhs) do
            node.rhs[i] = visitast(rhs, preVisit, postVisit)
        end

    elseif kind == AstKind.LocalVariableDeclaration then
        for i, val in ipairs(node.values) do
            node.values[i] = visitast(val, preVisit, postVisit)
        end

    elseif kind == AstKind.DoStatement then
        node.body = visitast(node.body, preVisit, postVisit)

    elseif kind == AstKind.WhileStatement then
        node.condition = visitast(node.condition, preVisit, postVisit)
        node.body = visitast(node.body, preVisit, postVisit)

    elseif kind == AstKind.RepeatStatement then
        node.body = visitast(node.body, preVisit, postVisit)
        node.condition = visitast(node.condition, preVisit, postVisit)

    elseif kind == AstKind.IfStatement then
        node.condition = visitast(node.condition, preVisit, postVisit)
        node.body = visitast(node.body, preVisit, postVisit)
        for i, elif in ipairs(node.elseifs) do
            elif.condition = visitast(elif.condition, preVisit, postVisit)
            elif.body = visitast(elif.body, preVisit, postVisit)
        end
        if node.elseBody then
            node.elseBody = visitast(node.elseBody, preVisit, postVisit)
        end

    elseif kind == AstKind.ForStatement then
        node.start = visitast(node.start, preVisit, postVisit)
        node.stop = visitast(node.stop, preVisit, postVisit)
        if node.step then
            node.step = visitast(node.step, preVisit, postVisit)
        end
        node.body = visitast(node.body, preVisit, postVisit)

    elseif kind == AstKind.ForInStatement then
        for i, iter in ipairs(node.iterators) do
            node.iterators[i] = visitast(iter, preVisit, postVisit)
        end
        node.body = visitast(node.body, preVisit, postVisit)

    elseif kind == AstKind.ReturnStatement then
        for i, val in ipairs(node.values) do
            node.values[i] = visitast(val, preVisit, postVisit)
        end

    elseif kind == AstKind.FunctionDeclaration or kind == AstKind.LocalFunctionDeclaration then
        node.body = visitast(node.body, preVisit, postVisit)

    elseif kind == AstKind.FunctionCallStatement or kind == AstKind.FunctionCallExpression then
        node.base = visitast(node.base, preVisit, postVisit)
        for i, arg in ipairs(node.args) do
            node.args[i] = visitast(arg, preVisit, postVisit)
        end

    elseif kind == AstKind.PassSelfFunctionCallStatement or kind == AstKind.PassSelfFunctionCallExpression then
        node.base = visitast(node.base, preVisit, postVisit)
        for i, arg in ipairs(node.args) do
            node.args[i] = visitast(arg, preVisit, postVisit)
        end

    elseif kind == AstKind.CompoundAssignment then
        node.lhs = visitast(node.lhs, preVisit, postVisit)
        node.rhs = visitast(node.rhs, preVisit, postVisit)

    elseif kind == AstKind.FunctionLiteralExpression then
        node.body = visitast(node.body, preVisit, postVisit)

    elseif kind == AstKind.TableConstructorExpression then
        for i, entry in ipairs(node.entries) do
            node.entries[i] = visitast(entry, preVisit, postVisit)
        end

    elseif kind == AstKind.TableEntry then
        node.value = visitast(node.value, preVisit, postVisit)

    elseif kind == AstKind.KeyedTableEntry then
        node.key = visitast(node.key, preVisit, postVisit)
        node.value = visitast(node.value, preVisit, postVisit)

    elseif kind == AstKind.IndexExpression then
        node.base = visitast(node.base, preVisit, postVisit)
        node.index = visitast(node.index, preVisit, postVisit)

    elseif kind == AstKind.MemberExpression then
        node.base = visitast(node.base, preVisit, postVisit)

    elseif kind == AstKind.AssignmentIndexing then
        node.base = visitast(node.base, preVisit, postVisit)
        node.index = visitast(node.index, preVisit, postVisit)

    elseif kind == AstKind.AssignmentMember then
        node.base = visitast(node.base, preVisit, postVisit)

    elseif Ast.isBinaryExpression(node) then
        node.lhs = visitast(node.lhs, preVisit, postVisit)
        node.rhs = visitast(node.rhs, preVisit, postVisit)

    elseif Ast.isUnaryExpression(node) then
        node.expression = visitast(node.expression, preVisit, postVisit)

    elseif kind == AstKind.IfElseExpression then
        node.condition = visitast(node.condition, preVisit, postVisit)
        node.ifExpr = visitast(node.ifExpr, preVisit, postVisit)
        node.elseExpr = visitast(node.elseExpr, preVisit, postVisit)
    end

    if postVisit then
        local replacement = postVisit(node)
        if replacement then
            return replacement
        end
    end

    return node
end

return visitast
