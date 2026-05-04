-- Aegis LuaU Obfuscator
-- steps/vmify.lua -- Compiles AST to custom VM bytecode

local Step = require("steps.step")
local Ast = require("ast")
local Scope = require("scope")
local Parser = require("parser")
local Compiler = require("vm.compiler")
local Emitter = require("vm.emitter")
local AstKind = Ast.AstKind

local Vmify = Step:extend()
Vmify.Name = "Vmify"
Vmify.Description = "Compiles the AST into a custom VM with obfuscated bytecode"
Vmify.SettingsDescriptor = {
    SuperOperators = { type = "boolean", default = true },
    Mutations = { type = "boolean", default = true },
    MaxSuperOpSize = { type = "number", default = 10 },
    MaxMutations = { type = "number", default = 100 },
}

function Vmify:init() end

function Vmify:apply(ast, pipeline)
    local compiler = Compiler:new()
    local chunk = compiler:compileChunk(ast)

    local emitter = Emitter:new({
        superOperators = self.SuperOperators,
        mutations = self.Mutations,
        maxSuperOpSize = self.MaxSuperOpSize,
        maxMutations = self.MaxMutations,
    })

    local vmCode = emitter:emit(chunk)

    local parser = Parser:new()
    local vmAst = parser:parse(vmCode, "<vm>")
    return vmAst
end

return Vmify
