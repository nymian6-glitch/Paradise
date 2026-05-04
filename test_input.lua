-- Test script for obfuscation
local function greet(name)
    print("Hello, " .. name .. "!")
end

local x = 42
local y = x * 2 + 10

if y > 50 then
    greet("World")
else
    print("Too small")
end

for i = 1, 5 do
    print("Count: " .. tostring(i))
end
