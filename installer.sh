#!/bin/ash

pkgname=pkg-1.9.23-noarch

mkdir -p /tmp/pkg 2>/dev/null

# dont overwrite the existing ~/.pkg/sources[-all] files, if they exist

for existing_file in /root/.pkg/sources /root/.pkg/sources-all /root/.pkg/sources-user
do
  [ -f "$existing_file" ] && mv "$existing_file" /tmp/pkg/
done

# copy over our new Pkg files

mv /usr/sbin/pkg /usr/sbin/pkg.previous 2>/dev/null

cp -r etc/ root/ sbin/ usr/ / && echo -e "Pkg installed OK \n" || echo -e "Pkg was NOT installed! \n"

# list all Pkg files (not including sources files, cos user might want to keep their added repos)
find etc/ root/ sbin/ usr/ | sed -e 's/^/\//g' > ~/.packages/${pkgname}.files

# put the files back again
for existing_file in /tmp/pkg/sources /tmp/pkg/sources-all /tmp/pkg/sources-user
do
  [ -f $existing_file ] && mv $existing_file /root/.pkg/
done

[ -s ~/.packages/${pkgname}.files ] && echo -e "Package contents listed in ~/.packages/${pkgname}.files \n"

echo -e "Setting up Pkg... \n"

pkg update-sources &>/dev/null

echo
pkg welcome
echo

pkg repo-update && \
{
  sleep 0.1
  echo -e "\nAvailable repos: \n"
  pkg repo-list

  echo
  echo 'For a basic intro, use `pkg welcome`'
  echo 'For more help, use `pkg help`, `pkg help-all` or `pkg usage`'
  echo
}

exit 0
