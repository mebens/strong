# Description

Strong is a small Lua library that adds a lot of utilities to Lua's [string library](http://www.lua.org/manual/5.1/manual.html#5.4), and also adds some operators to strings themselves.

Strong is based largely on Ruby's [String class][rb-string]. I've also taken a few things from [thelinx](http://github.com/thelinx)'s [extensions](https://github.com/TheLinx/loveclass/blob/master/stringextensions.lua) to strings.

**Warning**: This library is still under early development. See the the Bug/Problems section for more details.

## The Name

As you might have guessed, the name "strong" was chosen because it's very close to "string", and because this library makes strings stronger :).

# Features

I'm yet to write out a feature list or documentation. However, strong adds many of the methods from the Ruby [String class][rb-string]. It also adds the operators:

* +: `a + b == a .. b`
* -: `a - b == a:gsub(b, '')`. Example: `"Hello" - 'l' == 'Heo'`.
* *: `a * b == a:rep(b)`. Example: `'a' * 3 == 'aaa'`.
* /: `a / b == a:split(b, true)`. See the `split` method.

# Bugs/Problems

All methods have tests for them at current. Only one thing is known to be non-working, and that is [this test](https://github.com/BlackBulletIV/strong/blob/master/spec.lua#L267) for the `squeeze` method. The only way I can think of fixing it is using a very inefficient approach of checking every character in the string, which doesn't sound good. If anyone's got suggestions I'd love to hear them.

# Tests

The tests are done using [telescope](https://github.com/norman/telescope). Have a look at the [README](https://github.com/norman/telescope#readme) for that repository to see how to install telescope. Once you've done that, just run `tsc spec.lua`. Of course if you want to see the results of every test, you can run `tsc -f spec.lua`.

# Contributors

* [Robin Wellner](http://gvxdev.wordpress.com/) helped to improve performance of `insert` and also added a couple new abilities to that method.
* [TsT](http://love2d.org/wiki/User:TsT) helped to make `split` have an option to turn on plain text.

[rb-string]: http://www.ruby-doc.org/core/classes/String.html
