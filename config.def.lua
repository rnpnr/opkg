local sets = dofile(basedir..'/sets.lua')

-- configuration table
local C = {}

-- build output directory
C.builddir = 'out'

-- install prefix (needed by some packages)
C.prefix = ''

--[[
package/file selection

Each entry contains a list of packages, a list of patterns to
include, and a list of patterns to exclude. If no patterns
are specified, all files from the package are included.

You may also specify a list of patterns to include or exclude
for any packages not matching any entries. If no patterns are
specified, all files from the package are excluded.
include={...}, exclude={...},
--]]
C.fs = {
	{ sets.bin, exclude = {'^include/', '^lib/.*%.a$'} },
	{ sets.lib },
}

-- target toolchain and flags
C.target = {
	platform='x86_64-gentoo-linux-musl',
	cflags='-Os -fPIE -pipe',
	ldflags='-s -static-pie',
}

-- host toolchain and flags
C.host = { cflags = '-O2 -pipe', ldflags = '', }

-- output git repository
C.repo = {
	path='$builddir/root.git',
	flags='--bare',
	tag='tree',
	branch='master',
}

-- GPU driver (possible_values: amdgpu intel nouveau)
-- C.video_drivers={intel=true}

return C
