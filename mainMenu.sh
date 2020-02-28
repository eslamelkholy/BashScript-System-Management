#!/bin/bash
echo "* System Admin Program *"
PS3="Enter your Choice: "
select i in "Process Mangment" "Service Mangment" "User Mangment" "Sofrware Mangment" "Network Mangment" "Security Mangment" "Quit"
do
case $i in
        "Process Mangment")
		clear
                . ./processMenu.sh
		break
        ;;
        "Service Mangment")
		clear
                . ./serviceMenu.sh
		break
        ;;
        "User Mangment")
		clear
                . ./userMenu.sh
		break
        ;;
	"Sofrware Mangment")
		clear
                . ./swMenu.sh
		break
        ;;
	"Network Mangment")
		clear
                . ./networkMenu.sh
		break
        ;;
	"Security Mangment")
		clear
                . ./securityMenu.sh
		break
        ;;

        "Quit")
		clear
                break
        ;;
        *)
                echo "Invalid $REPLY isn't An Option "
        ;;
esac
done
