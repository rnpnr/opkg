set('srcdir', '$dir')

file('libexec/applyperms', '755', exe('applyperms', {'applyperms.c'}))
file('libexec/mergeperms', '755', exe('mergeperms', {'mergeperms.c'}))
