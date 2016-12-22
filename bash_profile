# Bash prompt variables
_time="\[\e[1;34m\][\[\e[0;32m\]\@\[\e[1;34m\]]"
_user="[\e[0;34m\]\u\[\e[1;34m\]]"	
_dir="[\[\e[0;32m\]\w\[\e[1;34m\]]"
_info="\[\e[1;32m\]\$(ls -1 | wc -l | sed 's: ::g') files, \$(du -hs)\[\e[1;34m\]"
_history="[\[\e[0;33m\]\!\[\e[1;34m\]]"
_git_branch="\[\e[1;34m\][\[\e[0;32m\]\$(gitbranch.sh)\[\e[1;34m\]]"

# Bash prompts
Old_PS1="\[\033[32m\]\u:\[\033[31;1m\]\w\[\033[m\]\$ "
OPS1="\n$_time-$_dir\[\e[1;34m\]\n$_history\[\e[0;34m\] -> \[\e[0;32m\]"
GPS1="\n$_time-$_git_branch-$_dir\[\e[1;34m\]\n$_history\[\e[0;34m\] -> \[\e[0;32m\]"
IPS1="\n$_time-$_info-$_dir\[\e[1;34m\]\n$_history\[\e[0;34m\] -> \[\e[0;32m\]"

# Default
PS1=$GPS1

export CLICOLOR=1
LS_COLORS='di=0;35'
export LS_COLORS

# C-x C-e to open vim and edit a command there
EDITOR="vim"

# Shortcuts
export vimrc="$HOME/.dot_files/vim/vimrc"
export tmux="$HOME/.dot_files/tmux/tmux.conf"

# Aliases go here: 
alias ls='ls -GFh'
alias ll='ls -la'

alias pi3="ssh pi@raspberrypi.local"
alias godaddy="ssh thesquid17@107.180.41.49"
# Python aliases
alias 3='python3'
alias 2='python'

# tmux
alias tmux="tmux -2"
alias tls="tmux ls"
alias ta="tmux attach"
TERM=xterm-256color

# Scripts that need to run in current shell 
alias idea='. idea'
alias prompt='. prompt'
alias dt='. dt'

alias pi="ssh pi@100.64.1.173"

# sql server
alias sql='sudo /usr/local/mysql/bin/mysql -u root'

alias sudi='ssh sidneyw@torsion.cs.dartmouth.edu'

# code helpers
# alias server="python -m SimpleHTTPServer"
alias mygcc="gcc -Wall -pedantic -std=c11"

# open vim with all my todos in splits
alias todo="vim $gtd/daily.txt $gtd/weekly.txt $gtd/monthly.txt -O -c \"windo exe 'normal zR'\""

# other
alias c="clear"
alias makec="make clean; make -j"

# autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
	# Ubuntu
	# . /usr/share/autojump/autojump.sh

# Bash Completion
 if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

PATH=$PATH:~/bin

# SQL
PATH=$PATH:/usr/local/mysql/bin

# Setting PATH for Python 2.7
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"

# Setting PATH for Python 3.4
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"

PATH="/usr/local/bin:${PATH}"

# Yarn path
PATH="$PATH:`yarn global bin`"

# Ubuntu
# Swap escape and caps lock
# /usr/bin/setxkbmap -option "caps:swapescape"

# added by travis gem
[ -f /Users/sidneywijngaarde/.travis/travis.sh ] && source /Users/sidneywijngaarde/.travis/travis.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/sidneywijngaarde/Desktop/google-cloud-sdk/path.bash.inc ]; then
  source '/Users/sidneywijngaarde/Desktop/google-cloud-sdk/path.bash.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /Users/sidneywijngaarde/Desktop/google-cloud-sdk/completion.bash.inc ]; then
  source '/Users/sidneywijngaarde/Desktop/google-cloud-sdk/completion.bash.inc'
fi

# Go installs packages here
export GOPATH="/Users/sidneywijngaarde/go/"

# added by Anaconda3 4.2.0 installer
export PATH="/Users/sidneywijngaarde/anaconda3/bin:$PATH"
