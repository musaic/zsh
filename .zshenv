#!/usr/bin/env zsh
#(FOR EDITOR FILE-TYPING ONLY)
#
# zshenv- put as little as possible in here.  Every single shell will be affected,
# even 'zsh -f'.
#
#

#====================================================================
# Debugging Prompts
####
if [[ -o interactive ]]; then
  export PS4="%* (%L)==> %N %i | "
  export PS4='+ %(?.0.%F{red}%?%f)[%L] %1N[%i]=> %_'
fi

MYDEBUG=1

if [[ $MYDEBUG -ge 1 ]]; then
  [[ $MYDEBUG -ge 2 ]] && env | sort
  if [[ $ZSHENV_DONE == 1 ]]; then
    print '[zshenv: skipped]'
    return 0
  else
    print '[zshenv]'
  fi
fi



#====================================================================
# Language/Localization
# TODO: Need US currency
#==================================================

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi



#====================================================================
# Global: Host-Specific
#=======================================
##

export OS="${OSTYPE%%[0-9.]*}"
export HOSTNAME="$(scutil --get HostName)"
export LOCALHOSTNAME="$(scutil --get LocalHostName)"
export COMPUTERNAME="$(scutil --get ComputerName)"



#=======================================
# Global: Temporary Directories
##

export TMPDIR="$HOME/tmp"
export TMPPREFIX="${TMPDIR}/zsh"
[[ -d "$TMPDIR" ]]    || mkdir -p "$TMPDIR"
[[ -d "$TMPPREFIX" ]] || mkdir -p "$TMPPREFIX"



#====================================================================
# PATHS and EXPORTS
#
#   TODO: Write intro here...
#         Need *portable* functions for appending and prepending array
#         elements to path-related variables.
#
####


typeset -U path cdpath fpath manpath      #No dupes allowed!


if [[ $SHLVL == 1 ]]; then
  [[ $MYDEBUG -ge 1 ]]    && echo '[zshenv: zpath,zexport,zfunc]'
  [[ -r ~/.zsh/zpath ]]   && . ~/.zsh/zpath
  [[ -r ~/.zsh/zexport ]] && . ~/.zsh/zexport
  [[ -r ~/.zsh/zfunc ]]   && . ~/.zsh/zfunc
fi



#====================================================================
# SECURITY
#==================================================
#   Run Keychain for GnuPG and SSH Agent control...
#   keychain 2.7.1 ~ http://www.funtoo.org
#	TODO: Debug remote logins
####
if [[ $SHLVL == 1 ]]; then
  [[ $MYDEBUG -ge 1 ]]    && echo '[zshenv: zsecure]'
  [[ -r ~/.zsh/zsecure ]] && . ~/.zsh/zsecure

  export GPGHOME="$HOME/.gnupg"

  if which keychain &>/dev/null; then
    eval "$(keychain --quiet --stop others --eval github-rsa ladmin_rsa 2C045AB4)"
  fi
fi




export ZSHENV_DONE=1

return 0
