# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
# export ZSH="/Users/albert/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# CASE INSENSITIVE COMPLETION
# FROM: https://stackoverflow.com/a/69014927/182888
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit

# FROM: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html
autoload bashcompinit && bashcompinit
complete -C '/usr/bin/aws_completer' aws


# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
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

# Enabled on 18 Nov 2022 again on Linux to see if I get more out of zsh completion....)
# plugins=(git zsh-autosuggestions)

# source $ZSH/oh-my-zsh.sh

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
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# export EDITOR="/usr/local/bin/nvim"
export EDITOR="/usr/bin/nvim"
export VISUAL=$EDITOR
export PATH="/home/albert/.ebcli-virtual-env/executables:$PATH"


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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
# fi
if [[ $TERM_PROGRAM != "Apple_Terminal" ]]; then
	if command -v oh-my-posh &> /dev/null
	then
		eval "$(oh-my-posh init zsh --config ~/.omp/themes/tokyonight.omp.yaml)"
	fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# alias ls='ls -lkh --color=auto' # THIS WAS PREVENTING ME FROM GETTING A LISTING WITH JUST THE FILENAMES!

# color always so that if we pipe to grep, it will be colored
alias ls='ls --color=auto' # TRY THIS AGAIN FOR NOW TO SEE IF IT WORKS, SINCE IT SHOULD SORT OUT WHEN PIPING TO ANOTHER COMMAND...
# alias ls='ls --color=always' # THIS GIVES DRAMA SINCE THE COLOR CODES ARE PART OF THE RESULTS WHEN PIPING TO ANOTHER COMMAND...
alias ll="ls -alkhF"
alias l="ls -1"
alias tmux='tmux -2'
alias grep='grep --color=always'

alias db='dotnet build'

alias gs='git status'
alias gf='git fetch'
alias gl='git pull'
alias gp='git push'
alias gpt='git push --tags'
alias gP='git push --force-with-lease'
alias ga='git add'
alias gcam='git commit -am'
alias gd='git diff'
alias gw='git diff --word-diff'
setopt interactive_comments
preexec(){ _lc=$1; }
alias gcm='git commit -m "${_lc#gcm }" #'
alias glog='git logo'
alias gdog='git dog'
alias gadog='git adog'
alias gb='git branch'
alias gba='git branch --all'
alias gco='git checkout'
alias gm='git merge'
alias gt='git tag | sort -V | tail'

alias rl='source ~/.zshrc'

# alias nvim-lua='export XDG_CONFIG_HOME=${HOME}/.dotfiles/nvim-lua/.config; \
# 	export XDG_DATA_HOME=${HOME}/.local-lua/share; \
# 	nvim'

alias n='nvim'
alias ss-tulpn='ss -tulpn'

atail() { tail -f ---disable-inotify "$@"; }
alias atail-t='tail -f -n +1 ---disable-inotify $(ls -t | head -1)'

# find files matching the name, then sort them by last modified
fd-t() {
	fd -t f $1 --exec stat --printf='%Y\t%n\n' | sort -nr
}

# # find files matching the glob, then sort them by last modified
# fd-tg() {
# 	fd -t f -g $1 --exec stat --printf='%Y\t%n\n' | sort -nr
# }

alias nvim-t="fd-t | cut -f 2 | head -1 | xargs -d '\n' nvim"

# LIST PATHS OF OTHER ZSH SHELLS I HAVE OPEN
lssh() {
	ps au \
		| awk '$11 == "-zsh" || $11 == "/bin/zsh" { print $2 }' \
		| xargs pwdx \
		| awk '{ print $2 }' \
		| sed -n "\|^${2}.*|p" \
		| sort -u \
		| nl
}

# CD TO SHELL NUMBER RETURNED BY LSSH
cdsh() {
	cd $(lssh \
		| sed "$1!d" \
		| cut -f 2)
}

# CD TO PATH OF ANOTHER SHELL, USING FZF AS SELECTOR
cs() {
	# I swear this worked before, but not anymore, it just returns a blank cmd
	# cmd=$(cd $(lssh | fzf --select-1 --query "$1" --height=~50 | cut -f 2))
	cmd1=$(lssh | fzf --select-1 --query "$1" --height=~50 | cut -f 2)
	cmd="cd $cmd1"
	print -S $cmd
	eval $cmd
}

# RUN THE COMMAND FROM HISTORY, USING FZF AS SELECTOR
hf() {
	cmd=$(history 0 | sort -nr | cut -c 8- | fzf -e --select-1 --no-sort --query "$1" )
	# push the command into the history
	print -S $cmd
	eval $cmd
}

# REMMINA USING THE CONNECTION FILE SELECTED USING FZF
rf() {
	pushd ~/.local/share/remmina
	cmd=$(remmina -c $(ls $PWD/* | fzf -e --select-1 --no-sort --query "$1"))
	# push the command into the history
	print -S $cmd
	eval $cmd
	popd
}

# alias hf='history 0 | cut -c 8- | fzf -e'

alias df='df -h'

#set -o vi
# bind '"jk":vi-movement-mode'
#set bell-style none
#$if mode=vi
#    set keymap vi-command
#    "gg": beginning-of-history
#    "G": end-of-history
#    set keymap vi-insert       #notice how the "jj" movement is
#    "jk": vi-movement-mode     #after 'set keymap vi-insert'?
#    "\C-w": backward-kill-word
#    "\C-p": history-search-backward
#$endif
#bindkey -e jk \\e
#bindkey '"jk":vi-movement-mode'
bindkey -v
bindkey 'jk' vi-cmd-mode
bindkey '^R' history-incremental-search-backward

# SORT OUT ISSUE WITH HOME AND END KEYS, FROM: https://stackoverflow.com/a/58842892/182888
bindkey "\E[H" beginning-of-line
bindkey "\E[F" end-of-line
bindkey "\E[3~" delete-char

eval "$(zoxide init zsh)"

setopt GLOB_COMPLETE

# Zsh vi mode
# FROM: https://github.com/jeffreytse/zsh-vi-mode
if [ ! -d "$HOME/.zsh-vi-mode" ] 
then
	echo "Cloning zsh-vi-mode"
	git clone https://github.com/jeffreytse/zsh-vi-mode $HOME/.zsh-vi-mode
fi

ZVM_VI_ESCAPE_BINDKEY="jk"
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT # ZVM_MODE_NORMAL, ZVM_MODE_INSERT, ZVM_MODE_LAST
source $HOME/.zsh-vi-mode/zsh-vi-mode.plugin.zsh

########################################
# FROM: /usr/share/zsh/manjaro-zsh-config
########################################
setopt correct                                                  # Auto correct mistakes
setopt nocaseglob                                               # Case insensitive globbing
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits.

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace

# Offer to install missing package if command is not found
if [[ -r /usr/share/zsh/functions/command-not-found.zsh ]]; then
		source /usr/share/zsh/functions/command-not-found.zsh
		export PKGFILE_PROMPT_INSTALL_MISSING=1
fi
########################################


########################################
# FROM: /usr/share/zsh/manjaro-zsh-prompt
########################################
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

########################################

bindkey '^j' autosuggest-accept
