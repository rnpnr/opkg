cflags({
	'-std=c99', '-Wall', '-Wextra',
	'-D _POSIX_C_SOURCE',
	'-isystem $builddir/pkg/libs/libpng/include',
	'-I $srcdir/src/cexcept',
	'-I $srcdir/src/gifread',
	'-I $srcdir/src/minitiff',
	'-I $srcdir/src/opngreduc',
	'-I $srcdir/src/pngxtern',
	'-I $srcdir/src/pnmio',
})

pkg.deps = {'pkg/libs/libpng/headers'}

lib('libdeps.a', [[src/(
	opngreduc/opngreduc.c
	gifread/gifread.c
	pngxtern/(
		pngxread.c pngxrbmp.c pngxrgif.c pngxrjpg.c pngxrpnm.c
		pngxrtif.c
		pngxio.c pngxmem.c pngxset.c
	)
	pnmio/(pnmin.c pnmout.c pnmutil.c)
	minitiff/(tiffread.c tiffutil.c)
)]])

exe('optipng', [[
	src/optipng/(
		optipng.c
		optim.c
		bitset.c
		ioutil.c
		ratio.c
		wildargs.c
	)
	libdeps.a
	$builddir/pkg/libs/libpng/libpng.a.d
]])
file('bin/optipng', '755', '$outdir/optipng')
man({'$srcdir/src/optipng/man/optipng.1'})

fetch('curl')
