cflags({
	'-std=c99', '-Wall', '-Wpedantic',
	'-D _XOPEN_SOURCE=700',
	'-isystem $builddir/pkg/libs/libgit2/include',
})

pkg.deps = {'pkg/libs/libgit2/headers'}

lib('libcompat.a', {'strlcat.c', 'strlcpy.c', 'reallocarray.c'})

for _, tool in ipairs({'stagit', 'stagit-index'}) do
	exe(tool, {tool..'.c', 'libcompat.a', '$builddir/pkg/libs/libgit2/libgit2.a.d'})
	file('bin/'..tool, '755', '$outdir/'..tool)
	man({tool..'.1'})
end

local examples = {
	'example_create.sh',
	'example_post-receive.sh',
	'favicon.png',
	'logo.png',
	'style.css'
}

for _, ex in ipairs(examples) do
	file('share/stagit/'..ex, '644', '$srcdir/'..ex)
end

fetch('git')
