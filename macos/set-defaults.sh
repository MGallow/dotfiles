#!/usr/bin/env bash
#
# macOS defaults — reflects Matt's actual preferences.
# Run manually: make defaults
# NOT called automatically by make install or make bootstrap.

# Close any open System Settings panes
osascript -e 'tell application "System Settings" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: refresh sudo timestamp every 60 s until this script finishes.
# The background process is killed automatically when the script exits.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
SUDO_KEEPALIVE_PID=$!
trap 'kill "$SUDO_KEEPALIVE_PID" 2>/dev/null' EXIT

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Set sidebar icon size to small
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# SECURITY NOTE: Disabling LSQuarantine removes Gatekeeper's "unverified
# developer" warning for downloaded apps. Disabled here — uncomment only if needed.
# defaults write com.apple.LaunchServices LSQuarantine -bool false

# Keep autocorrect and smart substitutions enabled
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool true
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool true
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool true
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool true
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool true

# Open new documents in tabs always
defaults write NSGlobalDomain AppleWindowTabbingMode -string "always"

# Automatically switch between light and dark mode
defaults write NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically -bool true

###############################################################################
# Trackpad, mouse, keyboard, and input                                        #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad and mouse speed
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.5
defaults write NSGlobalDomain com.apple.mouse.scaling -float 2

# Natural (Mac-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

# Enable spring-loaded folders for drag and drop
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0.5

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true

###############################################################################
# Screen                                                                      #
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to Downloads
defaults write com.apple.screencapture location -string "${HOME}/Downloads"

# Save screenshots in PNG format
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Use column view in all Finder windows by default
# Possible values: `icnv` (icons), `clmv` (column), `Nlsv` (list), `glyv` (gallery)
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

###############################################################################
# Dock                                                                        #
###############################################################################

# Set the icon size of Dock items
defaults write com.apple.dock tilesize -int 85

# Position Dock on the right side of the screen
defaults write com.apple.dock orientation -string "right"

# Use genie minimize/maximize window effect
defaults write com.apple.dock mineffect -string "genie"

# Minimize windows into their application's icon
defaults write com.apple.dock minimize-to-application -bool true

# Show recent applications in Dock
defaults write com.apple.dock show-recents -bool true

# Don't animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Keep the Dock always visible
defaults write com.apple.dock autohide -bool false

###############################################################################
# Hot Corners                                                                 #
# Possible values:                                                            #
#  0: no-op    2: Mission Control    3: App windows    4: Desktop             #
#  5: Start screen saver            6: Disable screen saver                  #
# 10: Display sleep  11: Launchpad  12: Notification Center  13: Lock Screen  #
###############################################################################

# Top-left: disabled
defaults write com.apple.dock wvous-tl-corner -int 1
defaults write com.apple.dock wvous-tl-modifier -int 0

# Top-right: Desktop
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom-left: Desktop
defaults write com.apple.dock wvous-bl-corner -int 4
defaults write com.apple.dock wvous-bl-modifier -int 0

# Bottom-right: Start screen saver
defaults write com.apple.dock wvous-br-corner -int 5
defaults write com.apple.dock wvous-br-modifier -int 0

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Privacy: don't send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Enable "Do Not Track"
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

###############################################################################
# Terminal                                                                    #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# SECURITY: Secure Keyboard Entry prevents other processes from reading keystrokes.
# Disabled here to match current system settings; re-enable if preferred.
# defaults write com.apple.terminal SecureKeyboardEntry -bool true

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Don't show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool false

# Show current user's processes (100) in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 100

# Show CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

###############################################################################
# Developer Tools                                                             #
###############################################################################

# Show build time in Xcode
defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool YES

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Activity Monitor" "cfprefsd" "Dock" "Finder" "Safari" \
    "SystemUIServer" "Terminal"; do
    killall "${app}" &> /dev/null
done

echo "macOS settings updated. Some changes require a logout/restart to take effect."
