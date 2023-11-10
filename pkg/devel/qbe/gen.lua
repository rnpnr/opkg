cflags({
	'-std=c99', '-Wall', '-Wextra', '-Wpedantic',
	'-Wno-format-overflow', '-Wno-format-truncation', '-Wno-maybe-uninitialized',
	'-I $dir',
})

exe('qbe', [[
        abi.c alias.c cfg.c copy.c emit.c fold.c live.c load.c
        main.c mem.c parse.c rega.c simpl.c spill.c ssa.c util.c
	amd64/(targ.c sysv.c isel.c emit.c)
	arm64/(targ.c abi.c isel.c emit.c)
	rv64/(targ.c abi.c isel.c emit.c)
]])
file('bin/qbe', '755', '$outdir/qbe')

fetch('git')
