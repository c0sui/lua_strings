local mt = getmetatable("String")

--[[
	Library «Strings», v3.0
	Custom strings methods

	Author: Cosmo
	VK: vk.me/cosui
	TG: t.me/c0sui
	BH: blast.hk/members/217639
]]

local orig_lower = string.lower
local orig_upper = string.upper

---[Strings.lua] Inserts a substring into the string at the specified position.
--- @param self string     -- The original string
--- @param implant string  -- The substring to insert
--- @param pos number?     -- The position at which to insert the substring (default is at the end)
--- @return string         -- The string with the inserted substring
--- @nodiscard
---
---Examples:
---```lua
---string.insert("Hello World", "Lua ", 7) -- Output: "Hello Lua World"
---string.insert("Hello", " there!") -- Output: "Hello there!"
---```
function mt.__index:insert(implant, pos)
	if pos == nil then
		return self .. implant
	end
	return self:sub(1, pos - 1) .. implant .. self:sub(pos)
end

---[Strings.lua] Removes all occurrences of the pattern from the string.
--- @param self string    -- The original string
--- @param pattern string -- The pattern to be removed (Lua pattern)
--- @return string        -- The string with the pattern removed
--- @nodiscard
---
---Example:
---```lua
---string.extract("Hello123World456", "%d+") -- Output: "HelloWorld"
---```
function mt.__index:extract(pattern)
	self = self:gsub(pattern, "")
	return self
end

---[Strings.lua] Converts the string into an array where each character is an element.
--- @param self string   -- The original string
--- @return table        -- An array of characters from the string
--- @nodiscard
---
---Example:
---```lua
---string.array("Hello") -- Output: {"H", "e", "l", "l", "o"}
---```
function mt.__index:array()
	local array = {}
	for s in self:gmatch(".") do
		array[#array + 1] = s
	end
	return array
end

---[Strings.lua] Checks if the string is empty.
--- @param self string   -- The string to check
--- @return boolean      -- Returns `true` if the string is empty, otherwise `false`
--- @nodiscard
---
---Examples:
---```lua
---string.isEmpty("") -- Output: true
---string.isEmpty("abc") -- Output: false
---```
function mt.__index:isEmpty()
	return self == ""
end

---[Strings.lua] Checks if the string contains only digits.
--- @param self string   -- The string to check
--- @return boolean      -- Returns `true` if the string contains only digits, otherwise `false`
--- @nodiscard
---
---Examples:
---```lua
---string.isDigit("12345") -- Output: true
---string.isDigit("123a45") -- Output: false
---```
function mt.__index:isDigit()
	return self:find("%D") == nil
end

---[Strings.lua] Checks if the string contains only alphabetic characters (no digits or punctuation).
--- @param self string   -- The string to check
--- @return boolean      -- Returns `true` if the string contains only alphabetic characters, otherwise `false`
--- @nodiscard
---
---Examples:
---```lua
---string.isAlpha("Hello") -- Output: true
---string.isAlpha("Hello123") -- Output: false
---string.isAlpha("Hello!") -- Output: false
---```
function mt.__index:isAlpha()
	return self:find("[%d%p]") == nil
end

---[Strings.lua] Splits the string into a table of substrings based on the specified separator.
--- @param self string        -- The original string to split
--- @param sep string?        -- The separator string (default is space)
--- @param plain boolean?     -- If `true`, treats the separator as a plain string (default is `false`)
--- @return table             -- A table containing the substrings
--- @nodiscard
---
---Examples:
---```lua
---string.split("Hello world, Lua!") -- Output: {"Hello", "world,", "Lua!"}
---string.split("abc", "") -- Output: {"a", "b", "c"}
---```
function mt.__index:split(sep, plain)
	local result = {}
	local pos = 1
	sep = sep or " "
	if sep:isEmpty() then
		for i = 1, #self do
			result[i] = self:sub(i, i)
		end
	else
		while pos <= #self do
			local s, f = self:find(sep, pos, plain)
			if s then
				table.insert(result, self:sub(pos, s - 1))
				pos = f + 1
			else
				table.insert(result, self:sub(pos))
				break
			end
		end
	end
	return result
end

---[Strings.lua] Converts the string to lowercase (Cyrillic support).
--- @param self string   -- The original string to convert
--- @return string       -- The lowercase version of the string
--- @nodiscard
---
---Examples:
---```lua
---string.lower("HeLLo WoRLd!") -- Output: "hello world!"
---string.lower("Привет Мир!") -- Output: "привет мир!"
---```
function mt.__index:lower()
	for i = 192, 223 do
		self = self:gsub(string.char(i), string.char(i + 32))
	end
	self = self:gsub(string.char(168), string.char(184))
	return orig_lower(self)
end

---[Strings.lua] Converts the string to uppercase (Cyrillic support).
--- @param self string   -- The original string to convert
--- @return string       -- The uppercase version of the string
--- @nodiscard
---
---Examples:
---```lua
---string.lower("HeLLo WoRLd!") -- Output: "HELLO WORLD!"
---string.lower("Привет Мир!") -- Output: "ПРИВЕТ МИР!"
---```
function mt.__index:upper()
	for i = 224, 255 do
		self = self:gsub(string.char(i), string.char(i - 32))
	end
	self = self:gsub(string.char(184), string.char(168))
	return orig_upper(self)
end

---[Strings.lua] Checks if the string consists entirely of whitespace or control characters.
--- @param self string   -- The string to check
--- @return boolean      -- Returns `true` if the string contains only whitespace or control characters, otherwise `false`
--- @nodiscard
---
---Examples:
---```lua
---string.isSpace("    ") -- Output: true
---string.isSpace("\t\n\r") -- Output: true
---string.isSpace("Hello") -- Output: false
---```
function mt.__index:isSpace()
	return self:find("^[%s%c]*$") ~= nil
end

---[Strings.lua] Checks if the string is in uppercase.
--- @param self string   -- The string to check
--- @return boolean      -- Returns `true` if the string is fully uppercase, otherwise `false`
--- @nodiscard
---
---Examples:
---```lua
---string.isUpper("HELLO") -- Output: true
---string.isUpper("Hello") -- Output: false
---string.isUpper("123") -- Output: false
---```
function mt.__index:isUpper()
	return self:upper() == self
end

---[Strings.lua] Checks if the string is in lowercase.
--- @param self string   -- The string to check
--- @return boolean      -- Returns `true` if the string is fully lowercase, otherwise `false`
--- @nodiscard
---
---Examples:
---```lua
---string.isLower("hello") -- Output: true
---string.isLower("Hello") -- Output: false
---string.isLower("123") -- Output: false
---```
function mt.__index:isLower()
	return self:lower() == self
end

---[Strings.lua] Checks if the string is similar (equal) to another string.
--- @param self string   -- The original string to compare
--- @param str string    -- The string to compare with
--- @return boolean      -- Returns `true` if the strings are equal, otherwise `false`
--- @nodiscard
---
---Examples:
---```lua
---string.isSimilar("test", "test") -- Output: true
---string.isSimilar("test", "Test") -- Output: false
---```
function mt.__index:isSimilar(str)
	return self == str
end

---[Strings.lua] Checks if the first letter of the string is uppercase (title case).
--- @param self string   -- The string to check
--- @return boolean      -- Returns `true` if the first letter is uppercase, otherwise `false`
--- @nodiscard
---
---Examples:
---```lua
---string.isTitle("Hello world") -- Output: true
---string.isTitle("hello world") -- Output: false
---```
function mt.__index:isTitle()
	local p = self:find("[A-zА-яЁё]")
	local let = self:sub(p, p)
	return let:isSimilar(let:upper())
end

---[Strings.lua] Checks if the string starts with the specified substring.
--- @param self string   -- The original string to check
--- @param str string    -- The substring to check for at the start of the string
--- @return boolean      -- Returns `true` if the string starts with the specified substring, otherwise `false`
--- @nodiscard
---
---Examples:
---```lua
---string.startsWith("Hello world", "Hello") -- Output: true
---string.startsWith("Hello world", "world") -- Output: false
---```
function mt.__index:startsWith(str)
	return self:sub(1, #str):isSimilar(str)
end

---[Strings.lua] Checks if the string ends with the specified substring.
--- @param self string   -- The original string to check
--- @param str string    -- The substring to check for at the end of the string
--- @return boolean      -- Returns `true` if the string ends with the specified substring, otherwise `false`
--- @nodiscard
---
---Examples:
---```lua
---string.endsWith("Hello world", "world") -- Output: true
---string.endsWith("Hello world", "Hello") -- Output: false
---```
function mt.__index:endsWith(str)
	return self:sub(#self - #str + 1, #self):isSimilar(str)
end

---[Strings.lua] Capitalizes the first letter of the string.
--- @param self string   -- The original string to capitalize
--- @return string       -- The string with the first letter capitalized
--- @nodiscard
---
---Examples:
---```lua
---string.capitalize("hello WORLD") -- Output: "Hello WORLD"
---```
function mt.__index:capitalize()
	self = self:gsub("^.", string.upper)
	return self
end

---[Strings.lua] Converts the first letter of the string to lowercase.
--- @param self string   -- The original string to uncapitalize
--- @return string       -- The string with the first letter in lowercase
--- @nodiscard
---
---Example:
---```lua
---string.uncapitalize("Hello WORLD") -- Output: "hello WORLD"
---```
function mt.__index:uncapitalize()
	self = self:gsub("^.", string.lower)
	return self
end

---[Strings.lua] Replaces tabs in the string with a specified number of spaces.
--- @param self string       -- The original string containing tabs
--- @param count number?     -- The number of spaces to replace each tab with (default is 4)
--- @return string           -- The string with tabs replaced by spaces
--- @nodiscard
---
---Examples:
---```lua
---string.tabsToSpace("\t", 2) -- Output: "  "
---string.tabsToSpace("\t") -- Output: "    "
---```
function mt.__index:tabsToSpace(count)
	local spaces = (" "):rep(count or 4)
	self = self:gsub("\t", spaces)
	return self
end

---[Strings.lua] Replaces a specified number of spaces in the string with tabs.
--- @param self string       -- The original string containing spaces
--- @param count number?     -- The number of spaces to replace with a tab (default is 4)
--- @return string           -- The string with spaces replaced by tabs
--- @nodiscard
---
---Examples:
---```lua
---string.tabsToSpace("  ", 2) -- Output: "\t"
---string.tabsToSpace("    ") -- Output: "\t"
---```
function mt.__index:spaceToTabs(count)
	local spaces = (" "):rep(count or 4)
	self = self:gsub(spaces, "\t")
	return self
end

---[Strings.lua] Centers the string within a specified width, padding with a specified character.
--- @param self string      -- The original string to center
--- @param width number     -- The total width of the resulting string
--- @param char string?     -- The character used for padding (default is a space)
--- @return string          -- The centered string with padding
--- @nodiscard
---
---Examples:
---```lua
---string.center("Hello", 10) -- Output: "  Hello   "
---string.center("Text", 8, "-") -- Output: "--Text--"
---```
function mt.__index:center(width, char)
	char = char or " "
    local len = #self
    if len >= width then
        return self
    end
    local pad_total = width - len
    local pad_left = math.floor(pad_total / 2)
    local pad_right = pad_total - pad_left
    return string.rep(char, pad_left) .. self .. string.rep(char, pad_right)
end

---[Strings.lua] Counts the number of occurrences of a substring within a specified range of the string.
--- @param self string        -- The original string to search within
--- @param search string      -- The substring to count occurrences of
--- @param p1 number?         -- The starting position for the search (default is 1)
--- @param p2 number?         -- The ending position for the search (default is the length of the string)
--- @return number            -- The number of occurrences of the substring
--- @nodiscard
---
---Examples:
---```lua
---string.count("Hello world, hello!", "hello") -- Output: 1
---string.count("abcabcabc", "a") -- Output: 3
---string.count("123456789", "0") -- Output: 0
---```
function mt.__index:count(search, p1, p2)
	local area = self:sub(p1 or 1, p2 or #self)
	local count, pos = 0, p1 or 1
	repeat
		local s, f = area:find(search, pos, true)
		count = s and count + 1 or count
		pos = f and f + 1
	until pos == nil
	return count
end

---[Strings.lua] Removes trailing whitespace from the end of the string.
--- @param self string   -- The original string to trim
--- @return string       -- The string with trailing whitespace removed
--- @nodiscard
---
---Examples:
---```lua
---string.trimEnd("Hello world   ") -- Output: "Hello world"
---string.trimEnd("   Leading") -- Output: "   Leading"
---string.trimEnd("NoSpaces") -- Output: "NoSpaces"
---```
function mt.__index:trimEnd()
	self = self:gsub("%s*$", "")
	return self
end

---[Strings.lua] Removes leading whitespace from the start of the string.
--- @param self string   -- The original string to trim
--- @return string       -- The string with leading whitespace removed
--- @nodiscard
---
---Examples:
---```lua
---string.trimStart("   Hello world") -- Output: "Hello world"
---string.trimStart("Leading   ") -- Output: "Leading   "
---string.trimStart("NoSpaces") -- Output: "NoSpaces"
---```
function mt.__index:trimStart()
	self = self:gsub("^%s*", "")
	return self
end

---[Strings.lua] Removes leading and trailing whitespace from the string.
--- @param self string   -- The original string to trim
--- @return string       -- The string with both leading and trailing whitespace removed
--- @nodiscard
---
---Examples:
---```lua
---string.trim("   Hello world   ") -- Output: "Hello world"
---string.trim("NoSpaces") -- Output: "NoSpaces"
---```
function mt.__index:trim()
	self = self:match("^%s*(.-)%s*$")
	return self
end

---[Strings.lua] Swaps the case of each alphabetic character in the string (lowercase to uppercase and vice versa).
--- @param self string   -- The original string to modify
--- @return string       -- The string with the case of each alphabetic character swapped
--- @nodiscard
---
---Example:
---```lua
---string.swapCase("Hello World")  -- Output: "hELLO wORLD"
---```
function mt.__index:swapCase()
	local result = {}
	for s in self:gmatch(".") do
		if s:isAlpha() then
			s = s:isLower() and s:upper() or s:lower()
		end
		result[#result + 1] = s
	end
	return table.concat(result)
end

---[Strings.lua] Splits the string into equal-length segments based on the specified width.
--- @param self string       -- The original string to split
--- @param width number      -- The width of each segment
--- @return table            -- A table containing the segments
--- @nodiscard
---
---Example:
---```lua
---string.splitEqually("hello", 2) -- Output: {"he", "ll", "o"}
---```
function mt.__index:splitEqually(width)
	assert(width > 0, "Width less than zero")
	if width >= self:len() then
		return { self }
	end

	local result, i = {}, 1
	repeat
		if #result == 0 or #result[#result] >= width then
			result[#result + 1] = ""
		end
		result[#result] = result[#result] .. self:sub(i, i)
		i = i + 1
	until i > #self
	return result
end

---[Strings.lua] Finds the last occurrence of a pattern in the string, searching backwards from a specified position.
--- @param self string         -- The original string to search within
--- @param pattern string      -- The pattern to search for
--- @param pos number?         -- The starting position for the search (default is the end of the string)
--- @param plain boolean?      -- If `true`, treats the pattern as a plain string (default is `false`)
--- @return number, number?    -- The starting and ending positions of the found pattern, or `nil` if not found
--- @nodiscard
---
---Example:
---```lua
---string.rFind("Hello World", "o") -- Output: 8, 8 (last "o")
---```
function mt.__index:rFind(pattern, pos, plain)
	local i = pos or #self
	repeat
		local result = { self:find(pattern, i, plain) }
		if next(result) ~= nil then
			return table.unpack(result)
		end
		i = i - 1
	until i <= 0
	return nil
end

---[Strings.lua] Wraps the string at a specified width, inserting newlines to ensure no line exceeds the width.
--- @param self string       -- The original string to wrap
--- @param width number      -- The maximum width of each line (must be greater than zero)
--- @return string           -- The wrapped string with newlines inserted
--- @nodiscard
---
---Examples:
---```lua
---string.wrap("Hello World", 10) -- Output: "Hello\nWorld"
---string.wrap("Hello World", 20) -- Output: "Hello World"
---```
function mt.__index:wrap(width)
	assert(width > 0, "Width less than zero")
	if width < self:len() then
		local pos = 1
		self = self:gsub("(%s+)()(%S+)()", function(sp, st, word, fi)
			if fi - pos > (width or 72) then
				pos = st
				return "\n" .. word
			end
		end)
	end
	return self
end

---[Strings.lua] Computes the Levenshtein distance between two strings, which is a measure of the difference between them.
--- @param self string       -- The first string for comparison
--- @param str string        -- The second string for comparison
--- @return number           -- The Levenshtein distance between the two strings
--- @nodiscard
---
---Examples:
---```lua
---string.levDist("kitten", "sitting") -- Output: 3
---string.levDist("flaw", "lawn") -- Output: 2
---string.levDist("test", "test") -- Output: 0
---```
---[About levenshtein distance](https://en.wikipedia.org/wiki/Levenshtein_distance)
function mt.__index:levDist(str)
	if #self == 0 then
		return #str
	elseif #str == 0 then
		return #self
	elseif self == str then
		return 0
	end

	local cost = 0
	local matrix = {}
	for i = 0, #self do
		matrix[i] = {}; matrix[i][0] = i
	end
	for i = 0, #str do matrix[0][i] = i end
	for i = 1, #self, 1 do
		for j = 1, #str, 1 do
			cost = self:byte(i) == str:byte(j) and 0 or 1
			matrix[i][j] = math.min(
				matrix[i - 1][j] + 1,
				matrix[i][j - 1] + 1,
				matrix[i - 1][j - 1] + cost
			)
		end
	end
	return matrix[#self][#str]
end

---[Strings.lua] Calculates the similarity between two strings based on their Levenshtein distance.
--- @param self string       -- The first string for comparison
--- @param str string        -- The second string for comparison
--- @return number, number   -- The similarity score (0 to 1) and the Levenshtein distance
--- @nodiscard
---
---Examples:
---```lua
---string.getSimilarity("kitten", "sitting") -- Output: 0.571, 3
---string.getSimilarity("flaw", "lawn") -- Output: 0.5, 2
---string.getSimilarity("test", "test") -- Output: 1.0, 0
---```
function mt.__index:getSimilarity(str)
	local dist = self:levDist(str)
	return 1 - dist / math.max(#self, #str), dist
end

---[Strings.lua] Returns an empty string.
--- @param self string   -- The original string (not used)
--- @return string       -- An empty string
--- @nodiscard
---
---Example:
---```lua
---string.empty() -- Output: ""
---```
function mt.__index:empty()
	return ""
end

---[Strings.lua] Converts the string into camel case format, alternating the case of each character.
--- @param self string       -- The original string to convert
--- @return string           -- The string in camel case format
--- @nodiscard
---
---Example:
---```lua
---string.toCamel("hello world") -- Output: "HeLlO WoRlD"
---```
function mt.__index:toCamel()
	local arr = self:array()
	for i, let in ipairs(arr) do
		arr[i] = (i % 2 == 0) and let:lower() or let:upper()
	end
	return table.concat(arr)
end

---[Strings.lua] Escapes special characters in the string to be used in a Lua pattern.
--- @param self string       -- The original string to escape
--- @return string           -- The escaped string, suitable for use in pattern matching
--- @nodiscard
---
---Examples:
---```lua
---string.reg_escape("Hello. How are you?") -- Output: "Hello%. How are you%?"
---string.reg_escape("5+5=10") -- Output: "5%+5=10"
---```
function mt.__index:reg_escape()
	return (self:gsub("(%W)", "%%%1"))
end

---[Strings.lua] Shuffles the characters in the string randomly based on an optional seed.
--- @param self string       -- The original string to shuffle
--- @param seed number?      -- The seed for the random number generator (default is the current time)
--- @return string           -- A new string with the characters shuffled
--- @nodiscard
---
---Examples:
---```lua
---string.shuffle("hello") -- Output: "helhe" (possible way)
---string.shuffle(123) -- Output: "hlleo" (always the same)
---```
function mt.__index:shuffle(seed)
	math.randomseed(seed or os.clock())
	local arr, new = self:array(), {}
	for i = 1, #arr do
		new[i] = arr[math.random(#arr)]
	end
	return table.concat(new)
end

---[Strings.lua] Truncates the string to a specified maximum length and appends a symbol if truncated.
--- @param self string       -- The original string to truncate
--- @param max_len number    -- The maximum length of the resulting string (must be greater than 0)
--- @param symbol string?    -- The symbol to append if the string is truncated (default is "..")
--- @return string           -- The truncated string with the symbol appended if necessary
--- @nodiscard
---
---Examples:
---```lua
---string.cutLimit("Hello World", 5) -- Output: "Hello.."
---string.cutLimit("Hello World", 5, "---") -- Output: "Hello---"
---string.cutLimit("Hello World", 15) -- Output: "Hello World" (not truncated)
---```
function mt.__index:cutLimit(max_len, symbol)
	assert(max_len > 0, "Maximum length cannot be less than or equal to 1")
	if #self > 0 and #self > max_len then
		symbol = symbol or ".."
		self = self:sub(1, max_len) .. symbol
	end
	return self
end

---[Strings.lua] Switches the keyboard layout of the string between Russian and English based on a specified mapping.
--- @param self string       -- The original string to convert
--- @return string           -- The string with the switched layout
--- @nodiscard
---
---Examples:
---```lua
---string.switchLayout("привет") -- Output: "ghbdtn"
---string.switchLayout("ghbdtn") -- Output: "привет"
---```
function mt.__index:switchLayout()
	local result = ""
	local b = self:find("^[%s%p]*%a") ~= nil
	local t = {
		{ "а", "f" }, { "б", "," }, { "в", "d" },
		{ "г", "u" }, { "д", "l" }, { "е", "t" },
		{ "ё", "`" }, { "ж", ";" }, { "з", "p" },
		{ "и", "b" }, { "й", "q" }, { "к", "r" },
		{ "л", "k" }, { "м", "v" }, { "н", "y" },
		{ "о", "j" }, { "п", "g" }, { "р", "h" },
		{ "с", "c" }, { "т", "n" }, { "у", "e" },
		{ "ф", "a" }, { "х", "[" }, { "ц", "w" },
		{ "ч", "x" }, { "ш", "i" }, { "щ", "o" },
		{ "ь", "m" }, { "ы", "s" }, { "ъ", "]" },
		{ "э", "'" }, { "/", "." }, { "я", "z" },
		{ "А", "F" }, { "Б", "<" }, { "В", "D" },
		{ "Г", "U" }, { "Д", "L" }, { "Е", "T" },
		{ "Ё", "~" }, { "Ж", ":" }, { "З", "P" },
		{ "И", "B" }, { "Й", "Q" }, { "К", "R" },
		{ "Л", "K" }, { "М", "V" }, { "Н", "Y" },
		{ "О", "J" }, { "П", "G" }, { "Р", "H" },
		{ "С", "C" }, { "Т", "N" }, { "У", "E" },
		{ "Ф", "A" }, { "Х", "{" }, { "Ц", "W" },
		{ "Ч", "X" }, { "Ш", "I" }, { "Щ", "O" },
		{ "Ь", "M" }, { "Ы", "S" }, { "Ъ", "}" },
		{ "Э", "\"" }, { "Ю", ">" }, { "Я", "Z" }
	}

	for l in self:gmatch(".") do
		local fined = false
		for _, v in ipairs(t) do
			if l == v[b and 2 or 1] then
				l = v[b and 1 or 2]
				fined = true
				break
			end
		end
		if not fined then
			for _, v in ipairs(t) do
				if l == v[b and 1 or 2] then
					l = v[b and 2 or 1]
					break
				end
			end
		end
		result = (result .. l)
	end
	return result
end