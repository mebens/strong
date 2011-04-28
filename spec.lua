require('strong')

function testContents(t, ...)
  local args = {...}
  
  for i = 1, #args do
    if t[i] ~= args[i] then
      return false
    end
  end
  
  return true
end

context('String operators', function()
  test('Add', function()
    assert_equal('Foo' + 'Bar', 'FooBar')
  end)
  
  context('Subtract', function()
    test('It should remove instances of one or more characters', function()
      assert_equal('Hello World ... Blah' - ' ', 'HelloWorld...Blah')
      assert_equal('Hello World' - 'lo', 'Hel World')
    end)
    
    test('It should accept patterns', function()
      assert_equal('123 Hello' - '[%d%s]', 'Hello')
    end)
  end)
  
  test('Multiply', function()
    assert_equal('a' * 8, 'aaaaaaaa')
  end)
  
  context('Divide', function()
    test('It should act like split', function()
      local str = 'a,b,c,deee'
      assert_true(testContents(str / ',', unpack(str:split(','))))
    end)
    
    test('It should default to plain text splitting', function()
      assert_true(testContents('a.b.c' / '.', 'a', 'b', 'c'))
    end)
  end)
end)

context('Indexing', function()
  local str = 'Hello!'

  context('s[i] type indexing', function()
    test("It should be able to index positive and negative indicies", function()
      assert_equal(str[1], 'H')
      assert_equal(str[4], 'l')
      assert_equal(str[-1], '!')
    end)
    
    test("It should return nil for out of range indicies", function()
      assert_nil(str[0])
      assert_nil(str[10])
    end)
  end)
  
  context('s(i, j) type indexing', function()
    test('It should be able to index a single character', function()
      assert_equal(str(1), 'H')
      assert_equal(str(-1), '!')
    end)
    
    test('It should be able to index a range', function()
      assert_equal(str(1, 4), 'Hell')
      assert_equal(str(-3, -1), 'lo!')
    end)
    
    test('It should be able to index a sub-string', function()
      assert_equal(str('ll'), 'll')
      assert_nil(str('foo'))
    end)
    
    test("It should return nil for out of range indicies", function()
      assert_nil(str(0))
      assert_nil(str(10))
      assert_nil(str(10, -2))
    end)
  end)
end)

context('Methods', function()
  context('bytes', function()
    local str = "hello"
    
    test('When calling normally it should provide an iterator', function()
      local t = {}
      for b in str:bytes() do table.insert(t, b) end
      assert_true(testContents(t, 104, 101, 108, 108, 111))
    end)
    
    test('When not calling with first parameter as true, it should provide a table of all bytes', function()
      assert_true(testContents(str:bytes(true), 104, 101, 108, 108, 111))
    end)
  end)
  
  test('capitalize', function()
    for _, v in pairs{'hello', 'HeLlO', 'hELLO', 'HELLo'} do
      assert_equal(v:capitalize(), 'Hello')
    end
  end)
  
  test('chars', function()
    local t = {}
    for c in ("hello"):chars() do table.insert(t, c) end
    assert_true(testContents(t, 'h', 'e', 'l', 'l', 'o'))
  end)
  
  context('chomp', function()
    test('When calling without a separator it should remove newlines', function()
      assert_equal(("hello\n\n"):chomp(), 'hello')
      assert_equal(("hello\r\n\r"):chomp(), 'hello')
    end)
    
    test('When calling with a separator it should remove the whatever specified', function()
      assert_equal(("hello...."):chomp('%.'), 'hello')
    end)
    
    test("It shouldn't remove the separator anywhere else than the end", function()
      assert_equal(("\n\nhello\n"):chomp(), '\n\nhello')
      assert_equal(("..hello.."):chomp('%.'), '..hello')
    end)
  end)
  
  context('lines', function()
    test('When calling with a separator it should use it to split the string', function()
      local t = {}
      
      for line in ("foo|bar|ha"):lines('|') do
        table.insert(t, line)
      end
      
      assert_true(testContents(t, 'foo', 'bar', 'ha'))
    end)
    
    test('When calling without a separator it should go through each line', function()
      local t = {}
      
      for line in ("foo\nbar\r\nha"):lines() do
        table.insert(t, line)
      end
      
      assert_true(testContents(t, 'foo', 'bar', 'ha'))
    end)
  end)
  
  test('endsWith', function()
    assert_true(("foobar!"):endsWith("ar!"))
    assert_false(("foobar!"):endsWith("Please return false"))
  end)
  
  test('includes', function()
    assert_true(("foobar!"):includes("oba"))
    assert_false(("foobar!"):includes("nada"))
  end)
  
  context('insert', function()
    test('Greater than zero indicies', function()
      assert_equal(("world"):insert(1, "hello "), "hello world")
      assert_equal(("far!"):insert(2, "oob"), "foobar!")
    end)
    
    test('Zero indicies should just concatenate', function()
      assert_equal(("hello"):insert(0, " world"), "hello world")
    end)
    
    test('Negative indicies', function()
      assert_equal(("hello"):insert(-1, "ooo"), "helloooo")
      assert_equal(("hello"):insert(-3, "ll"), "hellllo")
    end)
  end)
  
  context("isLower", function()
    test("Should return true for lower case letters", function()
      assert_true(("a"):isLower())
    end)
    
    test("Should return false for numbers and anything else", function()
      assert_false(("1"):isLower())
      assert_false(("!"):isLower())
    end)
    
    test("Should return false for upper case letters", function()
      assert_false(("A"):isLower())
    end)
    
    test("Should handle multi-character strings", function()
      assert_true(("aaaabb"):isLower())
      assert_false(("AAbb"):isLower())
      assert_false(("!$@#$A"):isLower())
    end)
    
    test("Should return false for empty strings", function()
      assert_false((""):isUpper())
    end)
  end)
  
  context("isUpper", function()
    test("Should return false for lower case letters", function()
      assert_false(("a"):isUpper())
    end)
    
    test("Should return false for numbers and anything else", function()
      assert_false(("1"):isUpper())
      assert_false(("!"):isUpper())
    end)
    
    test("Should return true for upper case letters", function()
      assert_true(("A"):isUpper())
    end)
    
    test("Should handle multi-character strings", function()
      assert_true(("AAAAAB"):isUpper())
      assert_false(("AAbb"):isUpper())
      assert_false(("!$@#$A"):isUpper())
    end)
    
    test("Should return false for empty strings", function()
      assert_false((""):isUpper())
    end)
  end)
  
  context('ljust', function()
    local str = "hello"
    
    test('When the length provided is less than or equal to the length of the string, ' ..
         'it should return the string itself', function()
      assert_equal(str:ljust(#str - 1), str)
      assert_equal(str:ljust(#str), str)
    end)
    
    test('When the length provided is greater than the length of the string, it should pad it properly', function()
      local justified = str:ljust(#str + 10)
      assert_equal(justified, str .. (' ' * 10))
      assert_equal(#justified, #str + 10)
    end)
    
    test('It should pad with the string provided (if one is provided)', function()
      assert_equal(str:ljust(#str + 2, '!'), str .. '!!')
    end)
    
    test('It should be the correct length when the padding string is more than one character', function()
      local justified = str:ljust(#str + 10, '!!!')
      assert_equal(justified, str .. ('!' * 10))
      assert_equal(#justified, #str + 10)
    end)
  end)
  
  context('lstrip', function()
    test('It should strip spaces and tabs', function()
      assert_equal(('  \t hello'):lstrip(), 'hello')
    end)
    
    test('It should strip newlines', function()
      assert_equal(('\n\nhey'):lstrip(), 'hey')
      assert_equal(('\r\nhey'):lstrip(), 'hey')
    end)
    
    test('It should not strip to the right or the middle', function()
      assert_equal(('  hello world  '):lstrip(), 'hello world  ')
    end)
  end)
  
  context('next', function()
    test('When dealing with a single character, it should advance it', function()
      assert_equal(('a'):next(), 'b')
      assert_equal(('F'):next(), 'G')
    end)
    
    test('When dealing with multiple characters, it should advance them all', function()
      assert_equal(('aaa'):next(), 'bbb')
      assert_equal(('aBc'):next(), 'bCd')
    end)
  end)
  
  context('rjust', function()
    local str = "hello"
    
    test('When the length provided is less than or equal to the length of the string, ' ..
         'it should return the string itself', function()
      assert_equal(str:rjust(#str - 1), str)
      assert_equal(str:rjust(#str), str)
    end)
    
    test('When the length provided is greater than the length of the string, it should pad it properly', function()
      local justified = str:rjust(#str + 10)
      assert_equal(justified, (' ' * 10) .. str)
      assert_equal(#justified, #str + 10)
    end)
    
    test('It should pad with the string provided (if one is provided)', function()
      assert_equal(str:rjust(#str + 2, '!'), '!!' .. str)
    end)
    
    test('It should be the correct length when the padding string is more than one character', function()
      local justified = str:rjust(#str + 10, '!!!')
      assert_equal(justified, ('!' * 10) .. str)
      assert_equal(#justified, #str + 10)
    end)
  end)
  
  context('rstrip', function()
    test('It should strip spaces and tabs', function()
      assert_equal(('hello   \t  '):rstrip(), 'hello')
    end)
    
    test('It should strip newlines', function()
      assert_equal(('hey\n\n'):rstrip(), 'hey')
      assert_equal(('hey\r\n'):rstrip(), 'hey')
    end)
    
    test('It should not strip to the left or the middle', function()
      assert_equal(('  hello world  '):rstrip(), '  hello world')
    end)
  end)
  
  context('split', function()
    test('It should split a string up properly', function()
      assert_true(testContents(('hello!world!foo!bar'):split('!'), 'hello', 'world', 'foo', 'bar'))
    end)
    
    test('It should accept patterns by default', function()
      assert_true(testContents(('hello1world2foo'):split('%d'), 'hello', 'world', 'foo'))
    end)
    
    test('It should accept an option to turn off patterns', function()
      assert_true(testContents(('com.nowhere.nada'):split('.', true), 'com', 'nowhere', 'nada'))
    end)
  end)
  
  context('squeeze', function()
    test('When a string is not specified, remove all duplicates', function()
      assert_equal(('helloo'):squeeze(), 'helo')
      assert_equal(('boo!!!'):squeeze(), 'bo!')
    end)
    
    test('When a string is specified, remove duplicates of it', function()
      assert_equal(('helloo'):squeeze('o'), 'hello')
      assert_equal(('boo!!!'):squeeze('!'), 'boo!')
    end)
  end)
  
  test('startsWith', function()
    assert_true(('001 hello world'):startsWith('001 '))
    assert_false(('blah'):startsWith('foo'))
  end)
  
  test('strip', function()
    local str = ' \t\n  hello world  '
    assert_equal(str:strip(), str:lstrip():rstrip())
  end)
  
  test("swapcase", function()
    assert_equal(("HeLLoO"):swapcase(), "hEllOo")
    assert_equal(("goo"):swapcase(), "GOO")
    assert_equal(("GOO"):swapcase(), "goo")
  end)
end)
