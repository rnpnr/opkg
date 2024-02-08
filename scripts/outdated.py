import collections
import json
import os
import subprocess
import sys
import urllib.request


def check_sub_tree(path):
    names = {
        "awk": "nawk",
        "lpeg": "lua:lpeg",
        "samurai": "samurai-build-tool",
        "sshfs": "fusefs:sshfs",
        "st": "st-term",
        "terminus-font": "fonts:terminus",
        "the_silver_searcher": "the-silver-searcher",
        "tz": "tzdata",
        "vis": "vis-editor",
        "wpa_supplicant": "wpa-supplicant",
    }
    skip = set(
        [
            "adobe-source-fonts",
            "b3sum",
            "cproc",
            "fspec-sync",
            "libutp",
            "linux-headers",
            "mc",
            "openbsd",
            "qbe",
            "sbase",
            "sdhcp",
            "skeleton",
            "spm",
            "st",
            "swc",
            "ubase",
            "velox",
            "wld",
        ]
    )
    p = subprocess.Popen(["git", "-C", path, "ls-tree", "HEAD"], stdout=subprocess.PIPE)
    for line in p.stdout:
        fields = line.decode().split()
        if fields[1] != "tree" or fields[3] in skip:
            continue
        name = fields[3]
        try:
            with open("{}/{}/ver".format(path, name), "r") as f:
                oldver = f.read().rsplit(maxsplit=1)[0]
        except FileNotFoundError:
            continue
        proj = names.get(name, name)
        with urllib.request.urlopen(
            "https://repology.org/api/v1/project/{}".format(proj)
        ) as response:
            pkgs = json.loads(response.read())
        newest = collections.Counter()
        for pkg in pkgs:
            if pkg["status"] in ("newest", "unique"):
                newest[pkg["version"]] += 1
        if not newest:
            print("could not find newest version of {}".format(proj), file=sys.stderr)
            continue
        newver = newest.most_common(1)[0][0]
        if oldver != newver:
            print("{:20} {:16} => {:16}".format(name, oldver, newver))
    if p.wait():
        raise CalledProcessError(p.retcode, p.args)


paths = []
for dpath, dnames, _ in os.walk("pkg"):
    paths += [dpath]
    depth = dpath.count(os.path.sep)
    if depth >= 1:
        del dnames[:]

# strip "pkg"
paths = paths[1:]
for path in paths:
    check_sub_tree(path)
