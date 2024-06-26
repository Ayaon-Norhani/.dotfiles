# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

alias pbcopy='xsel --input --clipboard'
alias pbpaste='xsel --output --clipboard'


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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

# Show git branch name
force_color_prompt=yes
color_prompt=yes

parse_git_branch() {
    IN_GIT=$(git rev-parse --is-inside-work-tree 2>/dev/null)
    if [ -n "$IN_GIT" ]; then
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/⎇  \1/'
        unset IN_GIT
    fi
}

if [ "$color_prompt" = yes ]; then

 # User
    PS1='${debian_chroot:+($debian_chroot)}\[\033[1;37m\]\[\033[40m\] 🏁 \u@\h'
    PS1+='\[\033[0;30m\]\[\033[104m\]█'

    # Directory
    PS1+='\[\033[0;30m\]\[\033[104m\] 🏎  \w'
    PS1+='\[\033[0m\]\[\033[2;37m\]█'
    PS1+='\[\033[0m\]\[\033[2;30m\]█'
    PS1+='\[\033[0m\]\[\033[0;31m\]█'
    PS1+='\[\033[0m\]\[\033[0;32m\]█'
    PS1+='\[\033[0m\]\[\033[0;33m\]█'
    PS1+='\[\033[0m\]\[\033[0;34m\]█'
    PS1+='\[\033[0m\]\[\033[0;36m\]█'
    PS1+='\[\033[0m\]\[\033[1;30m\]█'
    PS1+='\[\033[0m\]\[\033[1;37m\]█'

    # Branch
    PS1+='\[\033[1;94m\]$(parse_git_branch)\[\033[0;93m\]'
    PS1+='\[\033[00m\]'

    # # User
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[1;90m\033[107m 🏁 \u@\h'
    # PS1+='\[\033[1;97m\033[44m█'

    # # Directory
    # PS1+='\033[1;30m\033[44m 🏎  \033[1;97m\033[44m\w'
    # PS1+='\[\033[0;34m█'

    # # Branch
    # PS1+='\[\033[1;94m$(parse_git_branch)\033[0;93m'
    # PS1+='\[\033[00m\]'

    # Input
    PS1+='\'\n'⮩ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\'\n'⮩ '
fi
unset color_prompt force_color_prompt

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

random_number1=$((1 + RANDOM % 6))
random_number2=$((1 + RANDOM % 6))
C1='\033[1;9'$random_number1'm'
C2='\033[1;9'$random_number2'm'

echo -e ${C1}'  ____   ___    __   _   ' ${C2}        '___  __   __ '
echo -e ${C1}' / ___| | . |  |  \ | |' ${C2}        '|  _ \ \.\ /./ '
echo -e ${C1}'|.|      | |   | . \| |' ${C2}        '|.| | | \ V /  '
echo -e ${C1}'| |___   |.|   | |\ . |' ${C2}        '| | | |  | |   '
echo -e ${C1}' \____| |___|  |_| \__|' ${C2}        '|____/   |_|   '
echo ""
unset C1 C2 random_number1 random_number2


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

                          
# Font installation script
#sudo apt install fonts-noto
#download hack nerd fonts