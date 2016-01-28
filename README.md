# Description

Strong is a small Lua library that adds a lot of utilities to Lua's [string library](http://www.lua.org/manual/5.1/manual.html#5.4), and also adds some operators to strings themselves. It is currently at version 1.0.4.

Strong is based largely on Ruby's [String class](http://www.ruby-doc.org/core/classes/String.html). I've also taken a few things from [thelinx](http://github.com/thelinx)'s [extensions](https://github.com/TheLinx/loveclass/blob/master/stringextensions.lua) to strings.

## The Name

As you might have guessed, the name "strong" was chosen because it's very close to "string", and because this library makes strings stronger :).

# Features/Documentation

To get an idea of, or documentation for, strong's features, take a look at the [wiki](https://github.com/BlackBulletIV/strong/wiki). Over there you can find the [function reference](https://github.com/BlackBulletIV/strong/wiki/Function-reference), and documentation for [string indexing](https://github.com/BlackBulletIV/strong/wiki/String-Indexing) and the [operators](https://github.com/BlackBulletIV/strong/wiki/Operators).

# Example

A quick example of a few of the features.

``` lua
s = "Hello world.\nBoo. This is cool.\nHey!"

for line in s:lines() do
  for _, s in pairs(line / ' ')
    print(s:capitalize())
  end
end
```

# Tests

The tests are done using [telescope](https://github.com/norman/telescope). Have a look at the [README](https://github.com/norman/telescope#readme) for that repository to see how to install telescope. Once you've done that, just run `tsc spec.lua`. Of course if you want to see the results of every test, you can run `tsc -f spec.lua`.

# Contributors

* [Robin Wellner](http://gvxdev.wordpress.com/) helped to improve performance of `insert` and also added a couple new abilities to that method.
* [kikito](http://github.com/kikito) provided a much better implementation of `squeeze`.
* [TsT](http://love2d.org/wiki/User:TsT) helped to improve and fix the `split` function and added the modulo operator.
* [Roland Yonaba](http://yonaba.github.com/) provided the solution to a problem with a couple special pattern characters.
