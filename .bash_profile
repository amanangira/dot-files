source "/Users/amanangira/.bashrc"
alias php="/usr/local/php5-7.1.31-20190811-210816/bin/php"
#export BASH_SILENCE_DEPRECATION_WARNING=1
if [ -f "/Users/amanangira/.config/fabric/fabric-bootstrap.inc" ]; then . "/Users/amanangira/.config/fabric/fabric-bootstrap.inc"; fi
. "$HOME/.atuin/bin/env"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
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
