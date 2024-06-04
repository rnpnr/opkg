sub('libnatpmp.ninja', function()
	cflags{'-D ENABLE_STRNATPMPERR'}
	lib('libnatpmp.a', 'third-party/libnatpmp/(getgateway.c natpmp.c wingettimeofday.c)')
end)
sub('libminiupnp.ninja', function()
	cflags{
		'-D _GNU_SOURCE',
		'-I $outdir/miniupnpc',
		'-isystem $outdir/pkg/sys/openbsd/include',
	}

	build('sed', '$outdir/miniupnpc/miniupnpcstrings.h', '$srcdir/third-party/miniupnpc/miniupnpcstrings.h.in', {
		expr='-e s,OS/version,Linux, -e s,version,,',
	})

	lib('libminiupnp.a', [[
		third-party/miniupnpc/(
			connecthostport.c
			igd_desc_parse.c
			minisoap.c
			minissdpc.c
			miniupnpc.c
			miniwget.c
			minixml.c
			portlistingparse.c
			receivedata.c
			upnpcommands.c
			upnpdev.c
			upnperrors.c
			upnpreplyparse.c
		)
	]], {'$outdir/miniupnpc/miniupnpcstrings.h', 'pkg/sys/openbsd/headers'})
end)

cflags({
	'-D __TRANSMISSION__',
	'-I $dir',
	'-I $srcdir',
	'-I $srcdir/third-party',
	'-I $srcdir/third-party/libb64/include',
	'-I $srcdir/third-party/libnatpmp',
	'-isystem $builddir/pkg/libs/bearssl/include',
	'-isystem $builddir/pkg/libs/libevent/include',
	'-isystem $builddir/pkg/libs/libutp/include',
	'-isystem $builddir/pkg/libs/zlib/include',
	'-isystem $builddir/pkg/net/curl/include',
	'-isystem $builddir/pkg/sys/openbsd/include',
	'-include config.h',
})

pkg.deps = {
	'pkg/libs/bearssl/headers',
	'pkg/libs/libevent/headers',
	'pkg/libs/libutp/headers',
	'pkg/libs/zlib/headers',
	'pkg/net/curl/headers',
	'pkg/sys/openbsd/headers',
}

lib('libtransmission.a', [[
	libtransmission/(
		announcer.c
		announcer-http.c
		announcer-udp.c
		bandwidth.c
		bitfield.c
		blocklist.c
		cache.c
		clients.c
		completion.c
		ConvertUTF.c
		crypto.c
		crypto-utils.c
		crypto-utils-fallback.c
		error.c
		fdlimit.c
		file.c
		handshake.c
		history.c
		inout.c
		list.c
		log.c
		magnet.c
		makemeta.c
		metainfo.c
		natpmp.c
		net.c
		peer-io.c
		peer-mgr.c
		peer-msgs.c
		platform.c
		platform-quota.c
		port-forwarding.c
		ptrarray.c
		quark.c
		resume.c
		rpcimpl.c
		rpc-server.c
		session.c
		session-id.c
		stats.c
		torrent.c
		torrent-ctor.c
		torrent-magnet.c
		tr-assert.c
		tr-dht.c
		tr-lpd.c
		tr-udp.c
		tr-utp.c
		tr-getopt.c
		trevent.c
		upnp.c
		utils.c
		variant.c
		variant-benc.c
		variant-json.c
		verify.c
		watchdir.c
		watchdir-generic.c
		web.c
		webseed.c
		wildmat.c

		watchdir-inotify.c
		file-posix.c
		subprocess-posix.c
		crypto-utils-bearssl.c
	)
	libb64.a libdht.a libminiupnp.a libnatpmp.a
	$builddir/pkg/(
		libs/bearssl/libbearssl.a
		libs/libevent/libevent.a
		libs/libutp/libutp.a
		libs/zlib/libz.a
		net/curl/libcurl.a.d
	)
]])

lib('libb64.a', {'third-party/libb64/src/cdecode.c', 'third-party/libb64/src/cencode.c'})
lib('libdht.a', {'third-party/dht/dht.c'})

exe('transmission-daemon', {
	'daemon/daemon.c',
	'daemon/daemon-posix.c',
	'libtransmission.a.d',
})
file('bin/transmission-daemon', '755', '$outdir/transmission-daemon')
man({'daemon/transmission-daemon.1'})

for _, tool in ipairs({'create', 'edit', 'remote', 'show'}) do
	exe('transmission-'..tool, {'utils/'..tool..'.c', 'libtransmission.a.d'})
	file('bin/transmission-'..tool, '755', '$outdir/transmission-'..tool)
	man({'utils/transmission-'..tool..'.1'})
end

fetch('curl')
