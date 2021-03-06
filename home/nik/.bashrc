# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=1000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac
##my my my my my my my my my my my my my my
#color_prompt=yes

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

color_prompt=yes

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\e[01;32m\]\u\[\e[0m\]@\[\e[01;36m\]\h\[\e[00m\]@\[\e[33m\]\t\[\e[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

#alias cd='cd -P'
alias curl='curl -s'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# my settings

# fix green not readable background to o+w dirs
export LS_COLORS=$LS_COLORS:"ow=34;40"

export LD_LIBRARY_PATH=/usr/local/lib

[ -z $JAVA_HOME ] && export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

if [ -z $CLASSPATH ]; then
	export CLASSPATH=$HOME/Downloads/tla
else
	export CLASSPATH=$CLASSPATH:$HOME/Downloads/tla
fi

export GOPATH=$HOME/progrm/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

export PATH=$PATH:$HOME/Downloads/flutter/bin:$HOME/Downloads/flutter/bin/cache/dart-sdk/bin/
#export CDPATH=.:nikandfor:~/github.com/:~/rndcenter

alias vagrant_env="export VAGRANT_HOME=./vagrant.d/"
alias jsf="python -m json.tool"

#export PATH=$PATH:~/Downloads/protoc

# The next line updates PATH for the Google Cloud SDK.
#source '$HOME/Downloads/google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
#source '$HOME/Downloads/google-cloud-sdk/completion.bash.inc'

# get relative path from directory
function relpath {
	python -c "import os.path; print os.path.relpath('$1', '$2')"
}

#source <(kubectl completion bash)

cover() {
	f=/tmp/cover.out
	rm -f $f
	go test "$@" -coverprofile $f
	[ $(cat /tmp/cover.out | wc -l) -gt 1 ] && go tool cover -html $f
}

alias gochroma="chroma -l go -f terminal256 -s rrt"

cgodoc() {
	go doc "$@" | gochroma
}

export QSYS_ROOTDIR="$HOME/progrm/lib/quartus_lite/quartus/sopc_builder/bin"

# OPAM configuration
. $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

export GPG_TTY=$(tty)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
