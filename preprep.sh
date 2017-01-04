#!/bin/bash

# preprep.sh installs the packages and preparations needed for the rest of deployment.

# preprep needs to git clone bmenu and the next installer script in the series
# bmenu needs to set the next script perms to +x
# scripts then begin to run selection menus that drive installation of selections
#
# test files and directories
# http://tecadmin.net/bash-shell-test-if-file-or-directory-exists/#
#

### this block installs git until script is updated to check if git is installed
echo;echo -ne "checking for updates... \r";
sudo apt-get -qq update > /dev/null  2>&1; wait;
echo -ne "installing git... \r";
sudo apt-get -qq install git; wait;
###

### Stuff below this line should be converted to whiptail or other clui ###


echo -ne "make gitstuff folder \r";sleep 1;
[ ! -d ~/gitstuff ] && mkdir ~/gitstuff;


########
echo -ne "open gitstuff folder \r"; sleep 1;
cd ~/gitstuff;

echo -ne "git clone bmenu repo \r"; sleep 1;
[ ! -d ~/gitstuff/bmenu ] && git clone https://github.com/bartobri/bmenu.git;wait;

echo -ne "open bmenu/src/ \r"; sleep 1;
cd ~/gitstuff/bmenu/src/;
echo -ne "build bmenu app \r"; sleep 1;
make; wait;
echo -ne "install bmenu \r"; sleep 1;
sudo cp ./bmenu /usr/bin/;
echo -ne "bmenu installed \r";sleep 1;
########

echo;echo -ne 'here we go... \r'
sleep 1
echo -ne 'here we go... ... \r'
sleep 1
echo -ne 'here we go... ... ... \r'
sleep 1
echo -ne 'here we go... ... ... ...\r'
echo -ne '\n'
