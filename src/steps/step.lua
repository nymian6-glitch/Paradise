-- Aegis LuaU Obfuscator
-- steps/step.lua -- Base class for obfuscation steps

local logger = require("logger")

local Step = {}

Step.SettingsDescriptor = {}
Step.Name = "Abstract Step"
Step.Description = "Abstract Step"

function Step:new(settings)
    local instance = {}
    setmetatable(instance, self)
    self.__index = self

    settings = settings or {}
    for key, data in pairs(self.SettingsDescriptor) do
        if settings[key] == nil then
            if data.default == nil then
                logger:error(string.format("Setting '%s' required for step '%s'", key, self.Name))
            end
            instance[key] = data.default
        else
            instance[key] = settings[key]
        end
    end

    instance:init()
    return instance
end

function Step:extend()
    local ext = {}
    setmetatable(ext, self)
    self.__index = self
    return ext
end

function Step:init() end

function Step:apply(ast, pipeline)
    logger:error("Abstract step cannot be applied")
end

return Step
