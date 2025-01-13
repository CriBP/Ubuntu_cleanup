#!/bin/bash
# Set Color variables - Foreground
Black='\033[30m' && DarkRed='\033[31m' && DarkGreen='\033[32m' && Orange='\033[33m' && DarkBlue='\033[34m' && DarkMagenta='\033[35m' && DarkCyan='\033[36m' && LightGray='\033[37m' && DarkGray='\033[90m' && Red='\033[91m' && Green='\033[92m' && Orange='\033[93m' && Blue='\033[94m' && Magenta='\033[95m' && Cyan='\033[96m' && White='\033[97m'
# Set Color variables - Background
BBlack='\033[40m' && BDarkRed='\033[41m' && BDarkGreen='\033[42m' && BOrange='\033[43m' && BDarkBlue='\033[44m' && BDarkMagenta='\033[45m' && BDarkCyan='\033[46m' && BLightGray='\033[47m' && BDarkGray='\033[100m' && BRed='\033[101m' && BGreen='\033[101m' && BOrange='\033[103m' && BBlue='\033[104m' && BMagenta='\033[105m' && BCyan='\033[106m' && BWhite='\033[107m'
# Clear the color after that
clear='\033[0m'

set -v
#####################################################################
# This script cleans-up Ubuntu installation                         #
# Used a lot of research to make the installation lighter and safer #
# Press CTRL-Z to stop the script                                   #
#####################################################################
#
# ██╗   ██╗██████╗ ██╗   ██╗███╗   ██╗████████╗██╗   ██╗
# ██║   ██║██╔══██╗██║   ██║████╗  ██║╚══██╔══╝██║   ██║
# ██║   ██║██████╔╝██║   ██║██╔██╗ ██║   ██║   ██║   ██║
# ██║   ██║██╔══██╗██║   ██║██║╚██╗██║   ██║   ██║   ██║
# ╚██████╔╝██████╔╝╚██████╔╝██║ ╚████║   ██║   ╚██████╔╝
#  ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝   ╚═╝    ╚═════╝
# 
#      ██████╗██╗     ███████╗ █████╗ ███╗   ██╗
#     ██╔════╝██║     ██╔════╝██╔══██╗████╗  ██║
#     ██║     ██║     █████╗  ███████║██╔██╗ ██║
#     ██║     ██║     ██╔══╝  ██╔══██║██║╚██╗██║
#     ╚██████╗███████╗███████╗██║  ██║██║ ╚████║
#      ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝
#
echo -e "${Cyan}Install language support${clear}"
sudo apt install $(check-language-support)

echo -e "${Cyan}Remove SWAP File on PC's with 4GB+ RAM${clear}"
sudo swapoff /swap.img
sudo rm /swap.img
sudo swapoff -a

echo -e "${Orange}Then comment out or delete the following line in /etc/fstab:"
echo -e "/swap.img      none    swap    sw      0       0 ${clear}"

echo -e "${Cyan}Change to black backgound:${clear}"
gsettings get org.gnome.desktop.background picture-uri
gsettings set org.gnome.desktop.background picture-uri ""
gsettings get org.gnome.desktop.background picture-uri-dark
gsettings set org.gnome.desktop.background picture-uri-dark ""
gsettings get org.gnome.desktop.background primary-color
gsettings set org.gnome.desktop.background primary-color '#000000'
gsettings get org.gnome.desktop.background show-desktop-icons
gsettings set org.gnome.desktop.background show-desktop-icons true

echo -e "${Cyan}Disable Event Sounds${clear}"
sudo rmmod pcspkr ; echo "blacklist pcspkr" >>/etc/modprobe.d/blacklist.conf
gsettings get org.gnome.desktop.sound allow-volume-above-100-percent
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings get org.gnome.desktop.sound event-sounds
gsettings set org.gnome.desktop.sound event-sounds false
gsettings get org.gnome.desktop.sound input-feedback-sounds
gsettings set org.gnome.desktop.sound input-feedback-sounds false
gsettings get org.gnome.desktop.sound event-sounds
gsettings set org.gnome.desktop.sound event-sounds false
gsettings get com.ubuntu.sound allow-amplified-volume
gsettings set com.ubuntu.sound allow-amplified-volume true

echo -e "${Cyan}Add welcome message (comment to disable)${clear}"
gsettings get org.gnome.login-screen banner-message-enable
gsettings set org.gnome.login-screen banner-message-enable true
gsettings get org.gnome.login-screen banner-message-text
gsettings set org.gnome.login-screen banner-message-text "Welcome to Ubuntu"

echo -e "${Cyan}Privacy Settings: gsettings list-keys org.gnome.desktop.privacy${clear}"
gsettings get org.gnome.desktop.privacy disable-camera
gsettings set org.gnome.desktop.privacy disable-camera true
gsettings get org.gnome.desktop.privacy disable-microphone
gsettings set org.gnome.desktop.privacy disable-microphone true
gsettings get org.gnome.desktop.privacy disable-sound-output
# gsettings set org.gnome.desktop.privacy disable-sound-output true
gsettings get org.gnome.desktop.privacy hide-identity
gsettings set org.gnome.desktop.privacy hide-identity true
gsettings get org.gnome.desktop.privacy remember-app-usage
gsettings set org.gnome.desktop.privacy remember-app-usage false
gsettings get org.gnome.desktop.privacy remember-recent-files
# gsettings set org.gnome.desktop.privacy remember-recent-files false
gsettings get org.gnome.desktop.privacy remove-old-temp-files
gsettings set org.gnome.desktop.privacy remove-old-temp-files true
gsettings get org.gnome.desktop.privacy remove-old-trash-files
gsettings set org.gnome.desktop.privacy remove-old-trash-files true
gsettings get org.gnome.desktop.privacy report-technical-problems
gsettings set org.gnome.desktop.privacy report-technical-problems false
gsettings get org.gnome.desktop.privacy send-software-usage-stats
gsettings set org.gnome.desktop.privacy send-software-usage-stats false
gsettings get org.gnome.desktop.privacy show-full-name-in-top-bar
gsettings set org.gnome.desktop.privacy show-full-name-in-top-bar true
gsettings get org.gnome.desktop.privacy usb-protection
gsettings set org.gnome.desktop.privacy usb-protection true

echo -e "${Cyan}Disable Rastersoft Ding${clear}"
gnome-extensions disable ding@rastersoft.com

echo -e "${Cyan}Remove apt / apt-get files${clear}"
sudo apt clean
sudo apt -s clean
sudo apt clean all
sudo apt autoremove
sudo apt-get clean
sudo apt-get -s clean
sudo apt-get clean all
sudo apt-get autoclean

echo -e "${Cyan}Update Ubuntu:${clear}"
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

echo -e "${Cyan}Forced upgrade:${clear}"
sudo do-release-upgrade -d
sudo do-release-upgrade -m desktop

echo -e "${Cyan}Get current kernel version - Start an LXTerminal session enter:${clear}"
uname -r

echo -e "${Cyan}View installed kernels:${clear}"
dpkg -l | grep linux-image

echo -e "${Cyan}Remove all unused kernels:${clear}"
dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge
sudo apt purge $(dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d') -y
sudo dpkg --configure -a
sudo update-grub

echo -e "${Cyan}Remove orphaned libraries:${clear}"
sudo apt-get remove --purge `deborphan`; sudo apt-get autoremove
sudo deborphan | xargs sudo apt-get -y remove --purge

echo -e "${Cyan}Cleaning unused configurations:${clear}"
sudo dpkg --purge `dpkg -l | egrep "^rc" | cut -d ' ' -f3`
sudo apt-get purge $(dpkg -l | awk '/^rc/ { print $2 }')

echo -e "${Cyan}Clean Thumbnail Cache:${clear}"
sudo rm -rf ~/.cache/thumbnails/*

echo -e "${Cyan}Clean Apt Cache:${clear}"
sudo du -sh /var/cache/apt

echo -e "${Cyan}Remove Old Log Files${clear}"
sudo rm -f /var/log/*gz
sudo rm -rf /var/log/*.gz
sudo rm -rf /var/log/*.1

echo -e "${Cyan}Clean temporary files${clear}"
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*
rm -rf ~/.local/share/Trash/* /tmp/*

echo -e "${Red}How to Remove Snap From Ubuntu (Snap seems to be an universal app-store pushed by Canonical without user acknowledge)${clear}"
snap list
sudo snap remove --purge package-name
sudo rm -rf /var/cache/snapd/
sudo apt autoremove --purge snapd gnome-software-plugin-snap
rm -fr ~/snap
sudo apt-mark hold snapd

echo -e "${Red}Install Firefox .deb package for Debian-based distributions (Recommended)${clear}"
echo -e "${Cyan}To install the .deb package through the APT repository, do the following:${clear}"
echo -e "${Cyan}Create a directory to store APT repository keys if it doesn't exist:${clear}"
sudo install -d -m 0755 /etc/apt/keyrings
echo -e "${Cyan}Import the Mozilla APT repository signing key:${clear}"
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
echo -e "${Cyan}If you do not have wget installed, you can install it with: sudo apt-get install wget${clear}"
echo -e "${Cyan}The fingerprint should be 35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3. You may check it with the following command:${clear}"
gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
echo -e "${Cyan}Next, add the Mozilla APT repository to your sources list:${clear}"
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo -e "${Cyan}Configure APT to prioritize packages from the Mozilla repository:${clear}"
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla
echo -e "${Cyan}Update your package list, and install the Firefox .deb package:${clear}"
sudo apt-get update && sudo apt-get install firefox
echo -e "${Cyan}Data migration: If you were using Snap or Flatpak before, you are required to import your profile:${clear}"
echo -e "${Cyan}Copy the existing files on your computer. Make sure that all copies of Firefox on your computer are completely closed before doing this:${clear}"
echo -e "${Cyan}Flatpak:${clear}"
mkdir -p ~/.mozilla/firefox/ && cp -a ~/.var/app/org.mozilla.firefox/.mozilla/firefox/* ~/.mozilla/firefox/
echo -e "${Cyan}Snap:${clear}"
mkdir -p ~/.mozilla/firefox/ && cp -a ~/snap/firefox/common/.mozilla/firefox/* ~/.mozilla/firefox/ 
echo -e "${Cyan}launch Firefox from the terminal with the command firefox -P. Select your desired profile. After this initial setup, the -P command will no longer be necessary.${clear}"
firefox -P

echo -e "${Cyan}To list your partition sizes run:${clear}"
df -Th | sort

echo -e "${Cyan}Check the size of the main folders${clear}"
sudo du -sxm  /[^p]* | sort -nr   | head -n 15

echo -e "${Cyan}list all applications installed in the system:${clear}"
for app in /usr/share/applications/*.desktop ~/.local/share/applications/*.desktop; do app="${app##/*/}"; echo "${app::-8}"; done

echo -e "${Cyan}Display the size of the /var${clear}"
sudo du -sxm /var/* | sort -nr | head -n 15

echo -e "${Cyan}Large size file May be useful to check if exist large size files everyware e for any users. The command for 750MB size files may be like:${clear}"
sudo find / -size +750M -exec ls -lhG {} \; | more

echo -e "${Cyan}How to remove MiniDLNA${clear}"
sudo apt-get remove --auto-remove minidlna

echo -e "${Cyan}Cleanup Services${clear}"
sudo apt-get install sysv-rc-conf
sudo sysv-rc-conf

echo -e "${Cyan}Check RAM memory${clear}"
free -m
vmstat

echo -e "${Cyan}Free RAM${clear}"
sudo echo 3 > /proc/sys/vm/drop_caches
echo 3 | sudo tee /proc/sys/vm/drop_caches
