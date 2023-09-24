cflags({
	'-std=c99', '-Wall',
	'-isystem $builddir/pkg/libs/netbsd-curses/include',
})

pkg.hdrs = copy('$outdir/include', '$srcdir', {'termkey.h'})
pkg.deps = {'pkg/libs/netbsd-curses/headers'}

lib('libtermkey.a', {
	'termkey.c',
	'driver-csi.c',
	'driver-ti.c',
	'$builddir/pkg/libs/netbsd-curses/libcurses.a.d',
})

fetch('curl')
