# ----------------------------------------------------------------
#
# This script will be sourced by Pkg after wings3d is installed.
# It should be run before any other wings3d post_install plugins.
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

PLUGIN_REQUIRES_ASK=false       # if true, skip this plugin unless ASK=true (--ask was given)
PLUGIN_REQUIRES_FORCE=false     # if true, skip this plugin unless FORCE=true (--force was given)

# Pkg will execute the 'run' function after this script is sourced.
# You can define other functions below and call them from 'run'.

run() {
  echo "Installing extra deps..."

  # install some extra deps which are also required but not picked
  # up by PPM or Pkg (repo files may be missing the required info,
  # or packages not picked up because of weird names).
  case ${DISTRO_BINARY_COMPAT:-unknown} in
    debian)
      # add libwxgtk3.0 and libwxbase3.0-0v5
      pkg -q add libwxgtk3.0-0v5_3.0.2  2>/dev/null
    ;;
    ubuntu) ;;
    trisquel) ;;
    devuan) ;;
    slackware*) ;;
    unknown) ;;
    *) ;;
  esac
}

