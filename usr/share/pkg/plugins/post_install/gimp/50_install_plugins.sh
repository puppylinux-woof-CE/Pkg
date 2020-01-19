# ----------------------------------------------------------------
#
# This script will be sourced by Pkg after gimp is installed.
#
# This script will be run by the busybox Ash interpreter, so it
# cannot use things like Bash arrays.
# ----------------------------------------------------------------


# This is a plugin for Pkg. The main function is 'run'.
#
# Pkg will run this function after this script is sourced.
# You can define other functions and call them from 'run'.
#
# Because this script is sourced by Pkg, it's functions and
# variables are available to this script. This includes:
#
#   $PKGNAME       - the full package name, with version  (vlc-2.4.5)
#   $PKGNAME_ONLY  - the shortened package name only      (vlc)
#   $WORKDIR       - the dir in which Pkg puts files, builds packages, etc
#
# As well as lots of functions like:
#
#   get_pkg_name vlc              - returns vlc-2.4.5
#   get_pkg_name_only vlc-2.4.5   - returns vlc
#   get_pkg_version vlc           - return 2.4.5
#
#  ...and lots more (see /usr/sbin/pkg)


# ====================   Begin plugin  =======================

# define some settings for this plugin that Pkg can use

PLUGIN_REQUIRES_ASK=true        # if true, skip this plugin unless ASK=true (--ask was given)
PLUGIN_REQUIRES_FORCE=false     # if true, skip this plugin unless FORCE=true (--force was given)

# Pkg will execute the 'run' function after this script is sourced.
# You can define other functions below and call them from 'run'.

run() {
  # if --ask was NOT given, this plugin will be skipped entirely,
  # because PLUGIN_REQUIRES_ASK=true (set above)

  local ANSWER
  local pkglist

  pkglist='gimp-cbmplugs gimp-dcraw gimp-dds gimp-gap gimp-gluas gimp-gmic gimp-gutenprint gimp-lensfun gimp-plugin-registry gimp-texturize gimp-ufraw'

  # if we got here, we know --ask was given, so respect it
  if [ "$ASK" = true ];then
    read -r -n1 -p "  Install gimp plugins (y/n)? " ANSWER </dev/tty
    echo
  fi

  if [ "$ANSWER" = "y" ];then
    echo "Installing gimp plugins..."
    for pkgname in $pkglist
    do
      ASK=false FORCE=true pkg download $pkgname -f -q
      ASK=false FORCE=true pkg install $pkgname -f -q
    done
  fi
}

