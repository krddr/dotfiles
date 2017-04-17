# if not running interactively, don't do anything
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

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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
   PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\t\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
   PS1='${debian_chroot:+($debian_chroot)}\t:\W\$ '
fi
unset color_prompt force_color_prompt

# add a bell on command completion.
export PROMPT_COMMAND="echo -ne '\a'"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
   test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
   alias ls='ls --color=auto'

   alias grep='grep --color=auto'
   alias fgrep='fgrep --color=auto'
   alias egrep='egrep --color=auto'
fi

# some must-have aliases
alias ll='ls -lsh'
alias la='ls -A'
alias l='ls -CF'

# some bindings that make bash work like the rest of the environment
# 1. use ctrl+arrows to move forward and back by word
bind '"\eOC":forward-word'
bind '"\eOD":backward-word'
# 2. use ctrl-backspace to backward-kill-word or unix-word-rubout
#bind '"\C-?":"\C-W"'
bind '"\C-H":"\C-W"'

# FIXME workaround for irssi scrolling in tmux
alias irssi='TERM=screen-256color irssi'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
   . /etc/bash_completion
fi

export EDITOR=vim

PYTHONSTARTUP=~/.pythonrc.py
export PYTHONSTARTUP

# source setting that should not be displayed publicly.
if [ -f ~/.bashrc_internal ]; then
   . ~/.bashrc_internal
fi
