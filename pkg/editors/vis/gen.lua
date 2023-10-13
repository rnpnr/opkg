set('version', 'cbaa0d8')
cflags({
	'-std=c99',
	'-D CONFIG_HELP=1',
	'-D CONFIG_CURSES=0',
	'-D CONFIG_LUA=1',
	'-D CONFIG_LPEG=1',
	'-D CONFIG_TRE=0',
	'-D CONFIG_ACL=0',
	'-D CONFIG_SELINUX=0',
	'-D HAVE_MEMRCHR=1',
	'-D LUA_COMPAT_5_3',
	'-D _XOPEN_SOURCE=700',
	[[-D 'VERSION="$version"']],
	string.format([[-D 'VIS_PATH="%s/share/vis"']], config.prefix),
	'-D NDEBUG',
	'-I $outdir',
	'-isystem $builddir/pkg/lang/lua/include',
	'-isystem $builddir/pkg/libs/libtermkey/include',
})

build('copy', '$outdir/config.h', '$srcdir/config.def.h')

pkg.deps = {
	'$outdir/config.h',
	'pkg/lang/lua/headers',
	'pkg/libs/libtermkey/headers',
}

exe('vis', [[
	array.c
	buffer.c
	libutf.c
	main.c
	map.c
	sam.c
	text.c
	text-common.c
	text-io.c
	text-iterator.c
	text-motions.c
	text-objects.c
	text-util.c
	ui-terminal.c
	view.c
	vis.c
	vis-lua.c
	vis-marks.c
	vis-modes.c
	vis-motions.c
	vis-operators.c
	vis-prompt.c
	vis-registers.c
	vis-subprocess.c
	vis-text-objects.c
	text-regex.c
	$builddir/pkg/lang/lua/liblua.a
	$builddir/pkg/libs/libtermkey/libtermkey.a.d
	$builddir/pkg/libs/lpeg/liblpeg.a
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
sym('share/vis/themes/default-16.lua', 'dark-16.lua')
sym('share/vis/themes/default-256.lua', 'dark-16.lua')

fetch('git')
