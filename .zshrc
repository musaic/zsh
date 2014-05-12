#!/usr/bin/env zsh
#(FOR EDITOR FILE-TYPING ONLY, DO NOT EXEC!)
#
# zshrc- Runs for interactive shells.
#
# Modeline and Notes
# vim: set foldmarker={{{,}}} foldlevel=0 foldmethod=marker ft=zsh
#
# .zshrc
# for zsh 3.1.6 and newer (may work OK with earlier versions)
#

export ZSHRC_DONE=1
[[ $MYDEBUG -ge 1 ]] && print '[zshrc]'



#====================================================================
# Setup Oh-My-ZSH Environment Variables
##
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="musaic"	# Located in the custom/themes directory
export CASE_SENSITIVE="false"
export DISABLE_AUTO_UPDATE="true"
#export UPDATE_ZSH_DAYS=13
export DISABLE_LS_COLORS="true"
export DISABLE_AUTO_TITLE="false"
export DISABLE_CORRECTION="true"
export COMPLETION_WAITING_DOTS="true"
export DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(brew \
         bundler \
         colored-man \
         colorize themes \
         screen \
         )

# Load all of the config files in ~/oh-my-zsh that end in .zsh
# TIP: Add files you don't want in git to .gitignore

libs=(aliases \
#      completions \
#      correction \
#      directories \
#      edit-command-line \
      functions \
      git \
#      grep \
#      history \
#      key-bindings \
#      misc \
#      rbenv \
#      rvm \
      spectrum \
      termsupport \
      theme-and-appearance \
      )

#setopt -x
[[ -r $ZSH/oh-my-zsh.sh ]] && source "$ZSH/oh-my-zsh.sh"




#====================================================================
# Options and Aliases
##

[[ -r $HOME/.zsh/zopt ]]   && . "$HOME/.zsh/zopt"
[[ -r $HOME/.zsh/zalias ]] && . "$HOME/.zsh/zalias"





# Compilation flags
# export ARCHFLAGS="-arch x86_64"


# oh-my-zsh seems to wipe out any settings for fpath, so...

# [[ $fpath = /usr/local/share/zsh/functions ]]       || fpath=(/usr/local/share/zsh/functions $fpath)
# [[ $fpath = /usr/local/share/zsh/site-functions ]]  || fpath=(/usr/local/share/zsh/site-functions $fpath)
# [[ $fpath = /usr/local/share/zsh/scripts ]]         || fpath=(/usr/local/share/zsh/scripts $fpath)

#autoload -U /usr/local/share/zsh/functions/*(:t)

#=========================================================================
# For gpg-agent...
##
GPG_TTY=$(tty)
export GPG_TTY

#=========================================================================
# Functions
#
#=========================================================================
#
# Make sure .zlogout is always run, even for interactive shells.  Use the
# .zlogout file for cleanup (screen buffer, tmp files, etc).
# TRAPEXIT() {
#     # commands to run here, e.g. if you
#     # always want to run .zlogout:
#     if [[ ! -o login ]]; then
#       # don't do this in a login shell
#       # because it happens anyway
#       . ~/.zlogout
#     fi
#   }

#=========================================================================
#	Growl CLI Notifications from iTerm2
#	TODO: This is only for iTerm2- we need to test for it
##
# if [[ (-n $TERM_PROGRAM ) && ( "$TERM_PROGRAM" =~ "Apple_Terminal" ) ]]; then
#     growl() { echo -e $'\e]9;'${1}'\007' ; return ;  }
# fi
