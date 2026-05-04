-- Aegis LuaU Obfuscator
-- logger.lua -- Logging system

local logger = {}
logger.level = "info"

local levels = { debug = 0, info = 1, warn = 2, error = 3 }

local function getLevel(name)
    return levels[name] or 1
end

function logger:debug(msg)
    if getLevel(self.level) <= 0 then
        print("[DEBUG] " .. tostring(msg))
    end
end

function logger:info(msg)
    if getLevel(self.level) <= 1 then
        print("[INFO]  " .. tostring(msg))
    end
end

function logger:warn(msg)
    if getLevel(self.level) <= 2 then
        print("[WARN]  " .. tostring(msg))
    end
end

function logger:error(msg)
    error("[ERROR] " .. tostring(msg), 2)
end

return logger
