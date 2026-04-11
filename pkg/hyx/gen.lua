cflags({'-std=c99 -pedantic -Wall -Wextra -DNDEBUG'})

exe('hyx', {
	'blob.c',
	'common.c',
	'history.c',
	'hyx.c',
	'input.c',
	'term.c',
	'view.c',
})

file('bin/hyx', '755', '$outdir/hyx')

fetch('curl')
