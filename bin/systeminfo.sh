# author: togra93
# last updated: 2017-03-24
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

ramfree=$(cat /proc/meminfo | grep -i 'memfree' | grep -o '[0-9]*')
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
echo -e "\e[1mCPU:\t\t\e[21m$processor"
echo -e "\e[1mRAM (total):\t\e[21m$ramtotalgb GB"
echo -e "\e[1mRAM (free):\t\e[21m$ramfreegb GB"
myj=1
for i in $primnic;do
    echo -e "\e[1mDefault NIC($myj):\t\e[21m$i\t$(nmcli dev show $i | egrep -i "(domain|type)" | grep -io "[^ ]*$")" | tr "\n" " "
    echo ""
    ((myj=myj+1))
done

echo -ne "\e[1mUsers:\t\t\e[21m"
if [ -z "$(echo -n $others)" ]; then
        echo "Nobody else ..."
else
        echo -e "\t$others"
fi

echo -e "\e[1m$(delimiter)\e[21m"
