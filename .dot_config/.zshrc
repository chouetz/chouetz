#zmodload zsh/zprof
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="nico"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions fast-syntax-highlighting zsh-bat colored-man-pages)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#---------DATADOG SPECIFIC------------
# google-cloud-sdk brew caveat
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

export GITLAB_TOKEN=$(security find-generic-password -a ${USER} -s gitlab_token -w)
# BEGIN ANSIBLE MANAGED BLOCK
# Add homebrew binaries to the path.
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:${PATH?}"

# Force certain more-secure behaviours from homebrew
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS=--require-sha
export HOMEBREW_DIR=/opt/homebrew
export HOMEBREW_BIN=/opt/homebrew/bin

# Load python shims
eval "$(pyenv init -)"

# Load ruby shims
eval "$(rbenv init -)"

# Prefer GNU binaries to Macintosh binaries.
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:${PATH}"

# Add AWS CLI to PATH
export PATH="/opt/homebrew/opt/awscli@1/bin:$PATH"

# Add datadog devtools binaries to the PATH
export PATH="${HOME?}/dd/devtools/bin:${PATH?}"

# Point GOPATH to our go sources
export GOPATH="${HOME?}/go"

# Add binaries that are go install-ed to PATH
export PATH="${GOPATH?}/bin:${PATH?}"

# Add cmake to the PATH
export PATH="/Applications/CMake.app/Contents/bin:$PATH"

# Point DATADOG_ROOT to ~/dd symlink
export DATADOG_ROOT="${HOME?}/dd"

# Tell the devenv vm to mount $GOPATH/src rather than just dd-go
export MOUNT_ALL_GO_SRC=1

# store key in the login keychain instead of aws-vault managing a hidden keychain
export AWS_VAULT_KEYCHAIN_NAME=login

# tweak session times so you don't have to re-enter passwords every 5min
export AWS_SESSION_TTL=24h
export AWS_ASSUME_ROLE_TTL=1h

# Helm switch from storing objects in kubernetes configmaps to
# secrets by default, but we still use the old default.
export HELM_DRIVER=configmap

# Go 1.16+ sets GO111MODULE to off by default with the intention to
# remove it in Go 1.18, which breaks projects using the dep tool.
# https://blog.golang.org/go116-module-changes
export GO111MODULE=auto
export GOPRIVATE=github.com/DataDog
export GOPROXY=binaries.ddbuild.io,https://proxy.golang.org,direct
export GONOSUMDB=github.com/DataDog,go.ddbuild.io

# Configure Go to pull go.ddbuild.io packages.
export GOPROXY="binaries.ddbuild.io,proxy.golang.org,direct"
export GONOSUMDB="github.com/DataDog,go.ddbuild.io"
# END ANSIBLE MANAGED BLOCK

# Set SSH_AUTH_SOCK to the launchd-managed ssh-agent socket (com.openssh.ssh-agent).
export SSH_AUTH_SOCK=$(launchctl asuser $(id -u) launchctl getenv SSH_AUTH_SOCK)

# Load SSH keys from the keychain if keychain is empty.
ssh-add -l > /dev/null || ssh-add --apple-load-keychain 2> /dev/null

# Load commit signing SSH Key if not in the agent already
ssh-add -l | grep "+git-commit-signing@datadoghq.com" > /dev/null || ssh-add --apple-use-keychain ~/.ssh/datadog_git_commit_signing 2> /dev/null

# The next line updates PATH for the Google Cloud SDK.
#if [ -f '/Users/nicolas.schweitzer/Public/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/nicolas.schweitzer/Public/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
#if [ -f '/Users/nicolas.schweitzer/Public/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/nicolas.schweitzer/Public/google-cloud-sdk/completion.zsh.inc'; fi

# vault
export VAULT_ADDR=https://vault.us1.ddbuild.io

# ------------ Perso ------------
export PATH=~/workspaces/tests/bin:$PATH
export PATH=/Users/nicolas.schweitzer/.cargo/bin:$PATH
#export PYTHONPATH=~/workspaces/ddog/ddqa/src/:$PYTHONPATH
source methods.sh
export LSCOLORS="ExfxcxdxBxegecabagacad"
export GREP_OPTIONS='--color=auto'
export CLICOLOR=1
alias ls='lsd -G --color=auto'
alias lt='lsd -lrth'
alias ll='lsd -alF'
alias la='lsd -A'
alias l='lsd -CF'
alias o=less
alias k=kubectl
alias b='source ~/.zshrc'
alias gitm="git s -s | cut -d' ' -f3"
alias g="git"
alias gg="git"
alias ggit="git"
alias gta=". gt"
alias space='sudo du -sh *'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias methods="nvim ~/workspaces/tests/bin/methods.sh"
alias bastion='ssh -A -i ~/.ssh/id_rsa_qa datadog@bastion.datadogqalab.com'
alias dlogin='aws-vault exec sso-build-stable-developer -- aws ecr --region us-east-1 get-login-password | docker login --username AWS --password-stdin 486234852809.dkr.ecr.us-east-1.amazonaws.com'
alias vlogin='vault login -method=oidc'
alias v='nvim'
alias cr='codex review --base $(git default)'
alias jeanclaude='claude --allow-dangerously-skip-permissions --dangerously-skip-permissions'

export HISTIGNORE="&:ls:lt:ll:la:b:exit"
#source ~/.git-completion.bash
fpath=(~/.zsh $fpath)
autoload -Uz compinit && compinit

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PULUMI_CONFIG_PASSPHRASE=i-love-testing-my-application
source ~/workspaces/tests/bin/inv_completion
export LANG=en_GB.UTF-8
# IFS management for ddtool/ddr
export DDTOOL_TLS_PROBE_SLOW=true
# -- Tools -- #
#[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && source /opt/homebrew/etc/profile.d/autojump.sh
#[[ -s /opt/homebrew/etc/autojump.sh ]] && source brew --prefix/etc/autojump.sh
source <(fzf --zsh)
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"

# pnpm
export PNPM_HOME="/Users/nicolas.schweitzer/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Created by `pipx` on 2025-09-15 09:46:49
export PATH="$PATH:/Users/nicolas.schweitzer/.local/bin"

# BEGIN SCFW MANAGED BLOCK
alias npm="scfw run npm"
alias pip="scfw run pip"
alias poetry="scfw run poetry"
export SCFW_DD_AGENT_LOG_PORT="10365"
export SCFW_DD_LOG_LEVEL="ALLOW"
export SCFW_HOME="/Users/nicolas.schweitzer/.scfw"
# END SCFW MANAGED BLOCK
#zprof

# peon-ping quick controls
alias peon="bash /Users/nicolas.schweitzer/.claude/hooks/peon-ping/peon.sh"
[ -f /Users/nicolas.schweitzer/.claude/hooks/peon-ping/completions.bash ] && source /Users/nicolas.schweitzer/.claude/hooks/peon-ping/completions.bash
