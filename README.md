# Linux System Updater and Cleaner

This Bash script updates some types of Linux systems and removes unnecessary packages. The script is developed by **pedrody** and can be found on [GitHub](https://github.com/pedrody).

## Usage
1. Download the script or clone the repository.  
2. Navigate to the directory containing the script.  
3. Make the script executable with the command `chmod +x linux-updater.sh`.  
4. Run the script with sudo privileges using the command `sudo ./linux-updater.sh`.  
5. The script will prompt the user to confirm whether they want to start the update process or not.  
6. If the user confirms, the script will update the system packages, upgrade installed packages, and remove unnecessary packages.  
7. A log file will be created in the current directory with the update details.  
8. The script will prompt the user to confirm whether they want to reboot the system or not.

## Prerequisites
This script requires the following:
- A Linux-based operating system
- Superuser privileges (sudo)

## Supported Package Managers
The script supports the following package managers:

- apt-get
- yum
- dnf
- pacman
- emerge
- zypper  

*(I did my tests using the apt-get package manager, please let me know if you are having problems with any of the package manager)*

## How to Contribute

Feel free to fork this project and submit a pull request with your improvements.

