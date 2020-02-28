#! /bin/bash
#PS3 ="Enter Your Choice"
echo "* Service Mangment *"
select menu in "All running services" "All stopped services" "All failed services"  "Service.more" "Manage service" "Back" "Quit"
do
REPLY=
case $menu in 
	"All running services")
		clear
		echo -n "Running services......"
		systemctl list-unit-files
		. ./serviceMenu.sh
	;;
	"All stopped services")
		clear
		echo -n "Stopped services......"
		systemctl list-units --all --state=inactive
		. ./serviceMenu.sh
	;;
	"All failed services")
		clear
		echo -n "Failed services......"
		systemctl list-units --state=failed
		. ./serviceMenu.sh
	;;
	"Service.more")
		clear
		echo -n "Which service to display more details for it ? "
		read sName
		service $sName status
		. ./serviceMenu.sh

	;;
	"Manage service")
		clear
		echo -n "Enter a service that you want to mange ? "	
		read sName
                select i in "Start" "Stop" "Restart" "Enable" "Disable" "Back"
                do
                        case $i in
                                        "Start")
                                        service $sName start
                                        ;;
                                        "Stop")
                                        service $sName stop
                                        ;;
                                        "Restart")
                                        service $sName restart
                                        ;;
                                        "Enable")
					systemctl enable $sName
                                        ;;
                                        "Disable")
					systemctl disable $sName
                                        ;;
                                        "Back")
                                        . ./serviceMenu.sh
                                        break
                                        ;;
					*)
			                echo "Wrong Option"
        				;;

                esac
        	done      
  	;;	
	"Back")
		. ./mainMenu.sh
		break
	;;
	"Quit")
		break
	;;	
	*)
	echo "Wrong Option"
	;;
esac
done

