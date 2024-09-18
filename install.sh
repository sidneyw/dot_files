#!/bin/bash
set -x

# Quick install script for mac Clone the git repository if it doesn't exist locally
if [ ! -d "$HOME/.dot_files" ]; then
  git clone git@github.com:sidneyw/dot_files.git "$HOME/.dot_files"
  cd "$HOME/.dot_files"
fi

DOT_FILES="$HOME/.dot_files"

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Brew Packages from Brewfile
brew bundle --file="$DOT_FILES/Brewfile"
$(brew --prefix)/opt/fzf/install

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install Node
nvm install --lts
nvm use --lts

# Install Python via pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_VERSION=3.10.2
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

pyenv install 3
pyenv virtualenv 3 workspace
pyenv activate workspace

# Set up go mono repo
mkdir -p "$HOME/go"
mkdir -p "$HOME/go/bin"
mkdir -p "$HOME/go/pkg"
mkdir -p "$HOME/go/src"

# Install Vim Plugins
pip install pynvim

function prompt_continue() {
  while true; do
    read -p "Are you ready to continue? (yes/no) " yn
    yn=${yn,,} # Convert input to lowercase
    case $yn in
    yes | y | ye)
      break
      ;;
    no | n)
      echo "Exiting."
      exit 1
      ;;
    *)
      echo "Please answer (yes|y|no|n)"
      ;;
    esac
  done
}

function open_urls_with_confirmation() {
  for url in "$@"; do
    open "$url"
    while true; do
      read -r -p "Open next URL? (yes/no): " reply
      case "${reply,,}" in
      y | yes)
        break
        ;;
      n | no)
        echo "Stopping URL opening sequence."
        return
        ;;
      *)
        echo "Please type 'yes' or 'no'."
        ;;
      esac
    done
  done
}

# Manual Installs
open \
  https://arc.net/ \
  https://brave.com/

prompt_continue

open \
  https://1password.com/downloads/mac \
  https://www.spotify.com/de-en/download/mac/ \
  https://logseq.com/downloads \
  https://www.notion.so/download \
  https://www.notion.so/product/calendar/download

# App Store Links (to be opened one after another)
app_store_urls=(
  "https://apps.apple.com/us/app/spark-classic-email-app/id1176895641?mt=12"
  "https://apps.apple.com/us/app/ticktick-to-do-list-calendar/id966085870?mt=12"
  "https://apps.apple.com/us/app/copilot-track-budget-money/id1447330651"
)

# Open App Store URLs with confirmation
open_urls_with_confirmation "${app_store_urls[@]}"

# Fonts
open https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/SourceCodePro

prompt_continue

# Extensions
open https://chromewebstore.google.com/detail/raindropio/ldgfbffkinooeloadekpmfoklnobpien \
  https://chromewebstore.google.com/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb \
  https://chromewebstore.google.com/detail/ghostery-tracker-ad-block/mlomiejdfkolichcflejclcbmpeaniij \
  https://chromewebstore.google.com/detail/json-formatter/bcjindcccaagfpapjjmafapmmgkkhgoa \
  https://chromewebstore.google.com/detail/modheader-modify-http-hea/idgpnmonknjnojddfkpgkljpfnnfcklj \
  https://chromewebstore.google.com/detail/1password-%E2%80%93-password-mana/aeblfdkhhhdcdjpifhhbdiojplfjncoa \
  https://chromewebstore.google.com/detail/readwise-highlighter/jjhefcfhmnkfeepcpnilbbkaadhngkbi

prompt_continue

# Optional Experimental Stuff
open \
  https://apps.apple.com/us/app/spark-mail-ai-email-inbox/id6445813049?mt=12
