# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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

# jun add start
alias c='clear'
alias llh='ls -alFh'
alias f='find . -name'

    #  for compiling Android, include JDK6 path and so on
PATH="$PATH:/sbin:$HOME/jdk6/jdk1.6.0_31/bin:$HOME/jdk6/jdk1.6.0_31/lib"
CLASSPATH=".:$HOME/jdk6/jdk1.6.0_31/lib"
JAVA_HOME="$HOME/jdk6/jdk1.6.0_31"

    # for android cts, include adb path and so on.
PATH="$PATH:/home/jun/cts/4.0.3/android-sdk-linux_86/platform-tools"
export SDK_ROOT="/home/jun/cts/4.0.3/android-sdk-linux_86"

export PATH #Not strictly speaking, /etc/enviroment(usually NOT exists) --> /etc/profile --> $HOME/.profile --> $HOME/.bashrc

    # directory quickly switchs
export S="/home/jun/android-sdk-linux/platform-tools"

export R="$HOME/rk30-kernel-release"
export RC="$HOME/rk30-kernel-release/arch/arm/mach-rk30/include/mach/board"
export RD="$HOME/rk30-kernel-release/drivers"
export RM="$HOME/rk30-kernel-release/arch/arm/mach-rk30"

export RA="$HOME/rk/rk3066/android"
export CT="$HOME/cts/4.0.3/android-cts/tools"

export AI="/home/jun/amlogic/m3/android/device/amlogic/M819MD/images"
export AA="/home/jun/amlogic/m3/android"
export AK="/home/jun/amlogic/m3/kernel"
export AU="/home/jun/amlogic/m3/bootloader"
export AM="/home/jun/amlogic/m3/kernel/arch/arm/mach-meson3"
export AO="/home/jun/amlogic/m3/android/out/target/product"

#export CSCOPE_DB="$HOME/cscope_db/cscope.out"
# jun add end
