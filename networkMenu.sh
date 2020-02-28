#!/bin/bash
PS3="Enter your Choice: "
select i in "List All Network Interface" "Displat More Info For Specific Interface" "Modify Network Settings" "Quit"
do
REPLY=
case $i in
        "List All Network Interface")
              	netstat -I | awk -F " " '{if(NR >2){print $1}}';
		#ip -o link show | awk -F': ' '{print $2}'
               	# ls /sys/class/net 
        ;;
        "Displat More Info For Specific Interface")
                echo "Enter The Name Of Your Network Interface";
		read name;
		netstat -I | awk -F " " '{if(NR >2){print $1}}' > test.txt;
		if $(grep -wq "$name" test.txt)
		then
			ifconfig | awk -F ":" 'BEGIN{flag = 0;count=0}{if($1 == $name){flag=1}if(count < 7 && flag == 1){print $1;count++;}}'
		else
			echo "Please Enter a Valid Network Interface Name"
		fi
        ;;
        "Modify Network Settings")
      		mapfile -t Networks < <( nmcli connection show | awk -F " " '{if(NR >1){print $1}}');
		size=${#Networks[@]}
		select option in ${Networks[@]}
		do
			if [ 1 -le "$REPLY" ] && [ "$REPLY" -le $((size)) ];
			then
				path="/etc/sysconfig/network-scripts/ifcfg-$option"
				select j in "Automatic Network Configuration" "Manual Config" "Exit"
				do
				case $j in
				"Automatic Network Configuration")
					sudo sed -i 's/BOOTPROTO=manual/BOOTPROTO=dhcp/g' "$path"
					echo "Now We Are going to Restart Network... "
					#systemctl restart network
				;;
				"Manual Config")
					sed -i 's/BOOTPROTO=dhcp/BOOTPROTO=manual/g' "$path"
					echo "Enter your Selected Network Interface IP "
					read ip
					echo "Enter your netmask"
					read netmask
					echo "Enter your Default gateway"
					read gateway
					echo "Enter your DNS1"
					read dns1
					echo "Enter your DNS2"
					read dns2
					sudo ifconfig "$option" "$ip" netmask "$netmask"
					sudo route add default gw "$gateway" "$option"
					echo "nameserver	$dns1" > /etc/resolve.conf
					echo "nameserver	$dns2" >> /etc/resolve.conf
					echo "Now We Are going to Restart The Network..."
					#systemctl restart network
				;;
				"Exit")
					break;
				;;
				*)
					echo "Invalid $REPLY isn't An Option"
				;;
				esac
				done
			else
				echo "Incorrect answer:Select a number 1 to $size"
			fi
		done
        ;;
	"Quit")
		break;
	;;
        *)
                echo "Invalid $REPLY isn't An Option "
        ;;
esac
done


