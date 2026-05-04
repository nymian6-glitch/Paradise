-- Aegis LuaU Obfuscator
-- steps/wrap_in_function.lua -- Wraps entire script in a function call

local Step = require("steps.step")
local Ast = require("ast")
local Scope = require("scope")
local AstKind = Ast.AstKind

local WrapInFunction = Step:extend()
WrapInFunction.Name = "WrapInFunction"
WrapInFunction.Description = "Wraps the entire script into a function call to hide local variables"
WrapInFunction.SettingsDescriptor = {}

function WrapInFunction:init() end

function WrapInFunction:apply(ast, pipeline)
    local scope = Scope:new(ast.scope:getParent())
    local funcLiteral = Ast.FunctionLiteralExpression({}, ast)
    local call = Ast.FunctionCallExpression(funcLiteral, {})
    local callStmt = Ast.FunctionCallStatement(funcLiteral, {})
    return Ast.Block({ callStmt }, scope)
end

return WrapInFunction
