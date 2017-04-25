# author: togra93
# last updated: 2017-03-25
# collecting and displaying system information

delimiter(){
    for i in `seq 1 $(tput cols)`;do
       echo -n '-';
    done
}

# operating system
os=$(cat /etc/*release | egrep -i "(^name=|^version=)" | sed -r s/'(NAME=|VERSION=|\")'//g | tr '\n' ' ')

# other users
others=$(who | grep -o '^[a-z]* ' | sort -u | grep -v $(echo $(whoami)) | tr "\n" ' ')

processor=$(cat /proc/cpuinfo | grep -m 1 'model name' | sed -r s/'^.*: '//)

ramtotal=$(cat /proc/meminfo | grep -i 'memtotal' | grep -o '[0-9]*')
ramtotalgb=$(echo "scale=2;$ramtotal/1000000"|bc)

ramfree=$(cat /proc/meminfo | grep -i 'memavailable' | grep -o '[0-9]*')
ramfreegb=$(echo "scale=2;$ramfree/1000000"|bc)

uptime=$(uptime | grep -o '[0-9] days')
if [[ -z $uptime ]];then uptime='less than 1 day';fi

primnic=$(route | grep -i "^default" | grep -io "[^ ]*$")

# display collected information
echo -e "\e[1m$(delimiter)\e[21m"
echo -e "Welcome, \e[32m$(whoami)\e[0m\n"
echo -e "\e[1mHost:\t\t\e[21m$HOSTNAME"
echo -e "\e[1mUptime:\t\t\e[21m$uptime"
echo -e "\e[1mOS:\t\t\e[21m$os\e[22m"
echo -e "\e[1mKernel:\t\t\e[21m$(uname -r)\e[22m"
echo -e "\e[1mCPU:\t\t\e[21m$processor"
echo -e "\e[1mRAM (total):\t\e[21m$ramtotalgb GB"

# check available RAM
if [ ! -z $ramfree ];then
    echo -e "\e[1mRAM (avail.):\t\e[21m$ramfreegb GB"
else
    echo -e "\e[1mRAM (avail.):\t\e[21mCan't determine avail. RAM\n\t\tKernel too old?"
fi

# check network interfaces
myj=1
if [ ! -z $primnic ];then
    for i in $primnic;do
        mytype=$(nmcli dev show $i | grep -i "type" | grep -io "[^ ]*$")
        mydomain=$(nmcli dev show $i | grep -i "domain" | grep -io "[^ ]*$")
        echo -e "\e[1mDefault NIC($myj):\t\e[21m$i ($mytype)\n\t\t$mydomain"
        ((myj=myj+1))
    done
else
    echo -e "\e[1mDefault NIC:\t\e[21mCan't determine NIC (missing privileges?)"
fi

# display users on the system (format)
echo -ne "\e[1mUsers:\t\t\e[21m"
if [ -z "$(echo -n $others)" ]; then
        echo "Nobody else ..."
else
        myj=1
        for i in $others;do
            if [ $((myj%5)) -eq 0 ]; then
                echo -en "\n\t\t$i"
            else
                echo -n "$i "
            fi
            ((myj=myj+1))
        done
        echo ""
fi

echo -e "\e[1m$(delimiter)\e[21m"
