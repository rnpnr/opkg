cflags({'-std=c99', '-Wall', '-Wextra', '-Wpedantic', '-Wno-unused-parameter'})

exe('samu', {
	'build.c',
	'deps.c',
	'env.c',
	'graph.c',
	'htab.c',
	'log.c',
	'parse.c',
	'samu.c',
	'scan.c',
	'tool.c',
	'tree.c',
	'util.c',
})
file('bin/samu', '755', '$outdir/samu')
man({'samu.1'})

fetch('git')
