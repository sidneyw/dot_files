# for bash prompt
_time="\[\e[1;34m\][\[\e[0;32m\]\@\[\e[1;34m\]]"
_user="[\e[0;34m\]\u\[\e[1;34m\]]"	
_dir="[\[\e[0;32m\]\w\[\e[1;34m\]]"
_info="\[\e[1;32m\]\$(ls -1 | wc -l | sed 's: ::g') files, \$(du -hs)\[\e[1;34m\]"
_history="[\[\e[0;33m\]\!\[\e[1;34m\]]"
_git_branch="\[\e[1;34m\][\[\e[0;32m\]\$(gitbranch.sh)\[\e[1;34m\]]"

Old_PS1="\[\033[32m\]\u:\[\033[31;1m\]\w\[\033[m\]\$ "
OPS1="\n$_time-$_dir\[\e[1;34m\]\n$_history\[\e[0;34m\] -> \[\e[0;32m\]"
GPS1="\n$_time-$_git_branch-$_dir\[\e[1;34m\]\n$_history\[\e[0;34m\] -> \[\e[0;32m\]"
IPS1="\n$_time-$_info-$_dir\[\e[1;34m\]\n$_history\[\e[0;34m\] -> \[\e[0;32m\]"

PS1=$OPS1

export CLICOLOR=1
LS_COLORS='di=0;35'
export LS_COLORS


# Aliases go here: 
alias ls='ls -GFh'
alias ll='ls -la'

# python
alias 3='python3'
alias 2='python'

# tmux
alias tmux="tmux -2"
alias ta="tmux attach"
TERM=xterm-256color

# scripts that need to run in current shell alias dt='. dt' alias class='. class'
alias idea='. idea'
alias prompt='. prompt'

# sql server
alias sql='sudo /usr/local/mysql/bin/mysql -u root'

alias sudi='ssh sidneyw@torsion.cs.dartmouth.edu'

# code helpers
alias server="python -m SimpleHTTPServer 9000"
alias mygcc="gcc -Wall -pedantic -std=c11"

# open vim with all my todos in splits
alias todo="vim ~/Desktop/todo.txt"

# other
alias c="clear"
alias makec="make clean; make"

# autojump
. /usr/share/autojump/autojump.sh

PATH=$PATH:~/bin

# SQL
PATH=$PATH:/usr/local/mysql/bin

# Setting PATH for Python 2.7
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"

# Setting PATH for Python 3.4
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"

PATH="/usr/local/bin:${PATH}"

# For adb
PATH="$HOME/android-sdk-linux/platform-tools:${PATH}"

PATH="$HOME/.ovid/current:${PATH}"
PATH="$HOME/dev/stuff:${PATH}"
export PATH

export USE_CCACHE=1
export CCACHE_DIR=$HOME/android-sdk-linux/cache

# Swap escape and caps lock
/usr/bin/setxkbmap -option "caps:swapescape"
