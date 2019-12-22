# Pkg

a command line package manager for Puppy Linux

## Features

- powerful command line interface, lots of options
- automatically find best matching packages or let the user choose
- supports packages: .pet, tar.gz, .txz, .deb, .sfs
- easily add more repos, direct from Ubuntu, PPA, Debian & Slackware sources
- context-sensitive TAB completion of package, file, dir and repo names
- search for packages in individual or all repos
- easily compile packages from source (supports petbuild, src2pkg, sbopkg, buildpet)
- combine packages and dependencies into SFS files
- convert packages between supported filetypes
- find out which package a file belongs to
- find out which repo a package belongs to
- compatible with Puppy Package Manager
- includes a console frontend (dialog) menu, called Pkgdialog
- includes a GTK frontend (GTKdialog), called Gpkgdialog

### Dependencies

- Bash & Busybox (ash, wget, find, which, grep, sed, tar, du, sync, etc)
- coreutils (cp, mv, rm, wc, uniq, chmod, cut, cat, sort, etc)
- Puppy Package Manager (for `pkg repo-update` only)

### Quick Start

Install Pkg:

- clone this repo: `cd ~; mkdir -pv Gitlab; git clone https://gitlab.com/sc0ttj/Pkg Gitlab/Pkg`
- install (and register with PetGet): `cd ~/Gitlab/Pkg; ./installer.sh`

Get started:

1. View useful welcome message: `pkg welcome`
2. Update all repo files: `pkg update-sources`
3. List available repos: `pkg repo-list`
4. Change repo: `pkg repo <REPONAME>`
5. Search current repo for packages by name: `pkg n <PKGNAME>`
6. Search ALL repos for package name: `pkg na <PKGNAME>`
7. Get package info: `pkg status <PKGNAME>`
8. Download and install a package (and its dependencies): `pkg add <PKGNAME>`
9. Remove a package (and any left-over dependencies): `pkg rm <PKGNAME>`

### More advanced usage

Search all package info in a repo:

`pkg search WORDS`

Search all package info in all repos:

`pkg search-all WORDS`

Download a package, plus its dependencies, but don't install:

`pkg get-only PKGNAME`

Or manually download and install packages without dependencies:

`pkg download PKGNAME; pkg install PKGNAME`

Choose from a selection of matching packages, and decide which  
ones to download, install, which dependencies to get, as you go:

`pkg --ask add "firefox mplayer"`

Ask to uninstall each '\_DEV' package you have installed:

`pkg list-installed | grep _DEV | pkg --ask uninstall -`

Display busybox package status, and package contents:

`pkg -ps busybox -c busybox`

Download and unzip all repo packages matching 'freeciv':

`cd /root/pkg; pkg na freeciv | pkg d -; pkg ld freeciv | pkg unpack -`

Build (compile) packages from source:

`pkg build emelfm`

Build (compile) packages from source, with custom build options:  
(requires BUILDTOOL=buildpet in ~/.pkg/pkgrc)

`pkg build xarchiver --configure='--prefix=/usr/local --other-opts' --cflags='-D -02 -whatever'`

Set a different config file:

`PKGRC=/path/to/your/pkgrc <pkg command>`

Let Pkg suggest packages on missing commands:

`source /usr/share/pkg/command_not_found_handle.sh`

Disable package suggestions on missing command with:

`unset command_not_found_handle`

## Files

```
/
├── etc/
│   ├── bash_completion.d/
│   │   ├── gpkg -> pkg
│   │   └── pkg
│   └── pkg/
│       ├── pkgrc
│       ├── sources
│       ├── sources-user
│       └── sources-all
├── pet.specs
├── root/
│   ├───.pkg/
│   │   ├── pkgrc
│   │   ├── sources
│   │   ├── sources-user
│   │   └── sources-all
├── sbin/
│   ├── makepkg -> makepkg-fast
│   └── makepkg-fast
└── usr/
    ├── bin/
    │   ├── buildpet
    │   ├── splitpkg
    │   └── strippkg
    ├── sbin/
    │   ├── apt2pup
    │   ├── download_progress
    │   ├── gpkg -> pkg
    │   ├── gpkgdialog
    │   ├── ppa2pup
    │   ├── ppa2pup_gawk
    │   ├── pkg
    │   ├── pkgdialog
    │   ├── slack2pup
    │   └── Xpkgdialog -> pkgdialog
    └── share/
        ├── applications/
        │   ├── gpkgdialog.desktop
        │   └── pkgdialog.desktop
        ├── buildpet/
        │   ├── buildpet.profile
        │   ├── buildingblock/
        │   ├── business/
        │   ├── desktop/
        │   ├── document/
        │   ├── filesystem/
        │   ├── fun/
        │   ├── graphic/
        │   ├── help/
        │   ├── internet/
        │   ├── multimedia/
        │   ├── network/
        │   ├── personal/
        │   ├── system/
        │   └── utility/
        ├── pkg/
        │   ├── usage/
        │   │   └── [commands usage info]
        │   └── docs/
        │       ├── env_vars.txt
        │       ├── examples.txt
        │       ├── help.txt
        │       └── help-all.txt
        ├── doc/
        │   └── pkg/
        │       └── README.md
        └── man/
            └── man1/
                └── pkg.1

33 directories, 388 files
```

## Usage

```
Usage: [OPTION(S)] SEARCH|PKGNAME|BUILDSCRIPT|FILE|-

OPTIONS:

These options MUST go before (or after) all other commands:

 --ask|-a                   ask before doing stuff (give as 1st option)
 --quiet|-q                 suppress some output, like download progress
 --force |-f                force downloading, installing and uninstalling
 --no-colour|-nc            disable ANSI colours in $SELF output

COMMANDS:

These commands can be used with the options above, but not each other:

 search|s [SEARCH]          search all package info in CURRENT repo
 search-all|sa [SEARCH]     search all package info in ALL repos

 names|n [PKGNAME]          list package name matches in the CURRENT repo
 names-all|na [PKGNAME]     list package name matches in ALL repos

 add|a PKGNAME              download & install matching package and deps
 remove|rm PKGNAME          uninstall a package and any left over deps

 get|g PKGNAME              alias of add (see the command above)
 get-only|go PKGNAME        same as get, but don't install
 download|d PKGNAME         download a package from CURRENT repo
 install|i PKGNAME          install a downloaded package
 install-all|ia             install all downloaded packages
 update|pu [PKGNAME]        update all matching installed packages
 extract|unpack PKGFILE     extract package contents into folder
 split PKGFILE              split a package into DEV, DOC, NLS packages

 deps|e PKGNAME             install dependencies of matching package
 deps-download|ed PKGNAME   only download dependencies, no install
 deps-all|ea                install dependencies of all installed packages
 deps-check|ldd             prints message about missing dependencies

 uninstall|u PKGNAME        uninstall a package
 uninstall-all|ua           uninstall all installed packages
 delete|l PKGNAME           delete a downloaded package
 delete-all|la              delete ALL downloaded packages

 blacklist PKGNAME          ignore a package, so it doesnt get installed
 whitelist PKGNAME          remove a package from the blacklist

 clean [PKGNAME]            delete downloaded pkg files of installed pkgs
 autoclean [yes|no]         auto delete pkg files after download+install

 list-downloaded|ld [PKG]   list downloaded packages, PKGNAME is a filter
 list-installed|li|LI [PKG] list installed packages, PKGNAME is a filter
 list-builtins|lb [PKG]     list "builtin" packages, PKG is a filter
 list-deps|le|LE PKGNAME    list the dependencies of PKGNAME

 build-list|pbl [PKG]       list all build scripts, PKGNAME is optional
 build|pb PKG               build a PET package from source and install it
 pkg-combine|pc PKG         build a new package containing PKGNAME + deps
 sfs-combine|sc PKG         build a new SFS file containing PKGNAME + deps
 repack|pr PKG              build a .pet package from an installed package
 merge PKGNAME,PKGNAME,..   merge multiple packages into a single package

 status|ps|PS PKG           show package status (name, size, deps, etc)
 contents|c PKG             list the contents of a downloaded package
 entry|pe PKG               show package repo entry (if in current repo)
 installed|pi PKG           return true if package installed, false if not

 all-pkgs                   list details of all packages in CURRENT repo
 names-exact|ne [PKG]       list EXACT package name matches in CURRENT repo
 names-exact-all|nea [PKG]  list EXACT package name matches in ALL repos

 what-needs|wn PKGNAME      lists pkgs that depend on PKGNAME
 which|w FILENAME           find out which pkg FILENAME comes from
 which-repo|wr PKG          find out which repo PKG comes from

 repo|r [REPONAME]          set repo to use, show current repo if none given
 repo-info|ri REPONAME      display the name, and other info of CURRENT repo
 repo-update|ru [REPONAME]  update the current repo package list
 repo-list|rl               list names of all available repositories
 repo-file-list|rfl         list all available repository files
 repo-convert|rc FILE       convert repo files to pre/post Woof format

 add-repo                   add a Pkg, PPA, Ubuntu, Debian or Slackware repo
 rm-repo                    remove an installed repo
 dir2repo                   create a Puppy repo from a directory of packages
 add-source                 add a Puppy repo (needs repo file in ~/.packages/)
 update-sources             update the list of available repos

 repo-pkg-scope one|all     search pkgs in current repo (one), or all (all)
 repo-dep-scope one|all     search deps in current repo (one), or all (all)
 bleeding-edge no|yes       if yes, get latest pkg versions, from ANY repo
 rdep-check no|yes          get deps recursively (yes), or not (no)

 dir2pet DIR                create a pet package from a directory
 dir2sfs DIR                create an sfs package from a directory
 dir2tgz DIR                create a tar.gz file from a directory
 deb2pet DEBFILE            convert local deb file to a pet package
 pet2sfs PETFILE            convert local pet file to an sfs package
 pet2tgz PETFILE            convert local pet file to a tar.gz package
 pet2txz PETFILE            convert local pet file to a tar.xz package
 sfs2pet SFSFILE            convert local sfs file to a pet package
 tgz2pet TARFILE            convert local tar.gz|tgz file to PET
 txz2pet TXZFILE            convert local tar.xz|txz file to PET

 welcome                    print some useful cmds to help get started
 show-config                show current config, repo and search settings
 workdir                    set a new working directory. Default is ~/pkg/

 version|v                  show the version of this script

 help|h                     show this help information
 help-all|H                 show a full description, with added info
 usage [CMD]                show usage of CMD, or list available cmds
 examples|ex                show example command line usage of pkg
 func-list                  list all functions used in this program
```

## Environment Variables:

```
 HIDE_INSTALLED [=false]    if true, ignore/hide installed packages
 HIDE_BUILTINS   [=true]    if true, ignore/hide builtin packages
 HIDE_USER_PKGS  [=true]    if true, ignore/hide user installed packages
 NO_ALIASES     [=false]    if true, ignore package name aliases in searches
 NO_INSTALL     [=false]    if true, skip installing of packages
 PKG_NO_COLOURS [=false]    if true, disable coloured output

 PKG_BLACKLIST  [=empty]    a space separated list of packages to ignore,
                            which will be appended to the contents of
                            $HOME/.pkg/blackisted_packages
```

When `BUILDTOOL=buildpet` in `~/.pkg/pkgrc` (use with `pkg build` command):

```
 PKG_CONFIGURE  [='']       custom configure options fpr building packages
 PKG_CFLAGS     [='']       custom CFLAG options for buiding packages
```

## Example commands:

```
 pkg s SEARCH               # list pkgs in current repo matching SEARCH

 pkg sa SEARCH              # list pkgs in all repos matching SEARCH

 pkg n SEARCH               # search names only, list all matching pkgs

 pkg na SEARCH              # search name only, all repos, list matching pkgs

 pkg add blender            # install Blender and it dependencies

 pkg rm blender             # remove Blender and any left-over dependencies

 pkg la                     # ask to delete all downloaded packages

 pkg -a e PKGNAME           # install deps of PKGNAME, ask each time

 pkg -a d qupzilla-1.2.0    # ask to download qupzilla-1.2.0

 pkg go filezilla           # download filezilla & deps, don't install

 pkg e PKGNAME              # install all deps of PKGNAME, dont ask

 pkg d qupzilla-1.3.1       # download qupzilla-1.3.1 no questions

 pkg l qupzilla-1.3.1       # delete the downloaded qupzilla-1.3.1

 pkg build jwm              # compile, build & install the 'jwm' package

 pkg la                     # delete all downloaded packages without asking

 pkg li vim | pkg status -  # Get info on all installed Vim pkgs

 pkg li vim | pkg wr -      # Get repo of an installed Vim pkg

 pkg li | pkg -a u -        # Ask to uninstall installed pkgs one by one

 pkg dir2sfs /path/to/dir/  # convert a local dir to a .sfs package

 pkg i /path/to/file.pet    # install PET, include the extension!

 pkg tgz2pet /path/to/file  # convert a local .tar.gz file to PET

 pkg unpack /path/to/file   # extract the given package file

 pkg split /path/to/file    # split a single package into DEV, DOC and NLS packages
```
