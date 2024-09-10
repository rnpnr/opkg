-- TODO: i686 support?
local arch = ({
	x86_64='x86_64',
})[config.target.platform:match('[^-]*')]
if not arch then arch = 'generic' end

local archcflags = {}
local archldflags = {}
archcflags['generic']  = {}
archldflags['generic'] = {}
archcflags['x86_64']   = {'-fno-stack-protector', '-ffreestanding', '-fno-builtin'}
archldflags['x86_64']  = {'-nostartfiles'}

local archexe = {}
archexe['generic'] = function() exe('u-config', {'generic_main.c'}) end
archexe['x86_64']  = function() exe('u-config', {'linux_amd64_main.c'}) end

cflags(archcflags[arch])
set('ldflags', '$ldflags '..table.concat(archldflags[arch], ' '))

archexe[arch]()
file('bin/u-config', '755', '$outdir/u-config')
sym('bin/pkg-config', 'u-config')
man({'u-config.1'})

fetch('git')
