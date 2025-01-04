set('version', 'v0.9-dirty')
cflags({
	'-std=c99',
	'-D VIS_EXPORT=static',
	'-D CONFIG_HELP=1',
	'-D CONFIG_CURSES=0',
	'-D CONFIG_LUA=1',
	'-D CONFIG_LPEG=1',
	[[-D 'VERSION="$version"']],
	string.format([[-D 'VIS_PATH="%s/share/vis"']], config.prefix),
	'-I $outdir',
	'-I $srcdir/termkey',
	'-isystem $builddir/pkg/lua/include',
	'-isystem $builddir/pkg/netbsd-curses/include',
	'-Wno-initializer-overrides',
})

build('copy', '$outdir/config.h', '$srcdir/config.def.h')

pkg.deps = {
	'$outdir/config.h',
	'pkg/lua/headers',
}

exe('vis', [[
	main.c
	$builddir/pkg/lua/liblua.a
	$builddir/pkg/lpeg/liblpeg.a
	$builddir/pkg/netbsd-curses/libcurses.a.d
]])

exe('vis-digraph', {'vis-digraph.c'})
exe('vis-menu', {'vis-menu.c'})

for _, b in ipairs({'vis', 'vis-digraph', 'vis-menu'}) do
	file('bin/'..b, '755', '$outdir/'..b)
	build('sed', '$outdir/'..b..'.1', '$srcdir/man/'..b..'.1', {expr='s,VERSION,$version,'})
	man({'$outdir/'..b.. '.1'})
end

for _, s in ipairs({'vis-complete', 'vis-clipboard', 'vis-open'}) do
	file('bin/'..s, '755', '$srcdir/'..s)
	build('sed', '$outdir/'..s..'.1', '$srcdir/man/'..s..'.1', {expr='s,VERSION,$version,'})
	man({'$outdir/'..s.. '.1'})
end

for f in iterlines('lua.txt') do
	file('share/vis/'..f, '644', '$srcdir/lua/'..f)
end
sym('share/vis/lexer.lua', 'lexers/lexer.lua')
sym('share/vis/themes/default.lua', 'base-16.lua')

--fetch('git')
