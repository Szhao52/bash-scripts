#!/bin/bash
#For all logged in users, show their real names and the time and date of their last login.
#getent allows us to get the users from etc/passwd and the range where the users appear, then awk cuts the output to only the user name.
users=$(getent passwd {1000..60000}|awk -F: '{ print $1}')

#"user" start to iterate through the list of "users" we got, and again with getent and awk we get their realnames at that specified position.
for user in $users; do
    real_name=$(getent passwd $user |awk -F: '{ print $5}')
    # the last and awk command outputs the login date of the users at those positions.
    last_login=$(last -n 1 $user | awk '{print $3, $4, $5, $6}')
    echo "Real Name: $real_name, Last Login: $last_login"
done