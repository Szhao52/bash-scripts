#!/bin/bash
#Gather all users in the system. Show only the first 5 users alphabetically. The last one logged in has to be removed. 
#Print the name of the user removed and the date he logged last

#list users (its set to 1001 to avoid deleting the admin user) sorting alphabetically with sort command and takes only the first 5 with head command.
users=$(getent passwd {1001..60000}| awk -F: '{ print $1}'|sort|head -5)

#From the list of users prints the recent logins with last command, and with grep it looks for the first match on that list of users. 
last_user=$(last -a | grep -m 1 -F -f <(printf "%s\n" "${users[@]}") | awk '{print $1}')
#prints the last date of the last user.
last_login=$(last -n 1 $last_user | awk '{print $3, $4, $5, $6}')


#Confirmation prompt, to avoid accidental user deletion
read -p "Are you sure you want to delete $last_user (Last login: $last_login)? (y/n) " confirmation
    
if [[ $confirmation =~ ^[Yy]$ ]]; then
        echo "User $last_user is about to be deleted."
        sudo userdel $last_user
    
else
    echo "Deletion cancelled."
fi