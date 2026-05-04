-- Aegis LuaU Obfuscator
-- scope.lua -- Variable scope tracking

local Scope = {}

local globalId = 0

function Scope:newGlobal()
    local scope = {
        isGlobal = true,
        variables = {},
        variableNames = {},
        references = {},
        parent = nil,
        children = {},
        id = globalId,
    }
    globalId = globalId + 1
    setmetatable(scope, self)
    self.__index = self
    return scope
end

function Scope:new(parent, funcScope)
    local scope = {
        isGlobal = false,
        variables = {},
        variableNames = {},
        references = {},
        parent = parent,
        children = {},
        functionScope = funcScope,
        id = globalId,
    }
    globalId = globalId + 1

    if parent then
        table.insert(parent.children, scope)
    end

    setmetatable(scope, self)
    self.__index = self
    return scope
end

function Scope:addVariable(name)
    local id = {}
    id.name = name
    id.scope = self
    id.references = 0
    table.insert(self.variables, id)
    if name then
        self.variableNames[name] = id
    end
    return id
end

function Scope:resolve(name)
    if self.variableNames[name] then
        return self, self.variableNames[name]
    end
    if self.parent then
        return self.parent:resolve(name)
    end
    if self.isGlobal then
        local id = self:addVariable(name)
        return self, id
    end
    return nil, nil
end

function Scope:addReferenceToHigherScope(targetScope, targetId, depth)
    depth = depth or 1
    if not self.references[targetScope] then
        self.references[targetScope] = {}
    end
    self.references[targetScope][targetId] = (self.references[targetScope][targetId] or 0) + 1
    targetId.references = (targetId.references or 0) + 1
end

function Scope:getVariables()
    return self.variables
end

function Scope:getParent()
    return self.parent
end

function Scope:getDepth()
    local depth = 0
    local s = self
    while s.parent do
        depth = depth + 1
        s = s.parent
    end
    return depth
end

return Scope
