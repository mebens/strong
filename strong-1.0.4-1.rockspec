package = 'strong'
version = '1.0.4-1'

source = {
  url = 'git://github.com/BlackBulletIV/strong',
  tag = '1.0.4',
}

description = {
  summary  = 'A Lua library that makes your strings stronger!',
  detailed = [[Strong is a small Lua library that adds a lot of utilities to Lua's string library, and also adds some operators to strings themselves.]],
  homepage = 'https://github.com/BlackBulletIV/strong',
  license  = "zlib/libpng",
}

dependencies = {
  'lua >= 5.1'
}

build = {
  type = 'builtin',
  modules = {
    strong = 'strong.lua'
  },
}
