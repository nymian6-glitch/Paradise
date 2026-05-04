-- Aegis LuaU Obfuscator
-- steps/numbers_to_expressions.lua -- Converts number literals to mathematical expressions

local Step = require("steps.step")
local Ast = require("ast")
local visitast = require("visitor")
local AstKind = Ast.AstKind

local NumbersToExpressions = Step:extend()
NumbersToExpressions.Name = "NumbersToExpressions"
NumbersToExpressions.Description = "Converts number literals to equivalent math expressions"
NumbersToExpressions.SettingsDescriptor = {
    Threshold = { type = "number", default = 1, min = 0, max = 1 },
    MaxDepth = { type = "number", default = 3, min = 1, max = 15 },
}

function NumbersToExpressions:init()
    self.generators = {
        function(self, val, depth) -- Addition
            local val2 = math.random(-2^20, 2^20)
            local diff = val - val2
            if tonumber(tostring(diff)) + tonumber(tostring(val2)) ~= val then
                return false
            end
            return Ast.AddExpression(
                self:createExpr(val2, depth),
                self:createExpr(diff, depth),
                false
            )
        end,
        function(self, val, depth) -- Subtraction
            local val2 = math.random(-2^20, 2^20)
            local diff = val + val2
            if tonumber(tostring(diff)) - tonumber(tostring(val2)) ~= val then
                return false
            end
            return Ast.SubExpression(
                self:createExpr(diff, depth),
                self:createExpr(val2, depth),
                false
            )
        end,
        function(self, val, depth) -- Modulo
            local rhs = val + math.random(1, 2^24)
            local multiplier = math.random(1, 2^8)
            local lhs = val + (multiplier * rhs)
            if tonumber(tostring(lhs)) % tonumber(tostring(rhs)) ~= val then
                return false
            end
            return Ast.ModExpression(
                self:createExpr(lhs, depth),
                self:createExpr(rhs, depth),
                false
            )
        end,
    }
end

function NumbersToExpressions:createExpr(val, depth)
    depth = depth + 1
    if depth > self.MaxDepth or math.random() > 0.5 then
        return Ast.NumberExpression(val)
    end

    local shuffled = {}
    for i, g in ipairs(self.generators) do shuffled[i] = g end
    for i = #shuffled, 2, -1 do
        local j = math.random(1, i)
        shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
    end

    for _, gen in ipairs(shuffled) do
        local result = gen(self, val, depth)
        if result then return result end
    end

    return Ast.NumberExpression(val)
end

function NumbersToExpressions:apply(ast)
    visitast(ast, nil, function(node)
        if node.kind == AstKind.NumberExpression then
            if type(node.value) == "number" and node.value == math.floor(node.value)
                and node.value >= -2^30 and node.value <= 2^30 then
                if math.random() <= self.Threshold then
                    return self:createExpr(node.value, 0)
                end
            end
        end
    end)
    return ast
end

return NumbersToExpressions
