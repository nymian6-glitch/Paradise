-- Aegis LuaU Obfuscator
-- namegen/init.lua -- Name generators for obfuscation

local NameGen = {}

function NameGen.Il(id)
    local chars = {"I", "l", "1"}
    local result = {}
    local n = id
    if n == 0 then return "Il" end
    while n > 0 do
        result[#result + 1] = chars[(n % 3) + 1]
        n = math.floor(n / 3)
    end
    return "I" .. table.concat(result)
end

function NameGen.Underscore(id)
    local result = "_"
    for i = 1, math.floor(id / 26) + 1 do
        result = result .. "_"
    end
    result = result .. string.char(97 + (id % 26))
    return result
end

function NameGen.Mangled(id)
    local alphabet = "abcdefghijklmnopqrstuvwxyz"
    local result = {}
    local n = id
    repeat
        result[#result + 1] = alphabet:sub((n % 26) + 1, (n % 26) + 1)
        n = math.floor(n / 26)
    until n == 0
    return table.concat(result)
end

function NameGen.Random(id)
    local len = math.random(6, 12)
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_"
    local result = {}
    for i = 1, len do
        local idx = math.random(1, #chars)
        result[i] = chars:sub(idx, idx)
    end
    return table.concat(result)
end

function NameGen.create(style)
    style = style or "Il"
    local gen = NameGen[style]
    if not gen then gen = NameGen.Il end

    local counter = 0
    return function()
        counter = counter + 1
        return gen(counter)
    end
end

return NameGen
