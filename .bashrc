# ~/.bashrc

#TERMINAL CONFIGURATIONS
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ " #terminal theme
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export TERM=xterm-256color #TERMINAL TYPE
#Powerline
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH=$PATH:$HOME/Library/Python/2.7/bin
export XDG_CONFIG_DIRS="$HOME/.config"
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /Users/amanangira/Library/Python/2.7/lib/python/site-packages/powerline/bindings/bash/powerline.sh

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'

#PATHS
export PATH="/usr/local/sbin:$PATH"
export GOPATH="$HOME/Playground/go"
go env -w GOPATH=$GOPATH
export PATH="/usr/local/opt/node@10/bin:$PATH"
export PATH="/usr/local/opt/redis@4.0/bin:$PATH"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

#1800 project variables
source /usr/local/var/www/1800-docker-repos/ops/api_dev_env/include.sh 
export PROJECT_DIR=/usr/local/var/www/1800-docker-repos #1800 project variables

#ALIAS
#alias php='/usr/bin/php72'
alias ll='ls -laFH' #Human readable ls
alias rmq:start="rabbitmq-server -detached"
alias rmq:stop="rabbitmqctl shutdown"
alias rmq:status="rabbitmqctl status"
alias cd:api="cd /usr/local/var/www/1800-docker-repos/api"
alias cd:docker="cd /usr/local/var/www/1800-docker-repos"
alias cache:clear:dev="php -dmemory_limit=4G app/console cache:clear --env dev" 
alias cache:clear:prod="php -dmemory_limit=4G app/console cache:clear --env prod"
alias update:params="composer run-script symfony-scripts"
alias api:dev:init="composer install && cp /usr/local/var/www/1800-docker-repos/api/web/app_dev.php /usr/local/var/www/1800-docker-repos/api/web/app.php && composer run-script symfony-scripts && echo 'Copied app_dev.php to app.php. Now, rebuilding the cache for dev.' && cache:clear:dev"
alias docker:mongodb="docker exec -it mongodb mongo client_portal_t"
alias docker:api="docker exec -it api bash"
alias edocker='_edocker'
alias restart:php='brew services restart php72'
alias docker:restart='docker-compose down && docker-compose up -d'
alias cd:go="cd $GOPATH/src"
#ALIAS SSH
alias ssh:bi-etl='ssh aangira@3.80.9.251'
alias ssh:uat='ssh aangira@3.229.176.89'
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

alias ssh:uat='ssh -i ~/.ssh/1800accountant/ops.pem ubuntu@uat.1800accountant.com'
alias ssh:qa1='ssh -i ~/.ssh/1800accountant/ops.pem ubuntu@qa1-a.1800accountant.com'
alias ssh:qa2='ssh -i ~/.ssh/1800accountant/ops.pem ubuntu@qa2-a.1800accountant.com'
alias brightness='xrandr --output HDMI1 --brightness $1'

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
    read -p "Confirm checkout to branch $BRANCH (y/n)?" RESP
    RESP="$(echo "$RESP" | tr '[:upper:]' '[:lower:]')"
    if [ "$RESP" == "y" ]; then
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
    read -p "Confirm tagging and pushing of branch '$branch' with tag '$finalTag' (y/n)?" RESP
    RESP="$(echo "$RESP" | tr '[:upper:]' '[:lower:]')"
    if [ "$RESP" == "y" ]; then
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
 
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\] $(parse_git_branch)\[\033[00m\]\$ '

