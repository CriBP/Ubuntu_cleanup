#!/bin/bash
###############################################################################
# This script cleans-up Ubuntu installation
# I got some inspiration from https://github.com/jabarihunt/Ubuntu-Cleanup-Script/blob/master/clean.sh
# Also used a lot of research to make the installation lighter and safer
###############################################################################

# Remove SWAP File
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
sudo dpkg --configure -a
sudo update-grub

# Remove orphaned libraries:
sudo apt-get remove --purge `deborphan`; sudo apt-get autoremove
sudo deborphan | xargs sudo apt-get -y remove --purge
# Cleaning unused configurations: 
sudo dpkg --purge `dpkg -l | egrep "^rc" | cut -d ' ' -f3`
# Clean Thumbnail Cache: 
sudo rm -rf ~/.cache/thumbnails/*
# Clean Apt Cache: 
sudo du -sh /var/cache/apt
#Remove Old Log Files
sudo rm -f /var/log/*gz

# Change to black backgound:
gsettings set org.gnome.desktop.background picture-uri ""
gsettings set org.gnome.desktop.background picture-uri-dark ""
gsettings set org.gnome.desktop.background primary-color '#000000'

# How to Remove Snap From Ubuntu (Snap seems to be an app store)
snap list
sudo snap remove --purge package-name
sudo rm -rf /var/cache/snapd/
sudo apt autoremove --purge snapd gnome-software-plugin-snap
rm -fr ~/snap
sudo apt-mark hold snapd

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
