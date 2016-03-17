# for bash prompt
_time="\[\e[1;34m\][\[\e[0;32m\]\@\[\e[1;34m\]]"
_user="[\e[0;34m\]\u\[\e[1;34m\]]"	
_dir="[\[\e[0;32m\]\w\[\e[1;34m\]]"
_info="\[\e[1;32m\]\$(ls -1 | wc -l | sed 's: ::g') files, \$(du -hs)\[\e[1;34m\]"
_history="[\[\e[0;33m\]\!\[\e[1;34m\]]"

Old_PS1="\[\033[32m\]\u:\[\033[31;1m\]\w\[\033[m\]\$ "
PS1="\n$_time-$_user-$_dir\[\e[1;34m\]\n$_history\[\e[0;34m\] -> \[\e[0;32m\]"

export CLICOLOR=1
LS_COLORS='di=0;35'
export LS_COLORS


# Aliases go here: 
alias ls='ls -GFh'

# alias tmux="TERM=screen-256color-bce tmux"

# python
alias 3='python3'
alias 2='python'

# scripts that need to run in current shell
alias dt='. dt'
alias class='. class'
alias idea='. idea'
alias prompt='. prompt'

# sql server
alias sql='sudo /usr/local/mysql/bin/mysql -u root'

alias pi='ssh pi@192.168.1.61'
alias sudi='ssh sidneyw@torsion.cs.dartmouth.edu'
alias dalipi='ssh pi@129.170.212.157'

# code helpers
alias server="python -m SimpleHTTPServer"
alias server9="python -m SimpleHTTPServer 9000"
alias mygcc="gcc -Wall -pedantic -std=c11"
alias site="atom .;python -m SimpleHTTPServer" 

# Other
alias c="clear"
alias todo="vim ~/Desktop/todo.txt"
alias gtd="vim ~/Desktop/todo.txt"

# autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# Add user level bin to the PATH variable
export PATH=$PATH:~/bin

# SQL
export PATH=$PATH:/usr/local/mysql/bin

# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave

PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH

PATH="/usr/local/bin:${PATH}"
export PATH
