cflags({
	'-I $dir',
	'-I $srcdir/include',
	'-I $srcdir/deps/http-parser',
	'-I $srcdir/deps/xdiff',
	'-I $srcdir/src/libgit2',
	'-I $srcdir/src/util',
	'-isystem $builddir/pkg/libs/pcre/include',
	'-isystem $builddir/pkg/libs/zlib/include',
})

pkg.deps = {
	'pkg/libs/pcre/headers',
	'pkg/libs/zlib/headers',
}

lib('libdeps.a', [[deps/(
	http-parser/http_parser.c
	xdiff/(
		xdiffi.c
		xemit.c
		xhistogram.c
		xmerge.c
		xpatience.c
		xprepare.c
		xutils.c
	)
)]])

lib('libutil.a', [[
	src/util/(
		allocators/(
			failalloc.c
			stdalloc.c
		)
		alloc.c
		date.c
		errors.c
		filebuf.c
		fs_path.c
		futils.c
		hash.c
		hash/(
			builtin.c
			collisiondetect.c
			rfc6234/sha224-256.c
			sha1dc/(
				sha1.c
				ubc_check.c
			)
		)
		net.c
		pool.c
		posix.c
		pqueue.c
		rand.c
		regexp.c
		runtime.c
		sortedcache.c
		str.c
		strlist.c
		strmap.c
		thread.c
		tsort.c
		unix/(
			map.c
			process.c
			realpath.c
		)
		utf8.c
		util.c
		varint.c
		vector.c
		wildmatch.c
		zstream.c
	)
]])

lib('libgit2.a', [[
	src/libgit2/(
		annotated_commit.c
		apply.c
		attr.c
		attr_file.c
		attrcache.c
		blame.c
		blame_git.c
		blob.c
		branch.c
		buf.c
		cache.c
		checkout.c
		cherrypick.c
		clone.c
		commit.c
		commit_graph.c
		commit_list.c
		config.c
		config_cache.c
		config_file.c
		config_list.c
		config_mem.c
		config_parse.c
		config_snapshot.c
		crlf.c
		delta.c
		describe.c
		diff.c
		diff_driver.c
		diff_file.c
		diff_generate.c
		diff_parse.c
		diff_print.c
		diff_stats.c
		diff_tform.c
		diff_xdiff.c
		email.c
		fetch.c
		fetchhead.c
		filter.c
		grafts.c
		graph.c
		hashsig.c
		ident.c
		idxmap.c
		ignore.c
		index.c
		indexer.c
		iterator.c
		libgit2.c
		mailmap.c
		merge.c
		merge_driver.c
		merge_file.c
		message.c
		midx.c
		mwindow.c
		notes.c
		object.c
		object_api.c
		odb.c
		odb_loose.c
		odb_mempack.c
		odb_pack.c
		offmap.c
		oid.c
		oidarray.c
		oidmap.c
		pack-objects.c
		pack.c
		parse.c
		patch.c
		patch_generate.c
		patch_parse.c
		path.c
		pathspec.c
		proxy.c
		push.c
		reader.c
		rebase.c
		refdb.c
		refdb_fs.c
		reflog.c
		refs.c
		refspec.c
		remote.c
		repository.c
		reset.c
		revert.c
		revparse.c
		revwalk.c
		signature.c
		stash.c
		status.c
		strarray.c
		streams/(
			mbedtls.c
			openssl.c
			registry.c
			schannel.c
			socket.c
			stransport.c
			tls.c
		)
		submodule.c
		sysdir.c
		tag.c
		trace.c
		trailer.c
		transaction.c
		transport.c
		transports/(
			auth.c
			auth_ntlmclient.c
			auth_sspi.c
			credential.c
			credential_helpers.c
			git.c
			http.c
			httpclient.c
			local.c
			smart.c
			smart_pkt.c
			smart_protocol.c
			ssh.c
			ssh_exec.c
			ssh_libssh2.c
		)
		tree-cache.c
		tree.c
		worktree.c
	)
	libdeps.a
	libutil.a
	$builddir/pkg/libs/pcre/libpcre.a
	$builddir/pkg/libs/zlib/libz.a
]])

-- <cd src/include; find . -type f
pkg.hdrs = {
	copy('$outdir/include', '$srcdir/include', { 'git2.h' }),
	copy('$outdir/include/git2', '$srcdir/include/git2', {
		'annotated_commit.h',
		'apply.h',
		'attr.h',
		'blame.h',
		'blob.h',
		'branch.h',
		'buffer.h',
		'cert.h',
		'checkout.h',
		'cherrypick.h',
		'clone.h',
		'commit.h',
		'common.h',
		'config.h',
		'cred_helpers.h',
		'credential.h',
		'credential_helpers.h',
		'deprecated.h',
		'describe.h',
		'diff.h',
		'email.h',
		'errors.h',
		'experimental.h',
		'filter.h',
		'global.h',
		'graph.h',
		'ignore.h',
		'index.h',
		'indexer.h',
		'mailmap.h',
		'merge.h',
		'message.h',
		'net.h',
		'notes.h',
		'object.h',
		'odb.h',
		'odb_backend.h',
		'oid.h',
		'oidarray.h',
		'pack.h',
		'patch.h',
		'pathspec.h',
		'proxy.h',
		'rebase.h',
		'refdb.h',
		'reflog.h',
		'refs.h',
		'refspec.h',
		'remote.h',
		'repository.h',
		'reset.h',
		'revert.h',
		'revparse.h',
		'revwalk.h',
		'signature.h',
		'stash.h',
		'status.h',
		'stdint.h',
		'strarray.h',
		'submodule.h',
		'tag.h',
		'trace.h',
		'transaction.h',
		'transport.h',
		'tree.h',
		'types.h',
		'version.h',
		'worktree.h',
	}),
	copy('$outdir/include/git2/sys', '$srcdir/include/git2/sys', {
		'alloc.h',
		'commit.h',
		'commit_graph.h',
		'config.h',
		'cred.h',
		'credential.h',
		'diff.h',
		'email.h',
		'errors.h',
		'filter.h',
		'hashsig.h',
		'index.h',
		'mempack.h',
		'merge.h',
		'midx.h',
		'odb_backend.h',
		'openssl.h',
		'path.h',
		'refdb_backend.h',
		'reflog.h',
		'refs.h',
		'remote.h',
		'repository.h',
		'stream.h',
		'transport.h',
	})
}
pkg.hdrs.install = true

fetch('git')
