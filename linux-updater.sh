#!/bin/bash

# Simple script to update some types of Linux systems and
# remove unnecessary packages

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

LOG_FILE='log.txt'

# Script header
header() {
	clear
	echo -e "${BLUE}Script developed by pedrody (github.com/pedrody)${NC}"
	echo -e ""
	echo -e "-------------------------------------------------------------------------------"
	echo -e "This script will: \n${YELLOW}update${NC} the system packages, \n${YELLOW}upgrade${NC} installed packages, \n${YELLOW}remove${NC} unnecessary packages."
	echo -e "A ${RED}log file${NC} will be created in the current directory with the update details."
	echo -e "You can cancel the script at any time by pressing ${RED}CTRL + C${NC}."
	echo -e "-------------------------------------------------------------------------------"
	echo -e ""
}

# Check if the user is a superuser before running the script
if [ "$(id -u)" -ne 0 ]; then
	echo -e "${RED}This script must be run as root (sudo).${NC}" >&2
	exit 1
fi

# Run the script header
header

read -p "Do you want to start the script? [Y/n] " choice

# Make the choice case-insensitive
case "$choice" in
	y|Y) echo -e "${YELLOW}[!] Starting the script...${NC}" ;;
	*) echo -e "${YELLOW}[!] Script cancelled by user.${NC}" && exit 0;;
esac

# Get the name of the package manager and run the appropriate commands
if command -v apt-get &> /dev/null; then
	pkg_manager="apt-get"
elif command -v yum &> /dev/null; then
	pkg_manager="yum"
elif command -v dnf &> /dev/null; then
	pkg_manager="dnf"
elif command -v pacman &> /dev/null; then
	pkg_manager="pacman"
elif command -v emerge &> /dev/null; then
	pkg_manager="emerge"
elif command -v zypper &> /dev/null; then
	pkg_manager="zypper"
else
	echo -e "${RED}[!] Package manager not recognized.${NC}"
	exit 1
fi

# Run the update, upgrade, and autoremove commands for the package manager
$pkg_manager update -y | tee -a "$LOG_FILE" || { echo -e "${RED}Error updating the system.${NC}" >&2; exit 1;}
$pkg_manager upgrade -y | tee -a "$LOG_FILE" || { echo -e "${RED}Error upgrading packages.${NC}" >&2; exit 1;}
$pkg_manager autoremove -y | tee -a "$LOG_FILE" || { echo -e "${RED}Error removing unnecessary packages.${NC}" >&2; exit 1;}

echo -e "${GREEN}[!] Update completed! The log was saved to: ${YELLOW}$LOG_FILE ${NC}"

# Ask the user if they want to reboot the system
echo -e "Do you want to ${YELLOW}reboot${NC} the system now? [Y/n] \c"
read choice

# Make the choice case-insensitive
case "$choice" in
	n|N) echo "Thanks for using my script!" || exit 0 ;;
	*) echo "Thanks for using my script! The system will now reboot." && reboot ;;
esac
