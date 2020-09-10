#
# ~/.bashrc
#

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


#PATHS
export PATH="/usr/local/sbin:$PATH"
export GOPATH="$HOME/Playground/go"
go env -w GOPATH=$GOPATH
#export GOROOT="/usr/local/opt/go/libexec"
#export PATH=$PATH:$GOPATH/bin
#export PATH=$PATH:$GOROOT/bin
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

#ENVIRONMENT VARIABLES
source /usr/local/var/www/1800-docker-repos/ops/api_dev_env/include.sh #1800 project variables
export PATH="/usr/local/opt/node@10/bin:$PATH"
export PATH="/usr/local/opt/redis@4.0/bin:$PATH"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
 
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\] $(parse_git_branch)\[\033[00m\]\$ '

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
