cflags({
	'-std=c99',
	'-D NDEBUG',
	'-isystem $builddir/pkg/lang/lua/include',
})

pkg.deps = {'pkg/lang/lua/headers'}

lib('liblpeg.a', {
	'lpvm.c',
	'lpcap.c',
	'lptree.c',
	'lpcode.c',
	'lpprint.c',
	'lpcset.c',
})

fetch('curl')
