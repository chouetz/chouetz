# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

up() {
  cd $(eval printf '../'%.0s {1..$1}) && pwd;
}
gt() {
  cd `find ~/workspaces -type d -maxdepth 2 -iname "${1}*"`
}
fsort() {
  sort -u $1 > temporary_file && mv temporary_file $1
}
ptest() {
  if [ -n $2 ]; then
    python3 -m unittest discover --verbose --start-directory ${1}
  else
    python -m unittest discover --verbose --start-directory ${1}
  fi
}
mcurl() {
  [ -n "$2" ] && option="-X $2"
  curl -u nschweitzer $option -H 'Content-Type: application/json' $1
}
git_file() {
  git grep -i $1 | cut -d ':' -f 1 | sort -u
}
pp () {
  source ~/workspaces/venv/bin/activate
  python
}

export GREP_OPTIONS='--color=auto'
export CLICOLOR=1
#export PATH=/usr/local/lib/ruby/gems/3.1.0/bin:/usr/local/Cellar/ruby/3.1.3/bin:~/workspaces/tools/nicoscripts:c~/:~/Public/apache-maven/bin:~/Public/openshift-client-mac:~/Public/go/bin:~/workspaces/images/buildserver:~/bin/intellij/bin:~/bin/nodejs/bin:~/Public:$PATH
export PATH=~/workspaces/tools/nicoscripts:c~/:~/Public/apache-maven/bin:~/Public/openshift-client-mac:~/Public/go/bin:~/workspaces/images/buildserver:~/bin/intellij/bin:~/bin/nodejs/bin:~/Public:$PATH
export PYTHONPATH=/Users/nschweitzer/workspaces/tools/pythonmodules:$PYTHONPATH
export PYTHONWARNINGS=ignore
alias pact='source venv/bin/activate'
alias lt='ls -lrth'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias o=less
alias b='source ~/.bashrc'
alias gta=". gt"
alias space='sudo du -sh *'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
# Linux specific
alias dmount='sudo mount /tmp -o remount,exec'
alias bt='pactl load-module module-bluetooth-discover'
alias sshk='pbcopy < ~/.ssh/id_rsa.pub'
export CURL_CA_BUNDLE=

GIT_PROMPT_ONLY_IN_REPO=1
if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
    source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi

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
# Ignore entries in history
export HISTIGNORE="&:ls:lt:ll:la:b:exit"

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

PS1='[\t]${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u\[\033[00m\]@\[\033[01;35m\]mac\[\033[00m\]:\[\033[01;32m\]\w\[\033[00m\]\$ '
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac
#export PROMPT='%B[%*]%{$fg[cyan]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%} %~%b$(git_b)> '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    # alias ls='ls --color=auto'
    # alias dir='dir --color=auto'
    # alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
source ~/Public/git-completion.bash

# Enable the Ctrl+Arrow function
#bind "^[[1;5C" forward-word
#bind "^[[1;5D" backward-word
# Enable the ShareHistory feature
#setopt sharehistory incappendhistory
