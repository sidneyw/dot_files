#!/bin/bash

# Increase Key Repeat
# Set the initial key repeat delay and repeat rate
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1         # normal minimum is 2 (30 ms)

# Hide Dock
# Enable auto-hide for the Dock
defaults write com.apple.dock autohide -bool true
# Restart Dock to apply changes
killall Dock

# Show Battery Percentage
# Display battery percentage in the menu bar (macOS Big Sur and later)
defaults write com.apple.controlcenter BatteryShowPercentage -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -int 1

# Show Bluetooth in the menu bar
# Ensure Bluetooth is shown in the menu bar (macOS Big Sur and later)
defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -int 1
# Restart Control Center to apply changes
killall ControlCenter

# Restart SystemUIServer to apply changes
killall SystemUIServer
