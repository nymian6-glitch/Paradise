#!/usr/bin/env lua
-- Aegis LuaU Obfuscator -- CLI

-- Add src to path
package.path = "src/?.lua;src/?/init.lua;" .. package.path

local util = require("util")
local logger = require("logger")
local Presets = require("presets")
local Pipeline = require("pipeline")
local Steps = require("steps")

local function printUsage()
    print("Aegis LuaU Obfuscator")
    print("")
    print("Usage: lua cli.lua [options] <input.lua>")
    print("")
    print("Options:")
    print("  --preset <name>        Use a preset (Minify, Weak, Medium, Strong)")
    print("  --steps <step,step>    Comma-separated list of steps")
    print("  --output <file>        Output file (default: <input>.obfuscated.lua)")
    print("  --seed <number>        Random seed for reproducible output")
    print("  --pretty               Pretty-print output")
    print("  --verbose              Verbose logging")
    print("  --help                 Show this help")
    print("")
    print("Available steps:")
    print("  WrapInFunction, EncryptStrings, ConstantArray,")
    print("  AntiTamper, NumbersToExpressions, Vmify")
    print("")
    print("Examples:")
    print("  lua cli.lua --preset Medium input.lua")
    print("  lua cli.lua --preset Strong --output out.lua input.lua")
    print("  lua cli.lua --steps EncryptStrings,Vmify input.lua")
end

local function parseArgs(args)
    local options = {
        preset = nil,
        steps = nil,
        input = nil,
        output = nil,
        seed = nil,
        pretty = false,
        verbose = false,
    }

    local i = 1
    while i <= #args do
        local arg = args[i]
        if arg == "--preset" then
            i = i + 1
            options.preset = args[i]
        elseif arg == "--steps" then
            i = i + 1
            options.steps = args[i]
        elseif arg == "--output" or arg == "-o" then
            i = i + 1
            options.output = args[i]
        elseif arg == "--seed" then
            i = i + 1
            options.seed = tonumber(args[i])
        elseif arg == "--pretty" then
            options.pretty = true
        elseif arg == "--verbose" or arg == "-v" then
            options.verbose = true
        elseif arg == "--help" or arg == "-h" then
            printUsage()
            os.exit(0)
        else
            options.input = arg
        end
        i = i + 1
    end

    return options
end

local function main()
    local options = parseArgs(arg or {})

    if not options.input then
        printUsage()
        os.exit(1)
    end

    if options.verbose then
        logger.level = "debug"
    end

    local source, err = util.readFile(options.input)
    if not source then
        logger:error("Failed to read input: " .. tostring(err))
    end

    local pipelineOpts = {
        PrettyPrint = options.pretty,
        seed = options.seed,
    }

    local pipeline

    if options.preset then
        local presetFn = Presets[options.preset]
        if not presetFn then
            logger:error("Unknown preset: " .. options.preset .. "\nAvailable: Minify, Weak, Medium, Strong")
        end
        pipeline = presetFn(pipelineOpts)
    elseif options.steps then
        pipeline = Pipeline:new(pipelineOpts)
        for stepName in options.steps:gmatch("[^,]+") do
            stepName = stepName:match("^%s*(.-)%s*$")
            local stepClass = Steps[stepName]
            if not stepClass then
                logger:error("Unknown step: " .. stepName)
            end
            pipeline:addStep(stepClass:new())
        end
    else
        pipeline = Presets.Medium(pipelineOpts)
    end

    local output = pipeline:run(source, options.input)

    local outPath = options.output or options.input:gsub("%.lua$", "") .. ".obfuscated.lua"
    local ok, writeErr = util.writeFile(outPath, output)
    if not ok then
        logger:error("Failed to write output: " .. tostring(writeErr))
    end

    logger:info("Output written to: " .. outPath)
end

main()
