#!/bin/bash
set -v
#########################################################################
# This script cleans-up Ubuntu installation                             #
# Used a lot of research to make the installation lighter and safer     #
# Press CTRL-Z to stop the script                                       #
#########################################################################
#
# ██╗   ██╗██████╗ ██╗   ██╗███╗   ██╗████████╗██╗   ██╗     ██████╗██╗     ███████╗ █████╗ ███╗   ██╗
# ██║   ██║██╔══██╗██║   ██║████╗  ██║╚══██╔══╝██║   ██║    ██╔════╝██║     ██╔════╝██╔══██╗████╗  ██║
# ██║   ██║██████╔╝██║   ██║██╔██╗ ██║   ██║   ██║   ██║    ██║     ██║     █████╗  ███████║██╔██╗ ██║
# ██║   ██║██╔══██╗██║   ██║██║╚██╗██║   ██║   ██║   ██║    ██║     ██║     ██╔══╝  ██╔══██║██║╚██╗██║
# ╚██████╔╝██████╔╝╚██████╔╝██║ ╚████║   ██║   ╚██████╔╝    ╚██████╗███████╗███████╗██║  ██║██║ ╚████║
#  ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝   ╚═╝    ╚═════╝      ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝
#
echo -e "\033[96m Install language support\033[0m"
sudo apt install $(check-language-support)

echo -e "\033[96m Remove SWAP File on PC's with 4GB+ RAM\033[0m"
sudo swapoff /swap.img
sudo rm /swap.img
sudo swapoff -a

echo -e "\033[96m Then comment out or delete the following line in /etc/fstab:\033[0m"
echo -e "\033[96m /swap.img      none    swap    sw      0       0 \033[0m"

echo -e "\033[96m Change to black backgound:\033[0m"
gsettings get org.gnome.desktop.background picture-uri
gsettings set org.gnome.desktop.background picture-uri ""
gsettings get org.gnome.desktop.background picture-uri-dark
gsettings set org.gnome.desktop.background picture-uri-dark ""
gsettings get org.gnome.desktop.background primary-color
gsettings set org.gnome.desktop.background primary-color '#000000'
gsettings get org.gnome.desktop.background show-desktop-icons
gsettings set org.gnome.desktop.background show-desktop-icons true

echo -e "\033[96m Disable Event Sounds\033[0m"
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

echo -e "\033[96m Add welcome message (comment to disable)\033[0m"
gsettings get org.gnome.login-screen banner-message-enable
gsettings set org.gnome.login-screen banner-message-enable true
gsettings get org.gnome.login-screen banner-message-text
gsettings set org.gnome.login-screen banner-message-text "Welcome to Ubuntu"

echo -e "\033[96m Privacy Settings: gsettings list-keys org.gnome.desktop.privacy\033[0m"
gsettings get org.gnome.desktop.privacy disable-camera

echo -e "\033[96m gsettings set org.gnome.desktop.privacy disable-camera true\033[0m"
gsettings get org.gnome.desktop.privacy disable-microphone

echo -e "\033[96m gsettings set org.gnome.desktop.privacy disable-microphone true\033[0m"
gsettings get org.gnome.desktop.privacy disable-sound-output

echo -e "\033[96m gsettings set org.gnome.desktop.privacy disable-sound-output true\033[0m"
gsettings get org.gnome.desktop.privacy hide-identity
gsettings set org.gnome.desktop.privacy hide-identity true
gsettings get org.gnome.desktop.privacy remember-app-usage
gsettings set org.gnome.desktop.privacy remember-app-usage false
gsettings get org.gnome.desktop.privacy remember-recent-files

echo -e "\033[96m gsettings set org.gnome.desktop.privacy remember-recent-files false\033[0m"
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

echo -e "\033[96m Disable Rastersoft Ding\033[0m"
gnome-extensions disable ding@rastersoft.com

echo -e "\033[96m Remove apt / apt-get files\033[0m"
sudo apt clean
sudo apt -s clean
sudo apt clean all
sudo apt autoremove
sudo apt-get clean
sudo apt-get -s clean
sudo apt-get clean all
sudo apt-get autoclean

echo -e "\033[96m Update Ubuntu:\033[0m"
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

echo -e "\033[96m Forced upgrade:\033[0m"
sudo do-release-upgrade -d
sudo do-release-upgrade -m desktop

echo -e "\033[96m Get current kernel version - Start an LXTerminal session enter:\033[0m"
uname -r

echo -e "\033[96m View installed kernels:\033[0m"
dpkg -l | grep linux-image

echo -e "\033[96m Remove all unused kernels:\033[0m"
dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge
sudo apt purge $(dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d') -y
sudo dpkg --configure -a
sudo update-grub

echo -e "\033[96m Remove orphaned libraries:\033[0m"
sudo apt-get remove --purge `deborphan`; sudo apt-get autoremove
sudo deborphan | xargs sudo apt-get -y remove --purge

echo -e "\033[96m Cleaning unused configurations:\033[0m"
sudo dpkg --purge `dpkg -l | egrep "^rc" | cut -d ' ' -f3`
sudo apt-get purge $(dpkg -l | awk '/^rc/ { print $2 }')

echo -e "\033[96m Clean Thumbnail Cache:\033[0m"
sudo rm -rf ~/.cache/thumbnails/*

echo -e "\033[96m Clean Apt Cache:\033[0m"
sudo du -sh /var/cache/apt

echo -e "\033[96m Remove Old Log Files\033[0m"
sudo rm -f /var/log/*gz
sudo rm -rf /var/log/*.gz
sudo rm -rf /var/log/*.1

echo -e "\033[96m Clean temporary files\033[0m"
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*
rm -rf ~/.local/share/Trash/* /tmp/*

echo -e "\033[96m How to Remove Snap From Ubuntu (Snap seems to be an universal app-store pushed by Canonical without user acknowledge)\033[0m"
snap list
sudo snap remove --purge package-name
sudo rm -rf /var/cache/snapd/
sudo apt autoremove --purge snapd gnome-software-plugin-snap
rm -fr ~/snap
sudo apt-mark hold snapd

echo -e "\033[96m Install Firefox .deb package for Debian-based distributions (Recommended)\033[0m"
echo -e "\033[96m To install the .deb package through the APT repository, do the following:\033[0m"
echo -e "\033[96m Create a directory to store APT repository keys if it doesn't exist:\033[0m"
sudo install -d -m 0755 /etc/apt/keyrings
echo -e "\033[96m Import the Mozilla APT repository signing key:\033[0m"
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
echo -e "\033[96m If you do not have wget installed, you can install it with: sudo apt-get install wget\033[0m"
echo -e "\033[96m The fingerprint should be 35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3. You may check it with the following command:\033[0m"
gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
echo -e "\033[96m Next, add the Mozilla APT repository to your sources list:\033[0m"
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null
echo -e "\033[96m Configure APT to prioritize packages from the Mozilla repository:\033[0m"
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla
echo -e "\033[96m Update your package list, and install the Firefox .deb package:\033[0m"
sudo apt-get update && sudo apt-get install firefox
echo -e "\033[96m Data migration: If you were using Snap or Flatpak before, you are required to import your profile:\033[0m"
echo -e "\033[96m Copy the existing files on your computer. Make sure that all copies of Firefox on your computer are completely closed before doing this:\033[0m"
echo -e "\033[96m Flatpak:\033[0m"
mkdir -p ~/.mozilla/firefox/ && cp -a ~/.var/app/org.mozilla.firefox/.mozilla/firefox/* ~/.mozilla/firefox/
echo -e "\033[96m Snap:\033[0m"
mkdir -p ~/.mozilla/firefox/ && cp -a ~/snap/firefox/common/.mozilla/firefox/* ~/.mozilla/firefox/ 
echo -e "\033[96m launch Firefox from the terminal with the command firefox -P. Select your desired profile. After this initial setup, the -P command will no longer be necessary.\033[0m"
firefox -P

echo -e "\033[96m To list your partition sizes run:\033[0m"
df -Th | sort

echo -e "\033[96m Check the size of the main folders\033[0m"
sudo du -sxm  /[^p]* | sort -nr   | head -n 15

echo -e "\033[96m list all applications installed in the system:\033[0m"
for app in /usr/share/applications/*.desktop ~/.local/share/applications/*.desktop; do app="${app##/*/}"; echo "${app::-8}"; done

echo -e "\033[96m Display the size of the /var\033[0m"
sudo du -sxm /var/* | sort -nr | head -n 15

echo -e "\033[96m Large size file May be useful to check if exist large size files everyware e for any users. The command for 750MB size files may be like:\033[0m"
sudo find / -size +750M -exec ls -lhG {} \; | more

echo -e "\033[96m How to remove MiniDLNA\033[0m"
sudo apt-get remove --auto-remove minidlna

echo -e "\033[96m Cleanup Services\033[0m"
sudo apt-get install sysv-rc-conf
sudo sysv-rc-conf

echo -e "\033[96m Check RAM memory\033[0m"
free -m
vmstat

echo -e "\033[96m Free RAM\033[0m"
sudo echo 3 > /proc/sys/vm/drop_caches
echo 3 | sudo tee /proc/sys/vm/drop_caches
