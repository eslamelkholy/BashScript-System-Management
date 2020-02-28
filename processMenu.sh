
echo "* Process Mangment *"
select menu in "Display all Processes" "Display Specific Process" "Kill Specific process" "change priority" "Back"
do
REPLY=
case $menu in 
	"Display all Processes")
		clear
		echo "All Process ......"
		ps -ef
	;;
	"Display Specific Process")
		clear
		read -p "Enter process name: " name
		if [ -z "$name" ]
		then
		   printf '%s\n' "No input entered"
		else
			ps -C $name >/dev/null && ps -fC $name || echo "process $name is not running"
		fi
	;;
	"Kill Specific process")
		clear
		read -p "Enter the process pid you Want to kill: " processID
		if [ -z "$processID" ]
		then
		   printf '%s\n' "No input entered"
		else
			read -p "are you Sure you want to kill $pid y/n?: " validate
			if [ $validate = "y" -o $validate = "Y" ]
			then
				if [ kill $processID > /dev/null 2>&1 ]
				then
					kill -9 $processID
					echo "killed process number $processID"
				else
					echo "process $processID does not exist"
				fi
			fi
		fi
	;;
	"change priority")
		clear
		read -p "Enter the process pid to renice: " processID
		if [ -z $processID ]
		then
		   printf '%s\n' "No process entered"
		else
			read -p "Enter renice value: " value
			if [ -z $value ]
			then
				printf '%s\n' "No value entered"
			else
				sudo renice -n $value --pid $processID				
			fi
		fi
	;;
	"Back")
		clear
		. ./mainMenu.sh
		break
	;;
		
	*)
		echo "Wrong Option"
	;;
esac

done

