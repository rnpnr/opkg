-- TODO: i686 support?
local arch = ({
	x86_64='x86_64',
})[config.target.platform:match('[^-]*')]
if not arch then arch = 'generic' end

local archcflags = {}
local archldflags = {}
archcflags['generic']  = {}
archldflags['generic'] = {}
archcflags['x86_64']   = {'-fno-asynchronous-unwind-tables', '-fno-stack-protector', '-fno-builtin'}
archldflags['x86_64']  = {'-nostdlib', '-Wl,--gc-sections'}

local archsrcs = {}
archsrcs['generic'] = {'generic_main.c'}
archsrcs['x86_64']  = {'linux_amd64_main.c'}

cflags(archcflags[arch])
set('ldflags', '$ldflags '..table.concat(archldflags[arch], ' '))

exe('u-config', archsrcs[arch])
file('bin/u-config', '755', '$outdir/u-config')
sym('bin/pkg-config', 'u-config')
man({'u-config.1'})

fetch('git')
