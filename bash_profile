# Bash prompt variables
_time="\[\e[1;34m\][\[\e[0;32m\]\@\[\e[1;34m\]]"
_user="[\e[0;34m\]\u\[\e[1;34m\]]"
_dir="[\[\e[0;32m\]\w\[\e[1;34m\]]"
_info="\[\e[1;32m\]\$(ls -1 | wc -l | sed 's: ::g') files, \$(du -hs)\[\e[1;34m\]"
_history="[\[\e[0;33m\]\!\[\e[1;34m\]]"
_git_branch="\[\e[1;34m\][\[\e[0;32m\]\$(gitbranch.sh)\[\e[1;34m\]]"

# Bash prompts
Old_PS1="\[\033[32m\]\u:\[\033[31;1m\]\w\[\033[m\]\$ "
OPS1="\n$_time-$_dir\[\e[0;34m\]\n$_history\[\e[0;34m\] -> \[\e[0;32m\]"
GPS1="\n$_time-$_git_branch-$_dir\[\e[0;34m\]\n$_history\[\e[0;34m\] -> \[\e[0;32m\]"
IPS1="\n$_time-$_info-$_dir\[\e[0;34m\]\n$_history\[\e[0;34m\] -> \[\e[0;32m\]"

# Default
PS1=$GPS1

export CLICOLOR=1
LS_COLORS='di=0;35'
export LS_COLORS

# ==================================== {{{
# Aliases
# ====================================
# <C-x> <C-e> to open vim and edit a command there
EDITOR="nvim"
alias v='nvim'
alias vim="nvim"

# Shortcuts
export vimrc="$HOME/.dot_files/vim/vimrc"
export tmux="$HOME/.dot_files/tmux/tmux.conf"

# Aliases go here: 
alias ls='ls -GFh'
alias ll='ls -la'
alias gcd='cd $(git rev-parse --show-toplevel)'

alias pi3="ssh pi@raspberrypi.local"
alias pi="ssh pi@100.64.1.173"
alias godaddy="ssh thesquid17@107.180.41.49"
alias dali="ssh salvador@dolly.dali.dartmouth.edu"
alias sudi='ssh sidneyw@torsion.cs.dartmouth.edu'

alias yn='yarn'
alias npmr='npm run'
alias npmi='npm install'

# Python aliases
alias 3='python3'

# tmux
alias tmux="tmux -2"
alias tls="tmux ls"
alias tks="tmux kill-session -t"
alias tkill="tmux kill-server"
alias ta="tmux attach"
TERM=xterm-256color

# sql server
alias sql='sudo /usr/local/mysql/bin/mysql -u root'

alias mygcc="gcc -Wall -pedantic -std=c11"

# other
alias c="clear"
alias makec="make clean; make -j"
# }}}

# ====================================
# Plugins
# ====================================
# autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
	# Ubuntu
	# . /usr/share/autojump/autojump.sh

# Bash Completion
 if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

PATH="$PATH:$HOME/bin"
PATH="/usr/local/bin:${PATH}"

# Yarn path
# PATH="$PATH:`yarn global bin`"

# added by travis gem
[ -f /Users/sidneywijngaarde/.travis/travis.sh ] && source /Users/sidneywijngaarde/.travis/travis.sh

# Go installs packages here
export GOPATH="/Users/sidneywijngaarde/go/"

# added by Anaconda3 4.3.0 installer
export PATH="/Users/sidneywijngaarde/anaconda/bin:$PATH"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/sidneywijngaarde/.config/yarn/global/node_modules/tabtab/.completions/serverless.bash ] && . /Users/sidneywijngaarde/.config/yarn/global/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
