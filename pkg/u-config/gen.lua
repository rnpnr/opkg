local arch = ({
	aarch64='aarch64',
	x86_64='x86_64',
})[config.target.platform:match('[^-]*')]
if not arch then arch = 'generic' end

local freestanding_cflags = {
	'-fcf-protection=none',
	'-fno-asynchronous-unwind-tables',
	'-fno-builtin',
	'-fno-lto',
	'-fno-pie',
	'-fno-stack-protector',
}
local archcflags = {}
local archldflags = {}
archcflags['generic']  = {}
archldflags['generic'] = {}
archcflags['x86_64']   = freestanding_cflags
archldflags['x86_64']  = {'-nostdlib', '-Wl,--gc-sections'}
archcflags['aarch64']  = freestanding_cflags
archldflags['aarch64'] = {'-nostdlib', '-Wl,--gc-sections'}

local archsrcs = {}
archsrcs['generic'] = {'main_posix.c'}
archsrcs['aarch64'] = {'main_linux_aarch64.c'}
archsrcs['x86_64']  = {'main_linux_amd64.c'}

cflags(archcflags[arch])
set('ldflags', '$ldflags '..table.concat(archldflags[arch], ' '))

exe('u-config', archsrcs[arch])
file('bin/u-config', '755', '$outdir/u-config')
sym('bin/pkg-config', 'u-config')
man({'u-config.1'})

fetch('git')
