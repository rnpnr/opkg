cflags({
	'-std=c99', '-Wall', '-Wextra',
	'-D _POSIX_C_SOURCE',
	'-isystem $builddir/pkg/libpng/include',
	'-isystem $builddir/pkg/zlib/include',
	'-I $srcdir/src/opngreduc',
	'-I $srcdir/src/pngxtern',
	'-I $srcdir/third_party/cexcept',
	'-I $srcdir/third_party/gifread',
	'-I $srcdir/third_party/minitiff',
	'-I $srcdir/third_party/pnmio',
})

pkg.deps = {'pkg/libpng/headers', 'pkg/zlib/headers'}

lib('libdeps.a', [[
	src/(
		opngreduc/opngreduc.c
		pngxtern/(
			pngxread.c pngxrbmp.c pngxrgif.c pngxrjpg.c pngxrpnm.c
			pngxrtif.c
			pngxio.c pngxmem.c pngxset.c
		)
	)
	third_party/(
		gifread/gifread.c
		pnmio/(pnmin.c pnmout.c pnmutil.c)
		minitiff/(tiffread.c tiffutil.c)
		wildargs/wildargs.c
	)
]])

exe('optipng', [[
	src/optipng/(
		optipng.c
		optim.c
		bitset.c
		ioutil.c
		ratio.c
	)
	libdeps.a
	$builddir/pkg/libpng/libpng.a.d
]])
file('bin/optipng', '755', '$outdir/optipng')
man({'$srcdir/src/optipng/man/optipng.1'})

fetch('curl')
