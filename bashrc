#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\u@\h \W \$ '
export PATH=$PATH:/home/neo/yasu/target/release

source /home/neo/.config/broot/launcher/bash/br
