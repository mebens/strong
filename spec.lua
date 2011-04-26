require('strong')

function testSplit(t, ...)
  local args = {...}
  
  for i = 1, #args do
    print(i, t[i], args[i])
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
    assert_true(testSplit('a,b,c,deee' / ',', 'a', 'b', 'c', 'deee'))
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
end)