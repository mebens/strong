-- METATABLE --
local mt = getmetatable("")

-- OPERATORS --

function mt.__add(a, b) return a .. b end
function mt.__sub(a, b) return a:gsub(b, "") end
function mt.__mul(a, b) return a:rep(b) end
function mt.__div(a, b) return a:split(b) end

-- INDEXING --

function mt:__index(key)
  if type(key) == 'number' then
    return self:sub(key, key)
  else
    return string[key]
  end
end

-- this doesn't work, strings are immutable
--[[function mt:__newindex(key, value)
  if type(key) == 'number' then
    self:gsub('(' .. '.' * (key - 1) .. ')' .. '(.)', '%1' .. (value or ''))
  else
    rawset(self, key, value) -- whatever error this gives...
  end
end]]

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
  return string:gsub((sep or "(\n|\r|\r\n)") .. '$', '')
end

function string:eachLine(...)
  local sep = "(\n|\r|\r\n)"
  local func
  
  if select('#', ...) == 2 then
    sep, func = ...
  else
    func = select(1, ...)
  end
  
  local lines = self:split(sep)
  
  if func then
    for _, v in ipairs(lines) do
      func(v)
    end
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

-- FIXME: This doesn't handle negative indicies by looks of it
function string:insert(index, other)
  -- if index is 1, there will be no captures in the first part
  -- Lua seems to insert just a plain 1 into the string in this case
  
  if index > 1 then
    return self:gsub('^(' .. ('.' * (index - 1)) .. ')(.)', '%1' .. other .. '%2')
  else
    return self:gsub('^(.)', other .. '%1')
  end
end

function string:ljust(int, padstr)
  local len = self:len()
  if int > len then self = self .. (padstr or ' ') * (int - len) end
  return self
end

function string:lstrip()
  return self:gsub('^[\r\n\t ]+', '')
end

-- TODO: next

function string:rjust(int, padstr)
  local len = self:len()
  if int > len then self = ((padstr or ' ') * (int - len)) .. self end
  return self
end

function string:rstrip()
  return self:gsub('[\r\n\t ]+$', '')
end

-- credits go to thelinx: https://github.com/TheLinx/loveclass/blob/master/stringextensions.lua#L6
function string:split(pat)
  local t = {}
  
  while true do
    local pos1, pos2 = self:find(pat)

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
    return self:gsub(other .. '{2,}', other)
  else
    return self:gsub('(.){2,}', '%1')
  end
end

function string:startsWith(prefix)
  return self:sub(1, prefix:len()) == prefix
end

function string:strip()
  return self:lstrip():rstrip()
end

-- TODO: swapcase
