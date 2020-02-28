#!/bin/bash
echo "* Software Mangment *"
PS3="Enter a choice : "
select i in "list all installed packages" "display more info for specific package" "list avalible repos" "install new package" "update existing package" "remove package" "Back"
do
REPLY=
case $i in "list all installed packages")
		clear
                yum list installed
		
        ;;
        "display more info for specific package")
		clear
		echo "enter package name"
                read pkgName
	if yum list installed $pkgName
	then
		yum info $pkgName
	else 
	echo "$pkgName is not insatlledpackage"
	fi
	 
        ;;
        "list avalible repos")
		clear
                yum repolist
        ;;
        "install new package")
		clear
                echo "Enter pkg name you want to install : "
                read pkgInstall
		  if yum list installed $pkgInstall
        then
                echo "$pkgInstall is already insatlled ,Do you want to update it"
		read updateStatus
		if [[ "$updateStatus" == y ]]
		then 
		yum update  $pkgInstall
		else 
		echo "package not valid"
		fi
        else
        	 yum install $pkgInstall

        fi
	

        ;;
	"update existing package")
	clear
	echo "Enter package you want to update : "
	read pkgUpdate
	        if yum list installed $pkgUpdate
        then
           	yum update  $pkgUpdate
        else
                echo "$pkgUpdate doesn't exist"

        fi  
	 
	;;
        "remove package")
	 clear
	 echo "Enter a package you want to erase : "
               read removedPkg

	 if yum list installed $removedPkg
         then
              yum erase $removedPkg

         else
                echo "$removedPkg doesn't exist"

        fi
	 
        ;;
	"Back")
		clear
		. ./mainMenu.sh
		break
	;;
        *)
                echo "Invalid $REPLY isn't An Option "
        ;;
esac
done

