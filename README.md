# Description

Strong is a small Lua library that adds a lot of utilities to Lua's [string library](http://www.lua.org/manual/5.1/manual.html#5.4), and also adds some operators to strings themselves. It is currently at version 1.0.

Strong is based largely on Ruby's [String class](http://www.ruby-doc.org/core/classes/String.html). I've also taken a few things from [thelinx](http://github.com/thelinx)'s [extensions](https://github.com/TheLinx/loveclass/blob/master/stringextensions.lua) to strings.

## The Name

As you might have guessed, the name "strong" was chosen because it's very close to "string", and because this library makes strings stronger :).

# Features/Documentation

To get an idea of strong's features, take a look at the [wiki](https://github.com/BlackBulletIV/strong/wiki). Over there you can find the documentation for the [operators](https://github.com/BlackBulletIV/strong/wiki/Operators) and the [function reference](https://github.com/BlackBulletIV/strong/wiki/Function-reference). Be warned though, the function reference is still being written.

# Example

A quick example of a few of the features.

``` lua
s = "Hello world.\nBoo. This is cool.\nHey!"

for line in s:lines() do
  local sentences = line / '.%s*'
  
  for _, s in pairs(sentences)
    print(s:capitalize())
  end
end
```

# Tests

The tests are done using [telescope](https://github.com/norman/telescope). Have a look at the [README](https://github.com/norman/telescope#readme) for that repository to see how to install telescope. Once you've done that, just run `tsc spec.lua`. Of course if you want to see the results of every test, you can run `tsc -f spec.lua`.

# Contributors

* [Robin Wellner](http://gvxdev.wordpress.com/) helped to improve performance of `insert` and also added a couple new abilities to that method.
* [TsT](http://love2d.org/wiki/User:TsT) helped to make `split` have an option to turn on plain text.
