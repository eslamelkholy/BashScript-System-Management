#!/bin/bash
clear
echo "* Security *"
select i in "SeLinux security" "FirewallConfiguration" "Back"
do
case $i in
        "SeLinux security")
                . ./seLinux
        ;;
        "FirewallConfiguration")
                . ./firewall
        ;;
        "Back")
                . ./mainMenu
                 break
        ;;

        *)
                echo "Invalid $REPLY isn't An Option "
        ;;
esac
done
