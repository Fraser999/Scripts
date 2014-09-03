#!/bin/bash
Repos=$(curl -s -u "Fraser999" https://api.github.com/orgs/maidsafe/repos | grep '"ssh_url": "git@github.com:maidsafe/.*[^"]"' | sed 's|   "ssh_url": "\(.*[^"]\)",|\1|')

rm -rf Backups
mkdir Backups
cd Backups

for i in $Repos ; do
  git clone --mirror $i
  echo "==============================================================================="
done
