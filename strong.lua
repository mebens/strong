-- METATABLE --
local mt = getmetatable("")

-- OPERATORS --

function mt.__add(a, b) return a .. b end
function mt.__sub(a, b) return a:gsub(b, "") end
function mt.__mul(a, b) return a:rep(b) end
function mt.__div(a, b) return a:split(b, true) end

-- INDEXING --

function mt:__index(key)
  if type(key) == 'number' then
    return self:sub(key, key)
  else
    return string[key]
  end
end

function mt:__call(i, j)
  if type(i) == 'string' then
    return self:match(i, j)
  else
    return self:sub(i, j or i)
  end
end

-- METHODS --

function string:bytes(func)
  if func then
    for i = 1, self:len() do func(self[i]:byte()) end
  else
    return { self:byte(1, -1) }
  end
end

function string:capitalize()
  return self:lower():gsub('^%l', string.upper)
end

-- TODO: center

function string:chars(func)
  if func then
    for i = 1, self:len() do func(self[i]) end
  end
end

function string:chomp(sep)
  return self:gsub((sep or "[\n\r]") .. '+$', '')
end

-- this doesn't behave like Ruby in that it discards the separator
-- it's method of detecting newlines is a bit dodgy too: \n\n would count as 1 separator
function string:eachLine(...)
  local sep = "[\n\r]+"
  local func
  
  if select('#', ...) == 2 then
    sep, func = ...
  else
    func = select(1, ...)
  end
  
  local lines = self:split(sep)
  
  if func then
    for i = 1, #lines do func(lines[i]) end
  else
    return lines
  end
end

function string:endsWith(suffix)
  return self:sub(-suffix:len(), -1) == suffix
end

function string:includes(pat)
  return self:find(pat) ~= nil
end

-- insertion postion:
-- ---------------------
-- | A | B | C | D | E |
-- ---------------------
-- 1   2   3   4   5   6
-- -6 -5  -4  -3  -2  -1
function string:insert(index, other)
  index = (index < 0 and index + 1 or index) % (#self + 1)
  
  if index == 1 then
    return other .. self
  elseif index == 0 then
    return self .. other
  else
    return self:sub(1, index - 1) .. other .. self:sub(index)
  end
end

function string:isLower()
  if #self == 0 then return false end
  
  for i = 1, #self do
    if not (self[i] >= 'a' and self[i] <= 'z') then
      return false
    end
  end
  
  return true
end

function string:isUpper()
  if #self == 0 then return false end
  
  for i = 1, #self do
    if not (self[i] >= 'A' and self[i] <= 'Z') then
      return false
    end
  end
  
  return true
end

function string:ljust(int, padstr)
  local len = #self
  
  if int > len then
    local num = padstr and math.floor((int - len) / padstr:len()) or int - len
    self = self .. (padstr or ' ') * num
    len = #self
    if len < int then self = self .. padstr:sub(1, int - len) end
  end
  
  return self
end

function string:lstrip()
  return self:gsub('^[\r\n\t ]+', '')
end

-- note: this doesn't behave like Ruby's String#next method
function string:next()
  if self:len() == 1 then
    return string.char(self:byte() + 1)
  else
    local bytes = self:bytes()
    for i = 1, #bytes do bytes[i] = bytes[i] + 1 end
    return string.char(unpack(bytes))
  end
end

function string:rjust(int, padstr)
  local len = #self
  
  if int > len then
    local num = padstr and math.floor((int - len) / padstr:len()) or int - len
    self = ((padstr or ' ') * num) .. self
    len = #self
    if len < int then self = padstr:sub(1, int - len) .. self end
  end
  
  return self
end

function string:rstrip()
  return self:gsub('[\r\n\t ]+$', '')
end

-- credits go to thelinx for most of this function
-- https://github.com/TheLinx/loveclass/blob/master/stringextensions.lua#L6
function string:split(pat, plain)
  local t = {}
  
  while true do
    local pos1, pos2 = self:find(pat, 1, plain or false)

    if not pos1 then
      t[#t + 1] = self
      return t
    end
    
    t[#t + 1] = self:sub(1, pos1 - 1)
    self = self:sub(pos2 + 1)
  end
end

function string:squeeze(other)
  if other then
    return self:gsub(other .. other .. '+', other)
  else
    return self:gsub('(.)(%1+)', '%1') -- this doesn't work
  end
end

function string:startsWith(prefix)
  return self:sub(1, prefix:len()) == prefix
end

function string:strip()
  return self:lstrip():rstrip()
end

local function swapChar(c)
  if c:isUpper() then return c:lower() end
  return c:upper()
end

function string:swapcase()
  return self:gsub('%a', swapChar)
end
