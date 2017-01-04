#!/bin/bash

# preprep.sh installs the packages and preparations needed for the rest of deployment.

# preprep needs to git clone bmenu and the next installer script in the series
# bmenu needs to set the next script perms to +x
# scripts then begin to run selection menus that drive installation of selections
#
# test files and directories
# http://tecadmin.net/bash-shell-test-if-file-or-directory-exists/#
#

### this block is optional until script is updated to check if git is installed
echo;echo "apt-get update"; sleep 2;
sudo apt-get -qq update; wait;
echo;echo "install git";echo; sleep 2;
sudo apt-get -qq install git; wait;
###


echo "make gitstuff folder";echo; sleep 2;
[ ! -d ~/gitstuff ] && mkdir ~/gitstuff;


########
echo "open gitstuff folder";echo; sleep 2;
cd ~/gitstuff;

echo "git clone bmenu repo";echo; sleep 2;
[ ! -d ~/gitstuff/bmenu ] && git clone https://github.com/bartobri/bmenu.git;wait;

echo "open bmenu/src/";echo; sleep 2;
cd ~/gitstuff/bmenu/src/;
echo "build bmenu app";echo; sleep 2;
make; wait;
echo "install bmenu";echo; sleep 2;
sudo cp ./bmenu /usr/bin/;
echo "bmenu installed";sleep 1;
########

echo;echo -ne 'here we go... \r'
sleep 1
echo -ne 'here we go... ... \r'
sleep 1
echo -ne 'here we go... ... ... \r'
sleep 1
echo -ne 'here we go... ... ... ...\r'
echo -ne '\n'
