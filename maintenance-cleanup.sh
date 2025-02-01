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

echo -e "${Cyan}Check RAM memory${clear}"
free -m
vmstat

echo -e "${Cyan}Free RAM${clear}"
sudo echo 3 > /proc/sys/vm/drop_caches
echo 3 | sudo tee /proc/sys/vm/drop_caches
