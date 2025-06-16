#/bin/bash

MASTER=master
NEWMASTER=devk
OLDMASTER=java

# Make sure NEWMASTER is up-to-date
git checkout $NEWMASTER
git pull origin $NEWMASTER # If applicable

# Rename local master to OLDMASTER
git checkout $MASTER
git branch -m $OLDMASTER

# Create new master from NEWMASTER
git checkout $NEWMASTER
git checkout -b $MASTER

# Force push the new master to remote (USE WITH CAUTION)
git push -f origin $MASTER

# Optionally push the old master (now OLDMASTER) to remote
git push origin $OLDMASTER

# Optionally, if the old remote master still exists and you want to remove it
# git push origin --delete MASTER