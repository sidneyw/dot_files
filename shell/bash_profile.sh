# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/bash_profile.pre.bash" ]] && builtin source "$HOME/.fig/shell/bash_profile.pre.bash"
#!/bin/bash

# vim: set foldmethod=marker :

# Prompts and colors {{{
# ====================================
RED='\[\033[00;31m\]'
GREEN='\[\033[00;32m\]'
YELLOW='\[\033[00;33m\]'
BLUE='\[\033[00;34m\]'
PURPLE='\[\033[00;35m\]'
CYAN='\[\033[00;36m\]'
LIGHTGRAY='\[\033[00;37m\]'

LRED='\[\033[01;31m\]'
LGREEN='\[\033[01;32m\]'
LYELLOW='\[\033[01;33m\]'
LBLUE='\[\033[01;34m\]'
LPURPLE='\[\033[01;35m\]'
LCYAN='\[\033[01;36m\]'
WHITE='\[\033[01;37m\]'

isGitRepo() {
  git rev-parse HEAD > /dev/null 2>&1
}

currentPyEnv() {
	if command -v pyenv 1>/dev/null 2>&1; then
		echo "$(pyenv version-name)"
	fi
}

k8sPrompt(){
  success=$?

  PS1="\n${BLUE}\u"
	PS1="${PS1} ${YELLOW} ${GREEN}\w"

  isGitRepo
  if [[ $? == 0 ]]
  then
    branch=$(git branch 2> /dev/null | grep "\*" | cut -d " " -f2)
    PS1="${PS1}${YELLOW}  ${BLUE}${branch}"
  fi

	PS1="${PS1}${YELLOW} ﴱ${GREEN} $(kubens -c)"

  PS1="${PS1}\n${YELLOW} \@"
  if [ $success -ne 0 ]; then
    PS1="${PS1} ${RED}${YELLOW}"
  fi

# »
  PS1="${PS1} ${YELLOW} \!"
	if [[ ! -z "$(currentPyEnv)" ]]; then
		PS1="${PS1} ${YELLOW} ${GREEN}$(currentPyEnv)"
	fi

	PS1="${PS1} ${BLUE} ${GREEN}"
}

fullPrompt(){
  success=$?

  PS1="\n${BLUE}\u"
	PS1="${PS1} ${YELLOW} ${GREEN}\w"

  isGitRepo
  if [[ $? == 0 ]]
  then
    branch=$(git branch 2> /dev/null | grep "\*" | cut -d " " -f2)
    PS1="${PS1}${YELLOW}  ${BLUE}${branch}"
  fi

  PS1="${PS1}\n${YELLOW} \@"
  if [ $success -ne 0 ]; then
    PS1="${PS1} ${RED}${YELLOW}"
  fi

# »
  PS1="${PS1} ${YELLOW} \!"
	if [[ ! -z "$(currentPyEnv)" ]]; then
		PS1="${PS1} ${YELLOW} ${GREEN}$(currentPyEnv)"
	fi

	PS1="${PS1} ${BLUE} ${GREEN}"
}

minimalPrompt(){
  success=$?

  PS1="\n${YELLOW} ${GREEN}\W"

  isGitRepo
  if [[ $? == 0 ]]
  then
    branch=$(git branch 2> /dev/null | grep "\*" | cut -d " " -f2)
    PS1="${PS1}${YELLOW}  ${BLUE}${branch}"
  fi

  if [ $success -ne 0 ]; then
    PS1="${PS1} ${RED}${YELLOW}"
  fi

  PS1="${PS1}${YELLOW}  \!${BLUE} » ${GREEN}"
}

onelinerPrompt(){
  success=$?

  PS1="\n${YELLOW} ${GREEN}\w"

  isGitRepo
  if [[ $? == 0 ]]
  then
    branch=$(git branch 2> /dev/null | grep "\*" | cut -d " " -f2)
    PS1="${PS1}${YELLOW}  ${BLUE}${branch}"
  fi

  if [ $success -ne 0 ]; then
    PS1="${PS1} ${RED}${YELLOW}"
  fi

  PS1="${PS1}${YELLOW}  \!${BLUE} » ${GREEN}"
}

PROMPT_COMMAND=k8sPrompt

export CLICOLOR=1
export LS_COLORS='di=0;35'

gruvbox_colors="$HOME/.dot_files/nvim/plugged/gruvbox/gruvbox_256palette_osx.sh"
test -f "$gruvbox_colors" && source $gruvbox_colors
# }}}

# Global Variables {{{
# ====================================
export DOT_FILES="$HOME/.dot_files/"
export VIMRC="$DOT_FILES/nvim/init.lua"
export tmux="$DOT_FILES/tmux/tmux.conf"

export EDITOR='nvim'
export HISTSIZE=20000
export HISTFILESIZE=20000

# Gcloud SDK uses this variable to pick a python version
# export CLOUDSDK_PYTHON=python2.7
# }}}

# Aliases {{{
# ====================================
# <C-x> <C-e> to open vim and edit a command there
# Vim
alias v='nvim'
alias vim='nvim'
alias ebash='nvim ~/.bash_profile'
alias evim="cd $DOT_FILES; nvim $VIMRC; cd -"

# Tmux
alias tmux='tmux -2'
alias tls='tmux ls'
alias tks='tmux kill-session -t'
alias tkill='tmux kill-server'
alias ta='tmux attach'
# export TERM=xterm-256color
export TERM=screen-256color

# Bash
alias bp="source $HOME/.bash_profile"

# cd to top level git dir
alias gcd='cd $(git rev-parse --show-toplevel)'
alias genv='source genv'

# Kubernetes
alias kc='kubectl'
# alias kcp='kubectl get pods'
alias kca='kubectl apply -f'
alias kcc='kubectl create -f'
alias kcd='kubectl delete -f'
alias kcl="kubectl logs -f"
alias hi='helm-init'
alias watch='watch '

# Other
alias cat="bat"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

alias ls="exa -GFh"
alias ll='exa -lahF'
alias lt='exa --tree --level=2'
alias t="tree"

alias pi3='ssh pi@raspberrypi.local'

# Secure Helm
function shelm() {
  echo "helm $@ --tls"
  helm $@ --tls
}

# Docker
alias dps="docker ps"
alias dcomp='docker-compose'
alias dmongo='docker run -d -p 27017:27017 mongo'

function dexec() {
	docker exec -it $1 /bin/bash
}

function kexec() {
	kubectl exec --stdin --tty $1 -- /bin/sh
}

# JS
alias yn='yarn'
alias yns='yarn start'

alias npmr='npm run'
alias npmi='npm install'
alias npms='npm start'

# Python
alias 3='python3'

# other
alias c='clear'
# }}}

# Plugins {{{
# ====================================
# autojump
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# Bash Completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# NVM
 export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_COMMAND='rg --files'

# FZF search files to open in vim
function vf() {
  nvim "$@" $(fzf -m --preview "bat --style=numbers --color=always {} | head -500")
}

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "bat --style=numbers --color=always {} | head -500"'
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header 'Press CTRL-Y to copy command into clipboard' --border"
# Experimental
fzf-down() {
  fzf --height 50% "$@" --border
}

fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --height 40% --reverse --query="$1" --exit-0) &&
  tmux switch-client -t "$session"
}

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; bat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

co() {
	git checkout $(gb)
}

gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -200' |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -200'
}

gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -200' |
  grep -o "[a-f0-9]\{7,\}"
}

gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

# show files with diffs from master
gd() {
	is_in_git_repo || return
	git diff master --name-only |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff master --color=always -- {-1} | sed 1,4d; bat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

if [[ $- =~ i ]]; then
  bind '"\er": redraw-current-line'
  bind '"\C-g\C-f": "$(gf)\e\C-e\er"'
	bind '"\C-g\C-p": "$(gd)\e\C-e\er"'
  bind '"\C-g\C-b": "$(gb)\e\C-e\er"'
  bind '"\C-g\C-t": "$(gt)\e\C-e\er"'
  bind '"\C-g\C-h": "$(gh)\e\C-e\er"'
fi

# WIP
fyn() {
  jq -r '.scripts | keys[] as $k | "\($k) \(.[$k])"' package.json | fzf-down
}
# }}}

# Path {{{
# ====================================
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_VERSION=workspace
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PATH"
export PYENV_SHELL="bash"

# Pyenv
if command -v pyenv 1>/dev/null 2>&1; then
	# To enable shims and autocompletion
  eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
	export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi

PATH="$PATH:$HOME/bin"
PATH="$PATH:$HOME/local_bin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:$HOME/.local/bin"
PATH=/usr/local/opt/ruby/bin:$PATH

# Go installs packages here
export GOPATH="$HOME/go"
export GOBIN=$HOME/go/bin
export PATH=$PATH:$GOBIN
export PATH=$PATH:$GOROOT/bin
export GO111MODULE=on

# Yarn bin
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# }}}

export PATH="/opt/homebrew/bin:$PATH"

[[ -s "/Users/sidneyw/.gvm/scripts/gvm" ]] && source "/Users/sidneyw/.gvm/scripts/gvm"

alias luamake=/Users/sidneyw/tools/sumneko/lua-language-server/3rd/luamake/luamake
. "$HOME/.cargo/env"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sidney/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/sidney/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/sidney/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/sidney/Downloads/google-cloud-sdk/completion.bash.inc'; fi
PATH="/usr/local/bin:$PATH"
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

function pr() {
  github_url=`git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#https://#' -e 's@com:@com/@' -e 's%\.git$%%' | awk '/github/'`;
  branch_name=`git symbolic-ref HEAD | cut -d"/" -f 3,4`;
  pr_url=$github_url"/pull/new/"$branch_name
  open $pr_url;
}

export PATH="/opt/homebrew/opt/go@1.18/bin:$PATH"

# Local Config
local_conf="$HOME/.dot_files/shell/local_bin/local_conf.sh"
test -f "$local_conf" && source "$local_conf"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/bash_profile.post.bash" ]] && builtin source "$HOME/.fig/shell/bash_profile.post.bash"
