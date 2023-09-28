cflags({
	'-I $dir',
	'-isystem $basedir/pkg/sys/openbsd/include',
	'-isystem $builddir/pkg/libs/zlib/include',
})

lib('libmandoc.a', {
	'man.c',
	'man_macro.c',
	'man_validate.c',

	'arch.c',
	'att.c',
	'lib.c',
	'mdoc.c',
	'mdoc_argv.c',
	'mdoc_macro.c',
	'mdoc_state.c',
	'mdoc_validate.c',
	'st.c',

	'eqn.c',
	'roff.c',
	'roff_validate.c',
	'tbl.c',
	'tbl_data.c',
	'tbl_layout.c',
	'tbl_opts.c',

	'chars.c',
	'mandoc.c',
	'mandoc_aux.c',
	'mandoc_msg.c',
	'mandoc_ohash.c',
	'mandoc_xr.c',
	'msec.c',
	'preconv.c',
	'read.c',
	'tag.c',

	'compat_fts.c',
	'compat_ohash.c',
}, {'pkg/libs/zlib/headers'})

exe('mandoc', {
	'main.c',
	'manpath.c',
	'mdoc_man.c',
	'mdoc_markdown.c',
	'out.c',
	'tree.c',

	'eqn_html.c',
	'html.c',
	'man_html.c',
	'mdoc_html.c',
	'roff_html.c',
	'tbl_html.c',

	'eqn_term.c',
	'man_term.c',
	'mdoc_term.c',
	'roff_term.c',
	'term.c',
	'term_ascii.c',
	'term_ps.c',
	'term_tab.c',
	'term_tag.c',
	'tbl_term.c',

	'dbm.c',
	'dbm_map.c',
	'mansearch.c',

	'dba.c',
	'dba_array.c',
	'dba_read.c',
	'dba_write.c',
	'mandocdb.c',

	'libmandoc.a',
	'$builddir/pkg/sys/openbsd/libbsd.a',
	'$builddir/pkg/libs/zlib/libz.a',
})
file('bin/mandoc', '755', '$outdir/mandoc')
for _, cmd in ipairs{'apropos', 'man', 'whatis', 'makewhatis'} do
	sym('bin/'..cmd, 'mandoc')
end

exe('demandoc', {
	'demandoc.c',
	'libmandoc.a',
	'$builddir/pkg/sys/openbsd/libbsd.a',
	'$builddir/pkg/libs/zlib/libz.a',
})
file('bin/demandoc', '755', '$outdir/demandoc')

man({
	'mandoc.1',
	'demandoc.1',
	'man.1',
	'apropos.1',

	'man.conf.5',
	'mandoc.db.5',

	'man.7',
	'mdoc.7',
	'roff.7',
	'eqn.7',
	'tbl.7',
	'mandoc_char.7',

	'makewhatis.8',
})
sym('share/man/man1/whatis.1', 'apropos.1')

fetch('curl')
