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
  
  test('Divide', function()
    assert_true(testContents('a,b,c,deee' / ',', 'a', 'b', 'c', 'deee'))
  end)
end)

context('Indexing', function()
  local str = 'Hello!'

  test('s[i] type indexing', function()
    assert_equal(str[1], 'H')
    assert_equal(str[4], 'l')
    assert_equal(str[-1], '!')
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
  end)
end)

context('Methods', function()
  context('bytes', function()
    local str = "hello"
    
    test('When calling with a function it should iterate', function()
      local t = {}
      str:bytes(function(b) table.insert(t, b) end)
      assert_true(testContents(t, 104, 101, 108, 108, 111))
    end)
    
    test('When not calling with a function it should return a table of bytes', function()
      assert_true(testContents(str:bytes(), 104, 101, 108, 108, 111))
    end)
  end)
  
  test('capitalize', function()
    for _, v in pairs{'hello', 'HeLlO', 'hELLO', 'HELLo'} do
      assert_equal(v:capitalize(), 'Hello')
    end
  end)
  
  test('chars', function()
    local t = {}
    local result = { 'h', 'e', 'l', 'l', 'o' }
    ("hello"):chars(function(c) table.insert(t, c) end)
    for i = 1, #result do assert_equal(t[i], result[i]) end
  end)
  
  context('chomp', function()
    test('When calling without a separater it should remove newlines', function()
    
    end)
    
    test('When calling with a separator it should remove the whatever specified', function()
    
    end)
  end)
  
  context('eachLine', function()
    test('When calling with a separator it should use it to split the string', function()
    
    end)
    
    test('When calling without a separator it should go through each line', function()
    
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
  end)
end)
