cflags({
	'-std=c99', '-Wall', '-Wextra', '-Wpedantic', '-Wno-implicit-fallthrough',
	'-D _DEFAULT_SOURCE',
	'-D LUA_USE_POSIX',
})

pkg.hdrs = {
	copy('$outdir/include', '$srcdir/src', {'lua.h', 'luaconf.h', 'lualib.h', 'lauxlib.h'}),
	install=true,
}

lib('liblua.a', [[src/(
	lapi.c lcode.c lctype.c ldebug.c ldo.c ldump.c lfunc.c lgc.c llex.c
	lmem.c lobject.c lopcodes.c lparser.c lstate.c lstring.c ltable.c
	ltm.c lundump.c lvm.c lzio.c
	lauxlib.c lbaselib.c lbitlib.c lcorolib.c ldblib.c liolib.c
	lmathlib.c loslib.c lstrlib.c ltablib.c loadlib.c linit.c
)]])
file('lib/liblua.a', '644', '$outdir/liblua.a')

exe('lua', {'src/lua.c', 'liblua.a'})
file('bin/lua5.2', '755', '$outdir/lua')
sym('bin/lua', 'lua5.2')
exe('luac', {'src/luac.c', 'liblua.a'})
file('bin/luac5.2', '755', '$outdir/luac')
sym('bin/luac', 'luac5.2')

man({'doc/lua.1', 'doc/luac.1'})

fetch('curl')
