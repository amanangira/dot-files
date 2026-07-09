# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/amanangira/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

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
plugins=(git zsh-autosuggestions)

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

## Sensitive Aliases
source /Users/amanangira/dot-files/sensitive.zsh

## Source all files in alpabetical order
for file in ~/dot-files/functions/*.zsh(N); do
  source "$file"
done

#1800 project variables
#export GOPATH="$HOME/Playground/go"
export PATH=/Users/amanangira/Library/Python/3.8/bin/:$GOPATH/bin:$PATH
# See - https://docs.aws.amazon.com/sdk-for-go/api/aws/session/#NewSessionWithOptions
export AWS_SDK_LOAD_CONFIG=true
go env -w GOPATH="$HOME/go"

#ALIAS
#alias php='/usr/bin/php72'
alias la='ls -laFH' #Human readable list all
alias docker:restart='docker-compose down && docker-compose up -d'
alias run-on-all='run-on-all'
alias start-brew-services='run-on-all "brew services start replace" "$BREW_SERVICES"'
alias stop-brew-services='run-on-all "brew services stop replace" "$BREW_SERVICES"'
alias git:checkout="gitEnhancedCheckout"
alias vim="nvim"
alias vvim="vim"
#alias myip='curl ifconfig.me'
alias myip='curl -4 icanhazip.com'
alias kube:config:1800="ln -sf $DOT_FILES_PATH/secrets/.kube/1800-config  /Users/amanangira/.kube/config"
alias kube:config:minikube="ln -sf $DOT_FILES_PATH/secrets/.kube/minikube-config  /Users/amanangira/.kube/config"
alias mg="cd:hb && make generate"
alias md="cd:hb && make dependency"
alias awslocal="aws --endpoint-url=http://localhost:4566 --region eu-central-1"
#Project ALIASES
#alias vrestore ="cp /Users/amanangira/www/vPlaybookJsons/appsettings.Local.json.api /Users/amanangira/www/vPlaybook/vPlaybook.Api/appsettings.Local.json"

#CD ALIASES
alias cd:go="cd $GOPATH/src"
alias cd:www="cd /Users/amanangira/www"
alias cd:dot="cd $DOT_FILES_PATH"
alias cd:forge="cd /Users/amanangira/www/forge"
alias cd:sf="cd /Users/amanangira/www/forge/salesforge-api"
alias cd:mc="cd /Users/amanangira/www/forge/multichannel-api"
alias cd:fe="cd /Users/amanangira/www/forge/frontend-forge"
## TODO - Move to a function and pull profiles from .aws/credentials
alias aws:personal="export AWS_DEFAULT_PROFILE=personal"
alias redis:prod-sf="redis-cli -h salesforge-api-redis-prod.kcurhx.clustercfg.euc1.cache.amazonaws.com -p 6379"
alias redis:dev-mc="redis-cli -h clustercfg.multichannel-api-redis-dev.fd6mqf.euc1.cache.amazonaws.com -p 6379"
alias redis:dev-sf="redis-cli -h salesforge-api-redis-dev.fd6mqf.clustercfg.euc1.cache.amazonaws.com -p 6379"
#FUNCTION

function run-on-all(){
    for keyword in $2
    do
        #printf "$keyword\n"
        command="${1/replace/$keyword}"
        $command
        #printf "$command\n"
    done 
}

function gitEnhancedCheckout()
{
    #Find branch based on input string
    BRANCH="$(git branch --format='%(refname:short)'|grep $1)"

    #Ask for confirmation before checkout
    vared -p "Confirm checkout to branch $BRANCH (y/n)?" -c RESP
    RESP="$(echo "$RESP" | tr '[:upper:]' '[:lower:]')"
    if [ "$RESP" = "y" ]; then
        #echo "git checkout $BRANCH"
        $(git checkout $BRANCH)
    fi
}

function parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setting fd as the default source for fzf - respect gitignore
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# NVM Configuration - utility to manage multiple node versions
  export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
# [[ ! -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# # tabtab source for sls package
# # uninstall by removing these lines or running `tabtab uninstall sls`
# [[ ! -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
# # tabtab source for slss package
# # uninstall by removing these lines or running `tabtab uninstall slss`
# [[ ! -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh

# Created by `pipx` on 2024-06-25 07:56:17
export PATH="$PATH:/Users/amanangira/.local/bin"
if [ -f "/Users/amanangira/.config/fabric/fabric-bootstrap.inc" ]; then . "/Users/amanangira/.config/fabric/fabric-bootstrap.inc"; fi

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/bin/ngrok:$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# Vite+ bin (https://viteplus.dev)
. "$HOME/.vite-plus/env"
