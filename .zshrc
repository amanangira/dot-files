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

#1800 project variables
source /usr/local/var/www/1800-docker-repos/ops/api_dev_env/include.sh 
export PROJECT_DIR=/usr/local/var/www/1800-docker-repos #1800 project variables
export GOPATH="$HOME/Playground/go"
go env -w GOPATH=$GOPATH

#ALIAS
#alias php='/usr/bin/php72'
alias la='ls -laFH' #Human readable list all
alias rmq:start="rabbitmq-server -detached"
alias rmq:stop="rabbitmqctl shutdown"
alias rmq:status="rabbitmqctl status"
alias cd:api="cd /usr/local/var/www/1800-docker-repos/api && pwd"
alias cd:ops="cd /usr/local/var/www/1800-docker-repos/ops && pwd"
alias cd:docker="cd /usr/local/var/www/1800-docker-repos"
alias cache:clear:dev="php -dmemory_limit=4G app/console cache:clear --env dev" 
alias cache:clear:prod="php -dmemory_limit=4G app/console cache:clear --env prod"
alias update:params="composer run-script symfony-scripts"
alias api:dev:init="cp /usr/local/var/www/1800-docker-repos/api/web/app_dev.php /usr/local/var/www/1800-docker-repos/api/web/app.php && /usr/local/bin/composer/composer.phar run-script symfony-scripts && echo 'Copied app_dev.php to app.php. Now, rebuilding the cache for dev.' && cache:clear:dev"
alias docker:mongodb="docker exec -it mongodb mongo client_portal_t"
alias docker:api="docker exec -it api bash"
alias docker:postgresql="docker exec -it postgresql psql -U 1800_user client-portal"
alias edocker='_edocker'
alias restart:php='brew services restart php72'
alias docker:restart='docker-compose down && docker-compose up -d'
alias run-on-all='run-on-all'
alias start-brew-services='run-on-all "brew services start replace" "$BREW_SERVICES"'
alias stop-brew-services='run-on-all "brew services stop replace" "$BREW_SERVICES"'
alias ngrok="/Users/amanangira/Downloads/Workspaces/ngrok/ngrok"
alias update:params="composer run-script symfony-scripts"
alias git:checkout="gitEnhancedCheckout"
alias phpspec:run="runPhpSpec"
alias git:tag:push="gitTagAndPush"
alias curl:portal:config="curl http://1800accountant/cbapi/app.php/config"
alias load:dev:apps="loadDevApps"
alias npm:build:dist="npm start -- --env"
alias vim="nvim"
alias vvim="vim"
alias cd:go="cd $GOPATH/src"
alias php="/usr/local/php5-7.1.31-20190811-210816/bin/php"
alias myip='curl ifconfig.me'

## Sensitive Aliases
source /Users/amanangira/dot-files/sensitive.zsh

#FUNCTION
function _edocker()
{
if [ -z "$1" ]; then
        if [ -z "$2" ]; then
            if [ -z "$3" ]; then
                docker exec -it "$1 $2 $3";
            else
                echo "docker exec -it $1 $2";
            fi
        else
            docker exec -it "$1";
        fi
    else
        echo "At least one arguement required, none given.";
    fi 
}

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

function runPhpSpec()
{
    #echo "php -dmemory_limit=5G bin/phpspec run $1"
    $(php -dmemory_limit=4G bin/phpspec run $1)
}

function gitTagAndPush()
{
    utc=$(date -u +"%H%M")
    date=$(date +%Y%m%d)
    if [ $# -eq 0 ]
        then
            finalTag="$date$utc"
        else
            finalTag="$1_$date$utc"
    fi

    #Get current branch name
    branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p') 
    vared -p 'Confirm tagging and pushing of branch '$branch' with tag '$finalTag' (y/n)?' -c RESP
    RESP="$(echo "$RESP" | tr '[:upper:]' '[:lower:]')"
    if [ "$RESP" = "y" ]; then
        #echo "git checkout $BRANCH"
        $(git tag $finalTag)
        $(git push origin $finalTag)
        echo "$finalTag was pushed to remote."
    fi

}

function loadDevApps()
{
    open -a "google chrome" "https://technine.atlassian.net/secure/Dashboard.jspa"
    open -a "visual studio code" 
    open -a "docker"
    open -a "NoSQLBooster for MongoDB"
    open -a "slack"
}

function parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setting fd as the default source for fzf - respect gitignore
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

