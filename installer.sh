#!/bin/ash

pkgname=pkg-1.9.xalpha-noarch

cp -r etc/ root/ sbin/ usr/ / && echo -e "Pkg installed OK \n" || echo -e "Pkg was NOT installed! \n"

find etc/ root/ sbin/ usr/ | sed -e 's/^/\//g' > ~/.packages/${pkgname}.files

[ ! -z ~/.packages/${pkgname}.files ] && echo -e "Package contents listed in ~/.packages/${pkgname}.files \n"

echo -e "Setting up Pkg... \n"

pkg welcome 
echo

pkg update-sources && echo && pkg repo-update && \
{
  echo -e "\nAvailable repos: \n"
  pkg repo-list

  echo
  echo 'For more help, use `pkg help`'
  echo
}

exit 0
