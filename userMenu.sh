#!/bin/bash
echo "* User Mangment *"


addNewUser(){
	argValue=$1
	echo -n "Are you sure to create this user ? y / n : "
	read accept
	if [ $accept = "y" ]
	then
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		useradd -m -p $pass $username
		chsh --shell $argValue $username
		echo "The user in the system :"
		cat /etc/passwd | grep $username
		break
	else
		echo "The user not created !"
		break
	fi
}




select i in "List all users in the system" "Add new User" "Modify user setting" "Remove specific user" "Back" "Quit"
do
REPLY=
case $i in
        "List all users in the system")
		clear
                awk -F: '{ print $1}' /etc/passwd
		
        ;;

        "Add new User")
	       clear       
               if [ $(id -u) -eq 0 ] 
			then
				echo -n "Enter username : "
				read username
				egrep "^$username" /etc/passwd > /dev/null
				if [ $? -eq 0 ]
			 	then
					echo "Sorry $username not exists!. Try again"

				else
					echo -n "Enter password : "
					read -s password
					echo ""
					echo -n "Repeat password : "
					read -s rePassword
					echo ""
					if [ $password = $rePassword ]
					then				
 						echo "the password is matches"
						echo "The default shell is '$SHELL' and the others shell are : "
						cat /etc/shells
						while [ true ]
						do
							echo -n "Enter the login shell ( default $SHELL ) : "
							read newShell
							if [ -z $newShell ]
							then
								echo "The username is '$username'"
								echo "The password is '$password'"
								echo "The shell of user is '$SHELL'"
								addNewUser $SHELL
							else
								echo "The shell you choose is '$newShell'"
								cat /etc/shells | grep "^$newShell"
								if [ $? -eq 0 ]
				 				then
									number=$(cat /etc/shells | grep "^$newShell" | wc -l)			
									shellChoose=$(cat /etc/shells | grep "^$newShell")
										if [ $number -eq 1 ]
										then
											echo "The username is '$username'"
											echo "The password is '$password'"
											echo "The shell of user is '$shellChoose'"
											addNewUser $shellChoose
										else
										echo "There is $number of shell. you should choose one of them"
										fi										
										else
										echo "the shell you entered is not found"

									fi
								fi
							done					
	
						else
							echo "The password is not match"
						fi
					fi
					
				else
					echo "Only root can add a user to the system"
					
				fi
			
        ;;
        "Modify user setting")
		clear
                echo -n "Enter the user :"
		read username
		egrep "^$username" /etc/passwd > /dev/null
		if [ $? -eq 0 ]
	 	then
			echo -n "Enter the comment : "
			read comments
			if [ ! -z $comments ]
			then
		             	 usermod -c "$comments" $username
                       		 echo "*********The comment added to users successfully"
                       		 grep -E --color "$comments" /etc/passwd
			fi

			echo -n "Enter the new home directory : "
			read newDir
			if [ ! -z $newDir ]
			then
				if [ -d "$newDir" ]
				then
					usermod -d "$newDir" $username
					echo "The directory changed successfully"
					grep -E --color "$newDir" /etc/passwd
				else
					echo "'$newDir' is not a directory !"
				fi
			fi

			echo -n "Enter the user id :"
			read userID
			  if [[ $userID =~ ^[0-9]+$ ]]
                          then
                                        usermod -u $userID $usename
                                        echo "********* The ID added successfully"
                                        grep -E --color $username /etc/passwd
                                        id $username | grep -E --color $username
                           else
                                        echo "'$userID' is not confirmed !"
                          fi
			
		else
			echo "User not found"
		fi
	

        ;;
        "Remove specific user")
               clear
		echo -n "enter the user you want to delete ?"
		read username
		if [ -d "$newDir" ]
                then
			userdel $username
		else 
		echo "No real user is selected"
		fi
		

        ;;

        "Back")
		clear
                . ./mainMenu.sh
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
