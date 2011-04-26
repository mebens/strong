# Description

Strong is a small Lua library that adds a lot of utilities to Lua's [string library](http://www.lua.org/manual/5.1/manual.html#5.4), and also adds some operators to strings themselves.

Strong is based largely on Ruby's [String class][rb-string]. I've also taken a few things from [thelinx](http://github.com/thelinx)'s [extensions](https://github.com/TheLinx/loveclass/blob/master/stringextensions.lua) to strings.

**Warning**: Some features don't work at all, and many aren't tested yet. This is up here at the moment for people to take a look at and contribute.

## The Name

As you might have guessed, the name "strong" was chosen because it's very close to "string", and because this library makes strings stronger :).

# Features

I'm yet to write out a feature list or documentation. However, strong adds many of the methods from the Ruby [String class][rb-string]. It also adds the operators:

* +: `a + b == a .. b`
* -: `a - b == a:gsub(b, '')`. Example: `"Hello" - 'l' == 'Heo'`.
* *: `a * b == a:rep(b)`. Example: `'a' * 3 == 'aaa'`.
* /: `a / b == a:split(b)`. See the `split` method.

# Tests

The tests are done using [telescope](https://github.com/norman/telescope). Have a look at the [README](https://github.com/norman/telescope#readme) for that repository to see how to install telescope. Once you've done that, just run `tsc spec.lua`.

[rb-string]: http://www.ruby-doc.org/core/classes/String.html

# Contributors

* [Robin Wellner](http://gvxdev.wordpress.com/) helped to improve performance of `insert` and also added a couple new abilities to that method.
