# Pkg
a command line package manager for Puppy Linux

## Features

- powerful command line interface, lots of options
- context-sensitive TAB completion of package, file, dir and repo names
- automatically find best matching packages or let the user choose
- search for packages in individual or all repos
- easily compile packages from source
- supports buildtools: petbuild, src2pkg, sbopkg, buildpet
- supports packages: .pet, tar.gz, .txz, .deb, .sfs, .rpm, more
- install/uninstall SFS files just like regular packages
- combine packages and dependencies into SFS files
- convert packages between supported filetypes
- find out which package a file belongs to
- find out which repo a package belongs to
- compatible with Puppy Package Manager (petget)
- includes a console frontend (dialog) menu called Pkgdialog
- includes a GTK frontend (GTKdialog) called Gpkgdialog 


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
│       └── sources-all
├── pet.specs
├── root/
├── sbin/
│   ├── makepkg -> makepkg-fast
│   └── makepkg-fast
└── usr/
    ├── bin/
    │   ├── buildpet
    │   ├── splitpkg
    │   └── strippkg
    ├── lib/
    │   └── pkg/
    │       └── docs/
    │           ├── examples.txt
    │           ├── help-all.txt
    │           ├── help.txt
    │           └── usage
    │               └── [lots of scripts]
    ├── sbin/
    │   ├── download_file_old
    │   ├── download_progress
    │   ├── exploderpm
    │   ├── gpkg -> pkg
    │   ├── gpkgdialog
    │   ├── pkg
    │   ├── pkgdialog
    │   ├── sfs_loadr
    │   ├── sfs_optimise
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

These options can be used together and MUST precede all others:
  
 --ask|-a 			ask before doing stuff (give as 1st option)
 --force |-f			force downloading, installing and uninstalling
 --no-colour|-nc		disable ANSI colours in pkg output

The options below can be used with the options above, but they can't be 
used with each other:
  
 --get|-g PKGNAME		download & install matching package and deps
 --get-only|-go PKGNAME		same as --get, but don't install
 --download|-d PKGNAME		download a package from CURRENT repo
 --install|-i PKGNAME		install a downloaded package
 --install-all|-ia		install all downloaded packages
 --deps|-e PKGNAME		install dependencies of matching package
 --deps-download|-ed PKGNAME	only download dependencies, no install
 --deps-all|-ea			install dependencies of all installed packages
 --deps-check|-ec		prints message about missing dependencies 
 --what-needs|-wn PKGNAME       lists pkgs that depend on PKGNAME 
 --pkg-update|-pu [PKGNAME]	update all matching installed packages
 --uninstall|-u PKGNAME		uninstall a pet package
 --uninstall-all|-ua		uninstall all installed packages
 --delete|-l PKGNAME		delete a downloaded package
 --delete-all|-la 		delete ALL downloaded pet packages!
 --clean [PKGNAME] 		delete downloaded pkg files of installed pkgs
  
 --names|-n [PKG]		list package name matches in the CURRENT repo
 --names-all|-na [PKG]		list package name matches in ALL repos
 --names-exact|-ne [PKG]	list EXACT package name matches in CURRENT repo
 --names-exact-all|-nea [PKG]	list EXACT package name matches in ALL repos
 --list-downloaded|-ld [PKG]	list downloaded packages, PKGNAME is a filter
 --list-installed|-li|-LI [PKG]	list installed packages, PKGNAME is a filter
 --list-deps|-le|-LE		PKGNAME	list the dependencies of PKGNAME

 --pkg-build|-pb PKG		build a PET package from source and install it
 --pkg-build-list|-pbl [PKG]	list all build scripts, PKGNAME is optional 
 --pkg-status|-ps|-PS PKG	show package status (name, size, deps, etc)
 --pkg-entry|-pe PKG		show package repo entry (if in current repo)
 --pkg-installed|-pi PKG	return true if package installed, false if not
 --pkg-repack|-pr PKG		build a .pet package from an installed package
 --pkg-combine|-pc PKG		build a new package containing PKGNAME + deps
 --sfs-combine|-sc PKG		build a new SFS file containing PKGNAME + deps
 --extract|--unpack PKGFILE	extract package contents into folder
 --contents|-c PKG		list the contents of a downloaded package
 --which|-w FILENAME		find out which pkg FILENAME comes from
 --which-repo|-wr PKG		find out which repo PKG comes from

These options cannot be used with any other options:
  
 --all-pkgs			list details of all packages in CURRENT repo
 --search|-s [SEARCH]		search all package info in CURRENT repo
 --search-all|-sa [SEARCH]	search all package info in ALL repos

 --repo|-r [REPONAME]		set repo to use, show current repo if none given
 --repo-info|-ri REPONAME	display the name, and other info of CURRENT repo
 --repo-list|-rl		list names of all available repositories 
 --repo-file-list|-rfl		list all available repository files
 --repo-update|-ru [REPONAME]	update the current repo package list
 --repo-convert|-rc FILE	convert repo files to pre/post Woof format
 --add-source			add new repo (needs repo file in ~/.packages/)
 --update-sources		update the list of available repos
 --repo-pkg-scope one|all	search pkgs in current repo (one), or all (all)
 --repo-dep-scope one|all	search deps in current repo (one), or all (all)
 --bleeding-edge no|yes	if yes, get latest pkg versions, from ANY repo
 --recursive-dep-check no|yes	get deps recursively (yes), or not (no)
  
 --dir2pet DIR			create a pet package from a directory
 --dir2sfs DIR			create an sfs package from a directory
 --dir2tgz DIR			create a tar.gz file from a directory
 --deb2pet DEBFILE		convert local deb file to a pet package
 --pet2sfs PETFILE		convert local pet file to an sfs package
 --pet2tgz PETFILE		convert local pet file to a tar.gz package
 --pet2txz PETFILE		convert local pet file to a tar.xz package
 --sfs2pet SFSFILE		convert local sfs file to a pet package
 --tgz2pet TARFILE		convert local tar.gz|tgz file to PET
 --txz2pet TXZFILE		convert local tar.xz|txz file to PET

 --workdir			set a new working directory. Default is ~/pkg/
 --autoclean			auto delete pkg files after download+install
 --show-config			show current config, repo and search settings
 --welcome			print some useful cmds to help get started
 --func-list			list all functions used in this program
 --version|-v			show the version of this script
 --examples|-ex			show example command line usage of pkg
 --usage|-usage [CMD]		show usage of CMD, or list available cmds
 --help|-h			show this help information
 --help-all|-H			show a full description, with added info
```

## Examples

```
EXAMPLE COMMANDS:

 pkg -s SEARCH			# list pkgs in current repo matching SEARCH
 pkg -sa SEARCH			# list pkgs in all repos matching SEARCH
 pkg -n SEARCH			# search name only, list all matching pkgs
 pkg -g filezilla		# get & install filezilla and deps
 pkg -a -g filezilla		# ask to download filezilla and its deps
 pkg -a -la			# ask to delete all downloaded packages
 pkg -a -e PKGNAME		# install deps of PKGNAME, ask each time
 pkg -a -d qupzilla-1.2.0	# ask to download qupzilla-1.2.0
 pkg -go filezilla		# download filezilla & deps, don't install
 pkg -e PKGNAME			# install all deps of PKGNAME, dont ask
 pkg -d qupzilla-1.3.1		# download qupzilla-1.3.1 no questions
 pkg -l qupzilla-1.3.1		# delete the downloaded qupzilla-1.3.1
 pkg -pb jwm			# compile, build & install the 'jwm' package
 pkg -la			# delete all downloaded packages without asking!
 pkg -li vim | pkg -ps -	# Get info on all installed Vim pkgs
 pkg -li vim | pkg -wr -	# Get repo of an installed Vim pkg 
 pkg -li | pkg -a -u -		# Ask to uninstall installed pkgs one by one 
 pkg --dir2pet /path/to/dir/	# convert a local dir to a .pet package
 pkg --dir2sfs /path/to/dir/	# convert a local dir to a .sfs package
 pkg -i /path/to/file.pet	# install PET, include the extension!
 pkg --tgz2pet /path/to/file	# convert a local .tar.gz file to PET
 pkg --unpack /path/to/file	# extract the given pkg file contents

```
