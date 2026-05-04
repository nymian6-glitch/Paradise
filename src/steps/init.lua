-- Aegis LuaU Obfuscator
-- steps/init.lua -- Step registry

return {
    WrapInFunction       = require("steps.wrap_in_function"),
    EncryptStrings       = require("steps.encrypt_strings"),
    ConstantArray        = require("steps.constant_array"),
    AntiTamper           = require("steps.anti_tamper"),
    NumbersToExpressions = require("steps.numbers_to_expressions"),
    Vmify                = require("steps.vmify"),
}
