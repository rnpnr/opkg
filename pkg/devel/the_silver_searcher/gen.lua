cflags{
	'-D _GNU_SOURCE',
	'-I $dir',
	'-isystem $builddir/pkg/libs/pcre/include',
	'-isystem $builddir/pkg/libs/zlib/include',
}

pkg.deps = {
	'pkg/libs/pcre/headers',
	'pkg/libs/zlib/headers',
}

exe('ag', [[
	src/(
	        ignore.c log.c options.c print.c print_w32.c scandir.c search.c lang.c
	        util.c decompress.c main.c
	)
	$builddir/pkg/libs/pcre/libpcre.a
	$builddir/pkg/libs/zlib/libz.a
]])
file('bin/ag', '755', '$outdir/ag')
man({'doc/ag.1'})

fetch('git')
