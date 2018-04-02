#!/bin/ash

pkgname=pkg-1.9.xalpha-noarch

cp -r etc/ root/ sbin/ usr/ / && echo "Pkg installed OK" || echo "Pkg was NOT installed!"

find etc/ root/ sbin/ usr/ | sed -e 's/^/\//g' > ~/.packages/${pkgname}.files

[ ! -z ~/.packages/${pkgname}.files ] && echo "Package contents listed in ~/.packages/${pkgname}.files"

exit 0