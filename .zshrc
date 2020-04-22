# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

autoload -Uz compinit
compinit

# ----- PROMPT -----
## PROMPT
RPROMPT="%1(v|%F{green}%1v%f|)"
## RPROMPT
RPROMPT=$'`branch-status-check` %~'
setopt prompt_subst

setopt hist_ignore_dups
setopt EXTENDED_HISTORY

# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

autoload -U colors; colors
function branch-status-check {
    local prefix branchname suffix
        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
            return
        fi
        branchname=`get-branch-name`
        if [[ -z $branchname ]]; then
            return
        fi
        prefix=`get-branch-status`
        suffix='%{'${reset_color}'%}'
        echo ${prefix}${branchname}${suffix}
}
function get-branch-name {
    echo `git rev-parse --abbrev-ref HEAD 2> /dev/null`
}
function get-branch-status {
    local res color
        output=`git status --short 2> /dev/null`
        if [ -z "$output" ]; then
            res=':' # status Clean
            color='%{'${fg[green]}'%}'
        elif [[ $output =~ "[\n]?\?\? " ]]; then
            res='?:' # Untracked
            color='%{'${fg[yellow]}'%}'
        elif [[ $output =~ "[\n]? M " ]]; then
            res='M:' # Modified
            color='%{'${fg[red]}'%}'
        else
            res='A:' # Added to commit
            color='%{'${fg[cyan]}'%}'
        fi
        echo ${color} # 色だけ返す
}

alias ll='exa -la'
alias cat='bat'

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH=$PATH:/usr/local/bin

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

