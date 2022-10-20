#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
mkcd ()
{
    mkdir -p -- "$1" &&
       cd -P -- "$1"
}

alias ls='ls --color=auto'
alias haps='xclip -selection clipboard'
alias nv='nvim'
export PATH="${PATH}:/home/jakupl/.local/bin/"
source ~/.pass.bash-completion
PS1='[\u@\h \W]\$ '

