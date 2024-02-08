cflags({
	'-I $dir',
	'-I $srcdir/src',
	'-D MD4C_USE_UTF8',
	'-D MD_VERSION_MAJOR=0',
	'-D MD_VERSION_MINOR=5',
	'-D MD_VERSION_RELEASE=2',
})

pkg.hdrs = {
	copy('$outdir/include', '$srcdir/src', {'md4c.h', 'md4c-html.h'}),
	install=true,
}

lib('libmd4c.a', {'src/md4c.c'})
file('lib/libmd4c.a', '644', '$outdir/libmd4c.a')

lib('libmd4c-html.a', expand({'src/', {'md4c-html.c', 'entity.c'}}))
file('lib/libmd4c-html.a', '644', '$outdir/libmd4c-html.a')

exe('md2html-bin', [[
	md2html/(cmdline.c md2html.c)
	libmd4c-html.a.d
	libmd4c.a.d
]])
file('bin/md2html', '755', '$outdir/md2html-bin')
man({'md2html/md2html.1'})

fetch('git')
