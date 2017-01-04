#!/bin/bash

# preprep.sh installs the packages and preparations needed for the rest of deployment.

# preprep needs to git clone bmenu and the next installer script in the series
# bmenu needs to set the next script perms to +x
# scripts then begin to run selection menus that drive installation of selections
#
# test files and directories
# http://tecadmin.net/bash-shell-test-if-file-or-directory-exists/#
#

### Stuff below this line should be converted to whiptail or other clui ###

## clear screen
clear;


## begin magical code land ##

function setNewtColors {
  ##         set ncurses/newt/whiptail colors             ##
  # locates color config file and replaces text inline     #
  echo -ne "setting up newt colors... \r";
  sudo sed -i 's/magenta/grey/g' /etc/newt/palette.ubuntu ;
  #                                                        #
  ##                                                      ##
}

function installGit {
  clear;
  ### this block installs git until script is updated to check if git is installed
  echo;echo "checking for updates... ";
  sudo apt-get -qq update > /dev/null  2>&1; wait;
  echo -ne "...                                 \r";
  echo -ne "installing git... \r";
  sudo apt-get -qq install git; wait;
  echo -ne "git installed!      \r";
  ###
}

function preproutine {
  echo -ne "...                                 \r";
  echo -ne "making gitstuff folder... \r";sleep 1;
  [ ! -d ~/gitstuff ] && mkdir ~/gitstuff;

  echo -ne "opening gitstuff folder... \r"; sleep 1;
  cd ~/gitstuff;

  echo -ne "...                                 \r";
  echo -ne "installing bmenu... \r"; sleep 1;
  [ ! -d ~/gitstuff/bmenu ] && git clone https://github.com/bartobri/bmenu.git;wait;

  echo -ne "locating bmenu src... \r"; sleep 1;
  cd ~/gitstuff/bmenu/src/;
  echo -ne "building bmenu app... \r"; sleep 1;
  make; wait;
  echo -ne "...                                 \r";
  echo -ne "installing bmenu... \r"; sleep 1;
  sudo cp ./bmenu /usr/bin/;
  echo -ne "...                                 \r";
  echo -ne "bmenu installed! \r";sleep 1;

  echo;echo -ne 'here we go... \r'
  sleep .5
  echo -ne 'here we go... ... \r'
  sleep .5
  echo -ne 'here we go... ... ... \r'
  sleep .5
  echo -ne 'here we go... ... ... ...\r'
  echo -ne '\n'

  echo "Preprep has finished!"
  echo "Please run the following to continue setup:"
  echo "  bmenu -c ~/gitstuff/preprep/.bmenu "
}

whiptail --title "Preprep Setup" --checklist --separate-output "Check Options: (arrows/space/tab/enter)" 10 50 3 \
"Git" "Install Git" off \
"Preprep" "Run Preprep" off \
"DarkTheme" "Set newt palette colors" off 2>results

while read choice
do
        case $choice in
                DarkTheme) setNewtColors
                ;;
                Git) installGit
                ;;
                Preprep) preproutine
                ;;
                *)
                ;;
        esac
done < results

echo "Preprep has closed.";
