#!/usr/bin/env bash

red='\e[1;31m'
green='\e[1;32m'
yellow='\e[1;33m'
blue='\e[1;34m'
white='\e[1;37m'
cyan='\e[1;36m'
clear='\e[0m'


banner(){
    printf "${cyan}____________________       _________
___  __ \__  ____/_ |     / /_  ___/
__  /_/ /_  __/  __ | /| / /_____ \ 
_  ____/_  /___  __ |/ |/ / ____/ /
/_/     /_____/  ____/|__/  /____/ \n${clear}
${yellow}Privilege Escalation With SUID${clear}\n
${cyan}-----------------------------------------
Coded by ertanszr and melisanur. 
Please use only educational purpose. 
Not use illegally.
github.com/ertanszr-git
github.com/melisanur
-----------------------------------------${clear}\n\n"
}

list_suid() {
    
    suidfiles=$(find / -perm -u=s -type f 2>/dev/null)
    if [[ ! -z $suidfiles ]]; then
        printf "${yellow}[!]${green} SUID files found: ${clear}\n\n"
        for file in $suidfiles; do
            printf "${yellow}[+]${cyan} $file ${clear}\n"
            sleep 0.1
        done
    else
        printf "${red}[-]${white} SUID files not found\n"
    fi
    printf "\n"
}


scan_vuln(){
    printf "${cyan}Enter name of the log file : ${clear}"
    read logname
    suidfiles=$(find / -perm -u=s -type f 2>/dev/null | sed -E 's/.*\/(.*)$/\1/')
    i=0
    while [[ $i -lt $[$(wc -l pews.conf | awk '{print $1;}')-1] ]]; do
        i=$[$i+1]
        if [[ $suidfiles =~ $(awk 'c&&!--c;/config/{c='$i'}' pews.conf | awk '{print $1;}' | tr 'ğ' ' ' | tr -s " ") ]]; then
            printf "${green}[+] Found $(awk 'c&&!--c;/config/{c='$i'}' pews.conf | awk '{print $1;}' | tr 'ğ' ' ' | tr -s " ") ${clear}\n" | tee -a $logname.log
            printf  "${cyan} ╰─> $(awk 'c&&!--c;/config/{c='$i'}' pews.conf | awk '{print $2;}' | tr 'ğ' ' ' | tr -s " ") ${clear}\n" | tee -a $logname.log
            sleep 0.1
        else
            printf "${red}[-] Not found $(awk 'c&&!--c;/config/{c='$i'}' pews.conf | awk '{print $1;}' | tr 'ğ' ' ' | tr -s " ") ${clear}\n" | tee -a $logname.log
            sleep 0.1
        fi
    done
}



main(){

clear
banner
printf "${yellow}[1]${clear}${cyan}List All SUID Files${clear}\n"
printf "${yellow}[2]${clear}${cyan}Scan Possible Vulnerable SUID Commands${clear}\n"
printf "${cyan}Select an option: ${clear}"
read option

if [ $option -eq 1 ]; then
    printf "${cyan}\nListing all SUID files...${clear}\n\n"
    list_suid
elif [ $option -eq 2 ]; then
    printf "${cyan}\nScanning for possible vulnerable SUID commands...${clear}\n\n"
    scan_vuln
else
    printf "${red}[-] Invalid option ${clear}\n"
fi
}

backtomenu_option() {
printf "\n"
printf "${green}[+] Return to Main Menu? ${yellow}[y/n] ${clear}"
read backtomenu
if [ $backtomenu = "y" ]; then
main
elif [ $backtomenu = "n" ]; then
exit
else
printf "${red}[-] Invalid option!${clear}\n"
backtomenu_option
fi
}
main
backtomenu_option
