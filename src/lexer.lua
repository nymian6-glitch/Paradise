-- Aegis LuaU Obfuscator
-- lexer.lua -- Tokenizer for LuaU

local util = require("util")
local logger = require("logger")

local Lexer = {}

Lexer.TokenKind = {
    -- Literals
    Number     = "Number",
    String     = "String",
    Name       = "Name",
    -- Keywords
    Keyword    = "Keyword",
    -- Symbols
    Symbol     = "Symbol",
    -- Special
    Eof        = "Eof",
    -- Interpolated string
    InterpStringBegin = "InterpStringBegin",
    InterpStringMid   = "InterpStringMid",
    InterpStringEnd   = "InterpStringEnd",
}

local TK = Lexer.TokenKind

local keywords = util.lookupify {
    "and", "break", "do", "else", "elseif", "end",
    "false", "for", "function", "if", "in",
    "local", "nil", "not", "or", "repeat",
    "return", "then", "true", "until", "while",
    -- LuaU
    "continue", "typeof",
}

local symbols = util.lookupify {
    "+", "-", "*", "/", "//", "%", "^", "#",
    "==", "~=", "<", ">", "<=", ">=",
    "(", ")", "{", "}", "[", "]",
    ";", ":", ",", ".", "..", "...",
    "=",
    "+=", "-=", "*=", "/=", "//=", "%=", "^=", "..=",
    "->",
}

function Lexer:new(source, filename)
    local lexer = {
        source = source,
        filename = filename or "<input>",
        pos = 1,
        line = 1,
        col = 1,
        tokens = {},
        current = 1,
    }
    setmetatable(lexer, self)
    self.__index = self
    lexer:tokenize()
    return lexer
end

function Lexer:error(msg)
    logger:error(string.format("%s:%d:%d: %s", self.filename, self.line, self.col, msg))
end

function Lexer:peek(offset)
    offset = offset or 0
    local pos = self.pos + offset
    if pos > #self.source then return nil end
    return self.source:sub(pos, pos)
end

function Lexer:advance(n)
    n = n or 1
    for i = 1, n do
        local ch = self:peek()
        if ch == "\n" then
            self.line = self.line + 1
            self.col = 1
        else
            self.col = self.col + 1
        end
        self.pos = self.pos + 1
    end
end

function Lexer:match(str)
    local len = #str
    if self.source:sub(self.pos, self.pos + len - 1) == str then
        return true
    end
    return false
end

function Lexer:addToken(kind, value)
    self.tokens[#self.tokens + 1] = {
        kind = kind,
        value = value,
        line = self.line,
        col = self.col,
    }
end

function Lexer:skipWhitespaceAndComments()
    while self.pos <= #self.source do
        local ch = self:peek()

        if ch == " " or ch == "\t" or ch == "\r" or ch == "\n" or ch == "\f" then
            self:advance()
        elseif ch == "-" and self:peek(1) == "-" then
            self:advance(2)
            if self:peek() == "[" then
                local level = self:checkLongBracket()
                if level then
                    self:readLongString(level)
                else
                    while self.pos <= #self.source and self:peek() ~= "\n" do
                        self:advance()
                    end
                end
            else
                while self.pos <= #self.source and self:peek() ~= "\n" do
                    self:advance()
                end
            end
        else
            break
        end
    end
end

function Lexer:checkLongBracket()
    if self:peek() ~= "[" then return nil end
    local level = 0
    local offset = 1
    while self:peek(offset) == "=" do
        level = level + 1
        offset = offset + 1
    end
    if self:peek(offset) == "[" then
        return level
    end
    return nil
end

function Lexer:readLongString(level)
    local closing = "]" .. string.rep("=", level) .. "]"
    self:advance(level + 2)
    if self:peek() == "\n" then self:advance() end

    local start = self.pos
    while self.pos <= #self.source do
        if self:match(closing) then
            local content = self.source:sub(start, self.pos - 1)
            self:advance(#closing)
            return content
        end
        self:advance()
    end
    self:error("unfinished long string/comment")
end

function Lexer:readString(quote)
    self:advance()
    local parts = {}
    while self.pos <= #self.source do
        local ch = self:peek()
        if ch == quote then
            self:advance()
            return table.concat(parts)
        elseif ch == "\n" then
            self:error("unfinished string")
        elseif ch == "\\" then
            self:advance()
            local esc = self:peek()
            if esc == "a" then parts[#parts + 1] = "\a"; self:advance()
            elseif esc == "b" then parts[#parts + 1] = "\b"; self:advance()
            elseif esc == "f" then parts[#parts + 1] = "\f"; self:advance()
            elseif esc == "n" then parts[#parts + 1] = "\n"; self:advance()
            elseif esc == "r" then parts[#parts + 1] = "\r"; self:advance()
            elseif esc == "t" then parts[#parts + 1] = "\t"; self:advance()
            elseif esc == "v" then parts[#parts + 1] = "\v"; self:advance()
            elseif esc == "\\" then parts[#parts + 1] = "\\"; self:advance()
            elseif esc == "'" then parts[#parts + 1] = "'"; self:advance()
            elseif esc == "\"" then parts[#parts + 1] = "\""; self:advance()
            elseif esc == "\n" then parts[#parts + 1] = "\n"; self:advance()
            elseif esc == "x" then
                self:advance()
                local hex = ""
                for i = 1, 2 do
                    local h = self:peek()
                    if h and h:match("[0-9a-fA-F]") then
                        hex = hex .. h
                        self:advance()
                    end
                end
                parts[#parts + 1] = string.char(tonumber(hex, 16))
            elseif esc == "u" then
                self:advance()
                if self:peek() == "{" then
                    self:advance()
                    local hex = ""
                    while self:peek() and self:peek() ~= "}" do
                        hex = hex .. self:peek()
                        self:advance()
                    end
                    self:advance()
                    local cp = tonumber(hex, 16)
                    if cp <= 127 then
                        parts[#parts + 1] = string.char(cp)
                    else
                        parts[#parts + 1] = "\\u{" .. hex .. "}"
                    end
                end
            elseif esc == "z" then
                self:advance()
                while self.pos <= #self.source do
                    local c = self:peek()
                    if c == " " or c == "\t" or c == "\n" or c == "\r" or c == "\f" then
                        self:advance()
                    else
                        break
                    end
                end
            elseif esc and esc:match("[0-9]") then
                local num = esc
                self:advance()
                for i = 1, 2 do
                    local d = self:peek()
                    if d and d:match("[0-9]") then
                        num = num .. d
                        self:advance()
                    else
                        break
                    end
                end
                parts[#parts + 1] = string.char(tonumber(num))
            else
                parts[#parts + 1] = esc
                self:advance()
            end
        else
            parts[#parts + 1] = ch
            self:advance()
        end
    end
    self:error("unfinished string")
end

function Lexer:readNumber()
    local start = self.pos
    local ch = self:peek()

    if ch == "0" and self:peek(1) and self:peek(1):lower() == "x" then
        self:advance(2)
        while self.pos <= #self.source and self:peek() and self:peek():match("[0-9a-fA-F_]") do
            self:advance()
        end
    elseif ch == "0" and self:peek(1) and self:peek(1):lower() == "b" then
        self:advance(2)
        while self.pos <= #self.source and self:peek() and self:peek():match("[01_]") do
            self:advance()
        end
    else
        while self.pos <= #self.source and self:peek() and self:peek():match("[0-9_]") do
            self:advance()
        end
        if self:peek() == "." and self:peek(1) and self:peek(1):match("[0-9]") then
            self:advance()
            while self.pos <= #self.source and self:peek() and self:peek():match("[0-9_]") do
                self:advance()
            end
        end
        if self:peek() and self:peek():lower() == "e" then
            self:advance()
            if self:peek() == "+" or self:peek() == "-" then
                self:advance()
            end
            while self.pos <= #self.source and self:peek() and self:peek():match("[0-9_]") do
                self:advance()
            end
        end
    end

    local raw = self.source:sub(start, self.pos - 1):gsub("_", "")
    local value = tonumber(raw)
    if not value then
        self:error("invalid number: " .. raw)
    end
    return value
end

function Lexer:readName()
    local start = self.pos
    while self.pos <= #self.source do
        local ch = self:peek()
        if ch and ch:match("[%w_]") then
            self:advance()
        else
            break
        end
    end
    return self.source:sub(start, self.pos - 1)
end

function Lexer:readInterpolatedString()
    self:advance()
    local parts = {}
    local current = {}

    while self.pos <= #self.source do
        local ch = self:peek()
        if ch == "`" then
            self:advance()
            if #current > 0 then
                parts[#parts + 1] = { type = "string", value = table.concat(current) }
            end
            return parts
        elseif ch == "{" then
            self:advance()
            if #current > 0 then
                parts[#parts + 1] = { type = "string", value = table.concat(current) }
                current = {}
            end
            local exprTokens = {}
            local braceDepth = 1
            while self.pos <= #self.source and braceDepth > 0 do
                local c = self:peek()
                if c == "{" then braceDepth = braceDepth + 1
                elseif c == "}" then braceDepth = braceDepth - 1 end
                if braceDepth > 0 then
                    exprTokens[#exprTokens + 1] = c
                end
                self:advance()
            end
            parts[#parts + 1] = { type = "expr", value = table.concat(exprTokens) }
        elseif ch == "\\" then
            self:advance()
            local esc = self:peek()
            if esc == "n" then current[#current + 1] = "\n"; self:advance()
            elseif esc == "t" then current[#current + 1] = "\t"; self:advance()
            elseif esc == "\\" then current[#current + 1] = "\\"; self:advance()
            elseif esc == "`" then current[#current + 1] = "`"; self:advance()
            elseif esc == "{" then current[#current + 1] = "{"; self:advance()
            else current[#current + 1] = esc; self:advance() end
        else
            current[#current + 1] = ch
            self:advance()
        end
    end
    self:error("unfinished interpolated string")
end

function Lexer:tokenize()
    while self.pos <= #self.source do
        self:skipWhitespaceAndComments()
        if self.pos > #self.source then break end

        local ch = self:peek()

        if ch:match("[%a_]") then
            local name = self:readName()
            if keywords[name] then
                self:addToken(TK.Keyword, name)
            else
                self:addToken(TK.Name, name)
            end

        elseif ch:match("[0-9]") or (ch == "." and self:peek(1) and self:peek(1):match("[0-9]")) then
            local num = self:readNumber()
            self:addToken(TK.Number, num)

        elseif ch == "\"" or ch == "'" then
            local str = self:readString(ch)
            self:addToken(TK.String, str)

        elseif ch == "`" then
            local parts = self:readInterpolatedString()
            self:addToken(TK.String, parts)

        elseif ch == "[" then
            local level = self:checkLongBracket()
            if level then
                local str = self:readLongString(level)
                self:addToken(TK.String, str)
            else
                self:addToken(TK.Symbol, "[")
                self:advance()
            end

        elseif ch == "." then
            if self:peek(1) == "." then
                if self:peek(2) == "." then
                    self:addToken(TK.Symbol, "...")
                    self:advance(3)
                elseif self:peek(2) == "=" then
                    self:addToken(TK.Symbol, "..=")
                    self:advance(3)
                else
                    self:addToken(TK.Symbol, "..")
                    self:advance(2)
                end
            else
                self:addToken(TK.Symbol, ".")
                self:advance()
            end

        elseif ch == "+" then
            if self:peek(1) == "=" then
                self:addToken(TK.Symbol, "+="); self:advance(2)
            else
                self:addToken(TK.Symbol, "+"); self:advance()
            end
        elseif ch == "-" then
            if self:peek(1) == "=" then
                self:addToken(TK.Symbol, "-="); self:advance(2)
            elseif self:peek(1) == ">" then
                self:addToken(TK.Symbol, "->"); self:advance(2)
            else
                self:addToken(TK.Symbol, "-"); self:advance()
            end
        elseif ch == "*" then
            if self:peek(1) == "=" then
                self:addToken(TK.Symbol, "*="); self:advance(2)
            else
                self:addToken(TK.Symbol, "*"); self:advance()
            end
        elseif ch == "/" then
            if self:peek(1) == "/" then
                if self:peek(2) == "=" then
                    self:addToken(TK.Symbol, "//="); self:advance(3)
                else
                    self:addToken(TK.Symbol, "//"); self:advance(2)
                end
            elseif self:peek(1) == "=" then
                self:addToken(TK.Symbol, "/="); self:advance(2)
            else
                self:addToken(TK.Symbol, "/"); self:advance()
            end
        elseif ch == "%" then
            if self:peek(1) == "=" then
                self:addToken(TK.Symbol, "%="); self:advance(2)
            else
                self:addToken(TK.Symbol, "%"); self:advance()
            end
        elseif ch == "^" then
            if self:peek(1) == "=" then
                self:addToken(TK.Symbol, "^="); self:advance(2)
            else
                self:addToken(TK.Symbol, "^"); self:advance()
            end
        elseif ch == "=" then
            if self:peek(1) == "=" then
                self:addToken(TK.Symbol, "=="); self:advance(2)
            else
                self:addToken(TK.Symbol, "="); self:advance()
            end
        elseif ch == "~" then
            if self:peek(1) == "=" then
                self:addToken(TK.Symbol, "~="); self:advance(2)
            else
                self:error("unexpected character: ~")
            end
        elseif ch == "<" then
            if self:peek(1) == "=" then
                self:addToken(TK.Symbol, "<="); self:advance(2)
            else
                self:addToken(TK.Symbol, "<"); self:advance()
            end
        elseif ch == ">" then
            if self:peek(1) == "=" then
                self:addToken(TK.Symbol, ">="); self:advance(2)
            else
                self:addToken(TK.Symbol, ">"); self:advance()
            end
        elseif ch == "#" or ch == "(" or ch == ")" or ch == "{" or ch == "}"
            or ch == "]" or ch == ";" or ch == ":" or ch == "," then
            self:addToken(TK.Symbol, ch)
            self:advance()
        else
            self:error("unexpected character: " .. ch)
        end
    end

    self:addToken(TK.Eof, "")
end

-- Token stream interface
function Lexer:peekToken(offset)
    offset = offset or 0
    local idx = self.current + offset
    if idx > #self.tokens then
        return self.tokens[#self.tokens]
    end
    return self.tokens[idx]
end

function Lexer:nextToken()
    local tok = self.tokens[self.current]
    if self.current < #self.tokens then
        self.current = self.current + 1
    end
    return tok
end

function Lexer:expect(kind, value)
    local tok = self:peekToken()
    if tok.kind ~= kind then
        self:error(string.format("expected %s, got %s '%s'", kind, tok.kind, tostring(tok.value)))
    end
    if value and tok.value ~= value then
        self:error(string.format("expected '%s', got '%s'", value, tostring(tok.value)))
    end
    return self:nextToken()
end

function Lexer:check(kind, value)
    local tok = self:peekToken()
    if tok.kind ~= kind then return false end
    if value and tok.value ~= value then return false end
    return true
end

function Lexer:consume(kind, value)
    if self:check(kind, value) then
        return self:nextToken()
    end
    return nil
end

return Lexer
