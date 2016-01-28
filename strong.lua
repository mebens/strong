-- strong 1.0.4 - Michael Ebens
-- Licensed under the zlib/libpng license. See LICENSE.txt.

-- PRIVATE FUNCTIONS --

local function swapChar(c)
  if c:isUpper() then return c:lower() end
  return c:upper()
end

local function iter(state)
  state.i = state.i + 1
  local v = state.t[state.i]
  if v then return v end
end

local function byteIter(state)
  state.i = state.i + 1
  local v = state.t[state.i]
  if v then return v:byte() end
end

-- METATABLE --

local mt = getmetatable("")

-- OPERATORS --

function mt.__add(a, b) return a .. b end
function mt.__sub(a, b) return a:gsub(b, "") end
function mt.__mul(a, b) return a:rep(b) end
function mt.__div(a, b) return a:split(b, true) end
function mt.__mod(a, b)
   if type(b) == "table" then
      return a:format(unpack(b))
   else
      return a:format(b)
   end
end

-- INDEXING --

function mt:__index(key)
  if type(key) == "number" then
    local len = #self
    if key > len or key < -len or key == 0 then return nil end
    return self:sub(key, key)
  else
    return string[key]
  end
end

function mt:__call(i, j)
  if type(i) == "string" then
    return self:match(i, j)
  else
    local len = #self
    if i > len or i < -len or i == 0 then return nil end
    return self:sub(i, j or i)
  end
end

-- METHODS --

function string:bytes(all)
  if all then
    return { self:byte(1, -1) }
  else
    return byteIter, { t = self, i = 0 }
  end
end

function string:camelize(upper)
  self = self:lower():gsub("[ \t_%-](.)", string.upper)
  return upper and self:gsub("^%l", string.upper) or self 
end

function string:capitalize()
  return self:lower():gsub("^%l", string.upper)
end

function string:center(int, padstr)
  local len = #self
  local diff = padstr and math.floor((int - len) / #padstr) or int - len
  local left = len + math.ceil(diff / 2)
  return self:ljust(left, padstr):rjust(left + math.floor(diff / 2), padstr)
end

function string:chars()
  return iter, { t = self, i = 0 }
end

function string:chomp(pat)
  return self:gsub((pat or "[\n\r]") .. "+$", "")
end

function string:endsWith(suffix)
  return self:sub(-#suffix, -1) == suffix
end

function string:includes(pat, plain)
  return self:find(pat, 1, plain) ~= nil
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
  return self:match("^%l+$") ~= nil
end

function string:isUpper()
  return self:match("^%u+$") ~= nil
end

-- this doesn't behave like Ruby in that it discards the separator
-- it's method of detecting newlines is a bit dodgy too: \n\n would count as 1 separator
function string:lines(sep, all)
  if type(sep) == "boolean" then all, sep = sep, nil end
  local lines = self:split(sep or "[\n\r]+")
  
  if all then
    return lines
  else
    return iter, { t = lines, i = 0 }
  end
end

function string:ljust(int, padstr)
  local len = #self
  
  if int > len then
    local num = padstr and math.floor((int - len) / #padstr) or int - len
    self = self .. (padstr or " ") * num
    len = #self
    if len < int then self = self .. padstr:sub(1, int - len) end
  end
  
  return self
end

function string:lstrip()
  return self:gsub("^%s+", "")
end

-- note: this doesn't behave like Ruby's String#next method
function string:next()
  if #self == 1 then
    return string.char(self:byte() + 1)
  else
    local bytes = self:bytes(true)
    for i = 1, #bytes do bytes[i] = bytes[i] + 1 end
    return string.char(unpack(bytes))
  end
end

function string:rjust(int, padstr)
  local len = #self
  
  if int > len then
    local num = padstr and math.floor((int - len) / #padstr) or int - len
    self = ((padstr or " ") * num) .. self
    len = #self
    if len < int then self = padstr:sub(1, int - len) .. self end
  end
  
  return self
end

function string:rstrip()
  return self:gsub("%s+$", "")
end

-- credits go to thelinx for most of this function
-- https://github.com/TheLinx/loveclass/blob/master/stringextensions.lua#L6
function string:split(pat, plain)
  local t = {}
  
  while true do
    local pos1, pos2 = self:find(pat, 1, plain or false)

    if not pos1 or pos1 > pos2 then
      t[#t + 1] = self
      return t
    end
    
    t[#t + 1] = self:sub(1, pos1 - 1)
    self = self:sub(pos2 + 1)
  end
end

function string:squeeze(other)
  if other then
    return self:gsub(other .. other .. "+", other)
  else
    local last, current
    local buffer = {}

    for i = 1, #self do
      current = self[i]
      
      if current ~= last then
        table.insert(buffer, current)
        last = current
      end
    end
    
    return table.concat(buffer)
  end
end

function string:startsWith(prefix)
  return self:sub(1, #prefix) == prefix
end

function string:strip()
  return self:lstrip():rstrip()
end

function string:swapcase()
  return self:gsub("%a", swapChar)
end

function string:underscore()
  return self:gsub("([A-Z]+)([A-Z][a-z])", "%1_%2"):
              gsub("([a-z%d])([A-Z])", "%1_%2"):
              gsub("[ \t]", "_"):
              lower()
end
