#!/bin/bash
###############################################################################
# This script cleans-up Ubuntu installation
# I got some inspiration from https://github.com/jabarihunt/Ubuntu-Cleanup-Script/blob/master/clean.sh
# Also used a lot of research to make the installation lighter and safer
###############################################################################

# Remove SWAP File on PC's with 4GB+ RAM
sudo swapoff /swap.img
sudo rm /swap.img
sudo swapoff -a

# Then comment out or delete the following line in /etc/fstab:
# /swap.img      none    swap    sw      0       0

# Remove apt / apt-get files
sudo apt clean
sudo apt -s clean
sudo apt clean all
sudo apt autoremove
sudo apt-get clean
sudo apt-get -s clean
sudo apt-get clean all
sudo apt-get autoclean
# Update Ubuntu: 
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get autoremove
sudo apt-get autoclean
sudo apt-get purge
sudo apt-get clean
sudo apt-get check
sudo apt-get -f install
sudo apt autoremove
# Forced upgrade: 
sudo do-release-upgrade -d
sudo do-release-upgrade -m desktop
# Get current kernel version - Start an LXTerminal session enter:
uname -r
# View installed kernels:
dpkg -l | grep linux-image
# Remove all unused kernels:
dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge
sudo apt purge $(dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d') -y
sudo dpkg --configure -a
sudo update-grub

# Remove orphaned libraries:
sudo apt-get remove --purge `deborphan`; sudo apt-get autoremove
sudo deborphan | xargs sudo apt-get -y remove --purge
# Cleaning unused configurations: 
sudo dpkg --purge `dpkg -l | egrep "^rc" | cut -d ' ' -f3`
sudo apt-get purge $(dpkg -l | awk '/^rc/ { print $2 }')
# Clean Thumbnail Cache: 
sudo rm -rf ~/.cache/thumbnails/*
# Clean Apt Cache: 
sudo du -sh /var/cache/apt
#Remove Old Log Files
sudo rm -f /var/log/*gz
sudo rm -rf /var/log/*.gz
sudo rm -rf /var/log/*.1
# Clean temporary files
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*
rm -rf ~/.local/share/Trash/* /tmp/*

# Change to black backgound:
gsettings set org.gnome.desktop.background picture-uri ""
gsettings set org.gnome.desktop.background picture-uri-dark ""
gsettings set org.gnome.desktop.background primary-color '#000000'

# How to Remove Snap From Ubuntu (Snap seems to be an universal app-store pushed by Canonical without user acknowledge)
snap list
sudo snap remove --purge package-name
sudo rm -rf /var/cache/snapd/
sudo apt autoremove --purge snapd gnome-software-plugin-snap
rm -fr ~/snap
sudo apt-mark hold snapd

# Install Firefox .deb package for Debian-based distributions (Recommended)
# To install the .deb package through the APT repository, do the following:
# Create a directory to store APT repository keys if it doesn't exist:
sudo install -d -m 0755 /etc/apt/keyrings
# Import the Mozilla APT repository signing key:
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
# If you do not have wget installed, you can install it with: sudo apt-get install wget
# The fingerprint should be 35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3. You may check it with the following command:
gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
# Next, add the Mozilla APT repository to your sources list:
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
# Configure APT to prioritize packages from the Mozilla repository:
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla
# Update your package list, and install the Firefox .deb package:
sudo apt-get update && sudo apt-get install firefox
# Data migration: If you were using Snap or Flatpak before, you are required to import your profile:
# Copy the existing files on your computer. Make sure that all copies of Firefox on your computer are completely closed before doing this:
# Flatpak:
mkdir -p ~/.mozilla/firefox/ && cp -a ~/.var/app/org.mozilla.firefox/.mozilla/firefox/* ~/.mozilla/firefox/
# Snap:
mkdir -p ~/.mozilla/firefox/ && cp -a ~/snap/firefox/common/.mozilla/firefox/* ~/.mozilla/firefox/ 
# launch Firefox from the terminal with the command firefox -P. Select your desired profile. After this initial setup, the -P command will no longer be necessary.
firefox -P

# To list your partition sizes run: 
df -Th | sort
# Check the size of the main folders
sudo du -sxm  /[^p]* | sort -nr   | head -n 15

# list all applications installed in the system: 
for app in /usr/share/applications/*.desktop ~/.local/share/applications/*.desktop; do app="${app##/*/}"; echo "${app::-8}"; done

# Display the size of the /var
sudo du -sxm /var/* | sort -nr | head -n 15

# Large size file May be useful to check if exist large size files everyware e for any users. The command for 750MB size files may be like:
sudo find / -size +750M -exec ls -lhG {} \; | more

# How to remove MiniDLNA
sudo apt-get remove --auto-remove minidlna

# Cleanup Services
sudo apt-get install sysv-rc-conf
sudo sysv-rc-conf

# Check RAM memory
free -m
vmstat
# Free RAM
echo 3 > /proc/sys/vm/drop_caches
echo 3 | sudo tee /proc/sys/vm/drop_caches
