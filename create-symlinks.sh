#!/bin/zsh

set -e

# Check for dry-run mode (default to 0)
DRY_RUN=0

if [ "$#" -gt 1 ]; then
    echo "Invalid number of arguments. Usage: $0 [--dry-run]"
    exit 1
fi

if [[ $1 == "--dry-run" ]]; then
    DRY_RUN=1
elif [[ ! -z $1 ]]; then
    echo "Unknown argument: $1. Usage: $0 [--dry-run]"
    exit 1
fi

# Creates symlinks for dotfiles
DOT_FILES="$HOME/.dot_files"
#
# List of filenames to be ignored.
declare -a IGNORED_FILES=("README.md")

# Array of directories to exclude from the symlink process
EXCLUDED_DIRS=("config", "cheatsheets", "phoenix", "iterm")

# A map of specific symlinks to be made
declare -A SYMLINK_MAP
SYMLINK_MAP[config/phoenix/out/phoenix.js]=$HOME/.phoenix.js
SYMLINK_MAP[shell/bin]=$HOME/bin
SYMLINK_MAP[shell/local_bin]=$HOME/local_bin


echo "Dot files folder: $DOT_FILES"

# Check if .config directory exists in home folder, if not create it
if [[ ! -d "$HOME/.config" && $DRY_RUN -eq 0 ]]; then
    mkdir -p "$HOME/.config"
fi
    
cd $DOT_FILES

echo "Generating dotfiles symlinks"

# Loop through each item under DOT_FILES directory
for item in *; do
    if [[ -d $item && ! "${EXCLUDED_DIRS[@]}" =~ "$item" ]]; then
        # Loop through nested files
        for file in $item/*; do
            if [[ -f $file ]]; then
                file_name=$(basename "$file")
                
                # Initialize should_ignore to false
                should_ignore=0
                # Check if the file_name exists in the list of ignored files
                for ignored_file in "${IGNORED_FILES[@]}"; do
                    if [[ $file_name == "$ignored_file" ]]; then
                        # Set should_ignore to true and break the loop
                        should_ignore=1
                        break
                    fi
                done
                
                # If file should_ignore equals to 1, skip current iteration
                if [[ $should_ignore -eq 1 ]]; then
                    continue
                fi
                # In dry-run mode, don't actually create the symlink, just log.
                if [[ $DRY_RUN -eq 0 ]]; then
                    echo "Removing existing symlink (if present): $HOME/.$file_name"
                    rm -rf "$HOME/.$file_name"
                    echo "Creating symlink: $HOME/.$file_name -> $DOT_FILES/$item/$file_name"
                    ln -s "$DOT_FILES/$item/$file_name" "$HOME/.$file_name"
                else
                    echo "DRY RUN: Would have created symlink: $HOME/.$file_name -> $DOT_FILES/$item/$file_name"
                fi
            fi
        done
    fi
done

cd $DOT_FILES/config

echo "Generating config symlinks"
for subdir in *; do
    if [[ -d $subdir ]]; then
        # In dry-run mode, don't actually create the symlink, just log.
        if [[ $DRY_RUN -eq 0 ]]; then
            echo "Removing existing symlink (if present): $HOME/.config/$subdir"
            rm -rf $HOME/.config/$subdir

            echo "Creating symlink: $HOME/.config/$subdir -> $DOT_FILES/config/$subdir"
            ln -s $DOT_FILES/config/$subdir $HOME/.config/$subdir 
        else
            echo "DRY RUN: Would have removed existing symlink (if present): $HOME/.config/$subdir"
            echo "DRY RUN: Would have created symlink: $HOME/.config/$subdir -> $DOT_FILES/config/$subdir"
        fi
    fi
done

echo "Generating specific symlinks"
# Manage specific symlinks from the SYMLINK_MAP
for key in ${(k)SYMLINK_MAP}; do
    if [[ $DRY_RUN -eq 0 ]]; then
        echo "Removing existing symlink (if present): ${SYMLINK_MAP[$key]}"
        rm -rf "${SYMLINK_MAP[$key]}"

        echo "Creating symlink: ${SYMLINK_MAP[$key]} -> $DOT_FILES/$key"
        ln -s "$DOT_FILES/$key" "${SYMLINK_MAP[$key]}"
    else
        echo "DRY RUN: Would have removed existing symlink (if present): ${SYMLINK_MAP[$key]}"
        echo "DRY RUN: Would have created symlink: ${SYMLINK_MAP[$key]} -> $DOT_FILES/$key"
    fi
done
