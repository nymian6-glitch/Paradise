-- Aegis LuaU Obfuscator
-- presets.lua -- Predefined obfuscation presets

local Steps = require("steps")
local Pipeline = require("pipeline")

local Presets = {}

function Presets.Minify(options)
    local pipeline = Pipeline:new(options)
    pipeline:addStep(Steps.WrapInFunction:new())
    return pipeline
end

function Presets.Weak(options)
    local pipeline = Pipeline:new(options)
    pipeline:addStep(Steps.WrapInFunction:new())
    pipeline:addStep(Steps.Vmify:new({
        SuperOperators = false,
        Mutations = true,
        MaxMutations = 30,
    }))
    return pipeline
end

function Presets.Medium(options)
    local pipeline = Pipeline:new(options)
    pipeline:addStep(Steps.WrapInFunction:new())
    pipeline:addStep(Steps.EncryptStrings:new())
    pipeline:addStep(Steps.AntiTamper:new({ Intensity = 3 }))
    pipeline:addStep(Steps.Vmify:new({
        SuperOperators = true,
        Mutations = true,
        MaxSuperOpSize = 10,
        MaxMutations = 50,
    }))
    return pipeline
end

function Presets.Strong(options)
    local pipeline = Pipeline:new(options)
    pipeline:addStep(Steps.WrapInFunction:new())
    pipeline:addStep(Steps.NumbersToExpressions:new({
        Threshold = 0.8,
        MaxDepth = 3,
    }))
    pipeline:addStep(Steps.EncryptStrings:new())
    pipeline:addStep(Steps.ConstantArray:new({
        Threshold = 1,
        StringsOnly = false,
        Shuffle = true,
        Rotate = true,
    }))
    pipeline:addStep(Steps.AntiTamper:new({ Intensity = 5 }))
    pipeline:addStep(Steps.Vmify:new({
        SuperOperators = true,
        Mutations = true,
        MaxSuperOpSize = 15,
        MaxMutations = 100,
    }))
    return pipeline
end

return Presets
