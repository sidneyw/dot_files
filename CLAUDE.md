# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for macOS that manages development environment configurations. It uses symlinks to maintain consistent settings across different machines.

## Common Development Tasks

### Initial Setup

```bash
# Install all configurations and dependencies
make install

# Or run individual setup scripts:
./set-defaults.sh      # macOS system defaults
./create-symlinks.sh   # Create symlinks to home directory
./install.sh           # Additional installation steps
```

### Homebrew Management

```bash
# Update Brewfile with currently installed packages
make sync-brew
```


## Architecture and Structure

### Symlink System

The repository uses a symlink-based approach where configuration files are stored in `~/.dot_files` and symlinked to their expected locations:

- Root-level dotfiles → `~/`
- `config/*` directories → `~/.config/*`
- Custom mappings defined in `create-symlinks.sh`

### Key Components

1. **Shell Environment** (shell/)

   - ZSH with Oh My Zsh and Powerlevel10k theme
   - Custom scripts in shell/bin/
   - Environment configuration: zshrc, zprofile, zshenv

2. **Neovim** (config/nvim/)

   - LazyVim-based configuration
   - Plugin management via lazy.lua
   - Custom plugins in lua/plugins/

3. **Tmux** (tmux/)

   - Based on gpakosz/.tmux configuration
   - Custom configurations in tmux/configs/
   - Extensive key bindings and visual customization

4. **Terminal Emulators**
   - Alacritty configuration (config/alacritty/)
   - iTerm2 configuration (config/iterm/)

## Development Workflow

### Making Configuration Changes

1. Edit files in their respective directories within ~/.dot_files
2. Changes take effect immediately for symlinked files
3. For shell changes: reload shell with `source ~/.zshrc`

### Adding New Dotfiles

1. Place new configuration in appropriate directory
2. Update `create-symlinks.sh` if custom mapping needed
3. Run `./create-symlinks.sh` to create symlinks

### Git Workflow

The repository is actively maintained with recent work on:

- Neovim LLM plugins and configurations
- Shell environment improvements
- Development tooling (dev-box script)
- Tmux configurations

When committing changes, follow the existing commit message style seen in recent commits.

