opkg
====

This repo is adapted from [oasis][] but rather than installing as
an OS it is meant to be installed alongside your existing system.

The majority of things are unchanged. Most notably:

* All packages are *statically linked!*

Changes
-------
* Packages have been moved to sorted directories.
* The set of packages is curated to my personal preferences.
* OpenBSD `xargs` instead of sbase for parallel processing support.
* cmark was replaced with [md4c][].

Additional Packages
-------------------
* [hyx][]      - tiny hex editor
* [libgit2][]  - no network support; needed for stagit.
* [optipng][]  - PNG image optimizer
* [spm][]      - simpler pass
* [stagit][]   - static webpage generator for git repos.
* [u-config][] - tiny pkg-config clone that doesn't require libc on amd64.

[hyx]: https://yx7.cc/code/
[libgit2]: https://github.com/libgit2/libgit2
[md4c]: https://github.com/mity/md4c
[oasis]: https://github.com/oasislinux/oasis
[optipng]: https://optipng.sourceforge.net/
[spm]: https://github.com/rnpnr/spm
[stagit]: https://git.codemadness.org/stagit/file/README.html
[u-config]: https://github.com/skeeto/u-config/
