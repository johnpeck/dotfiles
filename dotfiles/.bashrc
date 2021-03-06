# /etc/bash.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.

if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

use_color=false

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \W \$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs

# Set up the default editor
export EDITOR=emacs

# Set up bashmarks (https://github.com/twerth/bashmarks)
# source /usr/local/bin/bashmarks.sh

# ---------------------- Configure ssh-agent ---------------------------
source ~/.keychain/$HOSTNAME-sh

# ------------------- Configure xterm transparency ---------------------

[ -n "$XTERM_VERSION" ] && transset-df -a 0.6 >/dev/null

# -------------------------- Fix up $PATH ------------------------------

# Remove path to MKS make
oldpath=$PATH
rmpath=":/cygdrive/c/MKS/mksnt"
PATH=${oldpath//"$rmpath"/}

# Fix paths for Octave
oldpath=$PATH
addpath="/usr/lib/lapack"
PATH="$oldpath"":$addpath"

# Add path for poole (static websites)
oldpath=$PATH
addpath="/usr/share/obensonne-poole-625d57a5d07a"
PATH="$oldpath"":$addpath"

# Add path for evince
oldpath=$PATH
addpath="/cygdrive/c/Program Files (x86)/Evince-2.32.0.145/bin"
PATH="$oldpath"":$addpath"

# Add path for WinAVR
oldpath=$PATH
addpath="/cygdrive/c/WinAVR-20100110/bin"
PATH="$oldpath"":$addpath"

# Increase priority of /usr/bin
oldpath=$PATH
rmpath=":/usr/bin"
PATH=${oldpath//"$rmpath"/}
oldpath=$PATH
PATH="$rmpath"":""$oldpath"

# Add /usr/local/bin
oldpath=$PATH
newpath=":/usr/local/bin"
PATH="$oldpath""$newpath"

# Increase priority of Windows Python
oldpath=$PATH
rmpath="/cygdrive/c/Python27"
PATH=${oldpath//":$rmpath"/}
oldpath=$PATH
PATH=":$rmpath""$oldpath"

# Add windows python scripts path
oldpath=$PATH
addpath="/cygdrive/c/Python27/Scripts"
PATH=":$addpath""$oldpath"

# Add inkscape path
oldpath=$PATH
addpath="/cygdrive/c/Program Files (x86)/Inkscape"
PATH=":$addpath""$oldpath"

# Add path for dotfiles
oldpath=$PATH
addpath=$HOME/.dotfiles/bin
PATH="$oldpath"":$addpath"

# Set DISPLAY
export DISPLAY=:0



