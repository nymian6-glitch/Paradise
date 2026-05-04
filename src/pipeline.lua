-- Aegis LuaU Obfuscator
-- pipeline.lua -- Pipeline system for obfuscation steps

local Parser = require("parser")
local Unparser = require("unparser")
local logger = require("logger")
local NameGen = require("namegen")

local Pipeline = {}

function Pipeline:new(options)
    local pipeline = {
        steps = {},
        options = options or {},
        nameGenerator = NameGen.create(options and options.nameStyle or "Il"),
    }
    setmetatable(pipeline, self)
    self.__index = self
    return pipeline
end

function Pipeline:addStep(step)
    self.steps[#self.steps + 1] = step
    return self
end

function Pipeline:run(source, filename)
    math.randomseed(self.options.seed or os.time())

    logger:info("Parsing source...")
    local parser = Parser:new()
    local ast = parser:parse(source, filename or "<input>")

    for i, step in ipairs(self.steps) do
        logger:info(string.format("Applying step %d/%d: %s", i, #self.steps, step.Name))
        ast = step:apply(ast, self) or ast
    end

    logger:info("Unparsing AST...")
    local unparser = Unparser:new(self.options)
    local output = unparser:unparse(ast)

    logger:info("Obfuscation complete")
    return output
end

function Pipeline:getName()
    return self.nameGenerator()
end

return Pipeline
