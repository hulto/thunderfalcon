#!/bin/sh
# Locally changes all users passwords.
# Written by Russell Harvey

# Collects all users and stores into file user-list.txt
cat /etc/passwd | grep "/home" | cut -d":" -f1 > user-list.txt

# Display users and secure password to executor
echo "Changing Password of all users to secure password: D@vesMag!cBall$"
echo "Users:" | cat user-list.txt

# Assign secure password to users
for user in `more user-list.txt`
do
echo "D@vesMag!cBall$" | passwd --stdin "$user"
chage -d 0 $user
done

# Clean-up (Remove user-list.txt and change_local_pwds.sh)
rm -r user-list.txt
rm -r change_local_pwds.sh

# Exit
echo "Passwords changed."
