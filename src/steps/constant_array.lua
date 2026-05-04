-- Aegis LuaU Obfuscator
-- steps/constant_array.lua -- Extract constants into an encrypted array

local Step = require("steps.step")
local Ast = require("ast")
local Scope = require("scope")
local visitast = require("visitor")
local util = require("util")
local AstKind = Ast.AstKind

local ConstantArray = Step:extend()
ConstantArray.Name = "ConstantArray"
ConstantArray.Description = "Extracts all constants into an obfuscated array"
ConstantArray.SettingsDescriptor = {
    Threshold = { type = "number", default = 1, min = 0, max = 1 },
    StringsOnly = { type = "boolean", default = false },
    Shuffle = { type = "boolean", default = true },
    Rotate = { type = "boolean", default = true },
}

function ConstantArray:init() end

function ConstantArray:apply(ast, pipeline)
    local constants = {}
    local lookup = {}
    local rotateAmount = 0

    local function addConstant(value)
        local key = type(value) .. ":" .. tostring(value)
        if lookup[key] then return lookup[key] end
        local idx = #constants + 1
        constants[idx] = value
        lookup[key] = idx
        return idx
    end

    visitast(ast, nil, function(node)
        if node.kind == AstKind.StringExpression and type(node.value) == "string" then
            if math.random() <= self.Threshold then
                addConstant(node.value)
            end
        elseif node.kind == AstKind.NumberExpression and not self.StringsOnly then
            if math.random() <= self.Threshold then
                addConstant(node.value)
            end
        elseif node.kind == AstKind.BooleanExpression and not self.StringsOnly then
            if math.random() <= self.Threshold then
                addConstant(node.value)
            end
        end
    end)

    if #constants == 0 then return ast end

    if self.Shuffle then
        local indices = {}
        for i = 1, #constants do indices[i] = i end
        util.shuffle(indices)
        local newConstants = {}
        local indexMap = {}
        for i, idx in ipairs(indices) do
            newConstants[i] = constants[idx]
            indexMap[idx] = i
        end
        constants = newConstants
        local newLookup = {}
        for k, v in pairs(lookup) do
            newLookup[k] = indexMap[v]
        end
        lookup = newLookup
    end

    if self.Rotate then
        rotateAmount = math.random(1, #constants)
        local rotated = {}
        for i = 1, #constants do
            rotated[i] = constants[(i - 1 + rotateAmount) % #constants + 1]
        end
        constants = rotated
        -- Don't adjust lookup - de-rotation at runtime restores original order
    end

    -- Build array expression
    local entries = {}
    for i, v in ipairs(constants) do
        entries[i] = Ast.TableEntry(Ast.ConstantNode(v))
    end
    local arrayExpr = Ast.TableConstructorExpression(entries)

    -- Use a global variable for the array so nested functions can access it
    -- (our VM doesn't support upvalues, so locals aren't visible in closures)
    local scope = ast.scope
    local globalScope = scope
    while globalScope.parent do globalScope = globalScope.parent end
    local arrayName = "_AEGIS_" .. tostring(math.random(1000000, 9999999))
    local _, arrayId = globalScope:resolve(arrayName)

    -- Assignment statement: _AEGIS_xxx = {...}
    local arrayAssign = Ast.AssignmentStatement(
        { Ast.AssignmentVariable(globalScope, arrayId) },
        { arrayExpr }
    )

    -- Build derotate code (to be inserted later)
    local rotateLoop = nil
    if self.Rotate and rotateAmount > 0 then
        local _, tableId = globalScope:resolve("table")
        local rotScope = Scope:new(scope)
        local iId = rotScope:addVariable()

        local removeCall = Ast.FunctionCallExpression(
            Ast.MemberExpression(Ast.VariableExpression(globalScope, tableId), "remove"),
            { Ast.VariableExpression(globalScope, arrayId) }
        )
        local insertCall = Ast.FunctionCallStatement(
            Ast.MemberExpression(Ast.VariableExpression(globalScope, tableId), "insert"),
            { Ast.VariableExpression(globalScope, arrayId), Ast.NumberExpression(1), removeCall }
        )
        rotateLoop = Ast.ForStatement(
            rotScope, iId,
            Ast.NumberExpression(1), Ast.NumberExpression(rotateAmount), nil,
            Ast.Block({ insertCall }, Scope:new(rotScope))
        )
    end

    -- Replace constants with direct array indexing BEFORE inserting declarations
    visitast(ast, nil, function(node)
        if node.kind == AstKind.StringExpression and type(node.value) == "string" then
            local key = "string:" .. node.value
            local idx = lookup[key]
            if idx then
                return Ast.IndexExpression(
                    Ast.VariableExpression(globalScope, arrayId),
                    Ast.NumberExpression(idx)
                )
            end
        elseif node.kind == AstKind.NumberExpression and not self.StringsOnly then
            local key = "number:" .. tostring(node.value)
            local idx = lookup[key]
            if idx then
                return Ast.IndexExpression(
                    Ast.VariableExpression(globalScope, arrayId),
                    Ast.NumberExpression(idx)
                )
            end
        elseif node.kind == AstKind.BooleanExpression and not self.StringsOnly then
            local key = "boolean:" .. tostring(node.value)
            local idx = lookup[key]
            if idx then
                return Ast.IndexExpression(
                    Ast.VariableExpression(globalScope, arrayId),
                    Ast.NumberExpression(idx)
                )
            end
        end
    end)

    -- Insert declarations: array assignment first, then derotate
    if rotateLoop then
        table.insert(ast.body, 1, rotateLoop)
    end
    table.insert(ast.body, 1, arrayAssign)

    return ast
end

return ConstantArray
