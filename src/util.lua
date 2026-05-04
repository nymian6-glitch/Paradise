-- Aegis LuaU Obfuscator
-- util.lua -- Common utilities

local util = {}

function util.lookupify(t)
    local lookup = {}
    for _, v in ipairs(t) do
        lookup[v] = true
    end
    return lookup
end

function util.keys(t)
    local ks = {}
    for k in pairs(t) do
        ks[#ks + 1] = k
    end
    return ks
end

function util.values(t)
    local vs = {}
    for _, v in pairs(t) do
        vs[#vs + 1] = v
    end
    return vs
end

function util.copy(t)
    local c = {}
    for k, v in pairs(t) do
        c[k] = v
    end
    return c
end

function util.deepcopy(t)
    if type(t) ~= "table" then return t end
    local c = {}
    for k, v in pairs(t) do
        c[util.deepcopy(k)] = util.deepcopy(v)
    end
    return setmetatable(c, getmetatable(t))
end

function util.shuffle(t)
    local n = #t
    for i = n, 2, -1 do
        local j = math.random(1, i)
        t[i], t[j] = t[j], t[i]
    end
    return t
end

function util.indexOf(t, val)
    for i, v in ipairs(t) do
        if v == val then return i end
    end
    return nil
end

function util.map(t, fn)
    local r = {}
    for i, v in ipairs(t) do
        r[i] = fn(v, i)
    end
    return r
end

function util.filter(t, fn)
    local r = {}
    for _, v in ipairs(t) do
        if fn(v) then r[#r + 1] = v end
    end
    return r
end

function util.concat(...)
    local r = {}
    for _, t in ipairs({...}) do
        for _, v in ipairs(t) do
            r[#r + 1] = v
        end
    end
    return r
end

function util.escape(s)
    return (s:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1"))
end

function util.randomString(len)
    len = len or math.random(8, 16)
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local s = {}
    for i = 1, len do
        local idx = math.random(1, #chars)
        s[i] = chars:sub(idx, idx)
    end
    return table.concat(s)
end

function util.bitxor(a, b)
    local p, c = 1, 0
    while a > 0 and b > 0 do
        local ra, rb = a % 2, b % 2
        if ra ~= rb then c = c + p end
        a, b, p = (a - ra) / 2, (b - rb) / 2, p * 2
    end
    if a < b then a = b end
    while a > 0 do
        local ra = a % 2
        if ra > 0 then c = c + p end
        a, p = (a - ra) / 2, p * 2
    end
    return c
end

function util.readFile(path)
    local f = io.open(path, "rb")
    if not f then return nil, "Cannot open file: " .. path end
    local content = f:read("*a")
    f:close()
    return content
end

function util.writeFile(path, content)
    local f = io.open(path, "wb")
    if not f then return nil, "Cannot write file: " .. path end
    f:write(content)
    f:close()
    return true
end

return util
