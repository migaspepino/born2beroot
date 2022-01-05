#!/bin/bash

arq=$(uname -a)

cpu=$(nproc)

vcpu=$(cat /proc/cpuinfo | grep processor | wc -l) #counts the number of lines of processors (ex: prc:0 \n proc:1 \n proc: 2 etc...)

#ram usage
#free memory in memibytes | where 1 field = Mem: get nth field
uram=$(free -m | awk '$1 == "Mem:" {print $3}') #gets mem row 3rd field of free -m (memibytes)
fram=$(free -m | awk '$1 == "Mem:" {print $4}') #gets mem row 4th field of free -m (memibytes)
pram=$(free -m | awk '$1 == "Mem:" {printf("%.2f"), $3/$2*100}') # %.2f prints floating point with 2 digits $3/$2*100 calculates value in %

#disk usage / + /home
#df -BG (size in GiB) | all with /dev/ in beg. | without /boot at the end | add 2nd field value and then print value
fdisk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{ft += $2} END {print ft}') 
udisk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} END {print ut}')
pdisk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} {ft+= $2} END {printf("%d"), ut/ft*100}')

#cpu load
#cpu load != cpu usage 
#see: https://www.baeldung.com/linux/get-cpu-usage
#vmstat get 2 samples delayed by 1 sec | get last line | get 15th field (idle field)
idlecpu=$(vmstat 1 2 | tail -1 | awk '{print $15}')
cpuld=$(echo 100-$idlecpu| bc) #calculate total

#last boot
#see: https://unix.stackexchange.com/questions/131775/how-long-has-my-linux-system-been-running
#gets last boot  | prints 3rd and 4th fields
lboot=$(who -b | awk '{print $3" "$4}')

#LVM use
#check if lsblk has "lvm" and count how many times
bool=$(lsblk | grep "lvm" | wc -l)
lvm=$(if [$bool -eq 0]; then echo "No"; else echo "Yes"; fi)

#install net-tools
ncon=$(netstat -at | grep 'ESTABLISHED' | wc -l)

user=$(users | wc -w)

#These two only work with just one "physical" connection
ip=$(hostname -i)
mac=$(ip link show | awk '$1 == "link/ether" {print $2}')

#non systemd
suc=$(cat /var/log/sudo/sudo.log | grep "COMMAND" | wc -l)
#systemd
#suc=$(journalctl _COMM=sudo | grep COMMAND | wc -l)

#broadcast
wall 
"	#Architecture: $arq
	#CPU physical: $cpu
	#vCPU: $vcpu
	#Memory Usage: $uram/${fram}MB ($pram%)
	#Disk Usage: $udisk/${fdisk}Gb ($pdisk%)
	#CPU load: $cpuld
	#Last boot: $lboot
	#LVM use: $lvm
	#Connexions TCP: $ncon ESTABLISHED
	#User log: $user
	#Network: IP $ip ($mac)
	#Sudo: $suc cmd"
