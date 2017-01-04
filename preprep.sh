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

#!/bin/bash

# function setNewtColors {
#   ##         set ncurses/newt/whiptail colors             ##
#   # locates color config file and replaces text inline     #
#   echo -ne "setting up newt colors... \r";
#   sudo sed -i 's/magenta/grey/g' /etc/newt/palette.ubuntu ;
#   #                                                        #
#   ##                                                      ##
# }
#
# function installGit {
#  echo "running glens function"
# }
#
#
# function thirdroutine {
#
# }
#
# whiptail --title "Preprep Setup" --checklist --separate-output "Check Options:" 20 78 15 \
# "Dark Theme" "Set newt palette colors" on \
# "Git" "Install Git" off \
# "Preprep" "Run Preprep" off 2>results
#
# while read choice
# do
#         case $choice in
#                 Dark Theme) setNewtColors
#                 ;;
#                 Git) installGit
#                 ;;
#                 Preprep) thirdroutine
#                 ;;
#                 *)
#                 ;;
#         esac
# done < results
#


## begin magical code land ##

clear
RETVAL=$(whiptail --title "Make a selection and Enter" \
--menu "Menu Script" 10 50 4 \
"a" "install git" \
"b" "run preprep" \
"c" "I am The Machine" \
"d" "whiptail stuff" \
3>&1 1>&2 2>&3)

# Below you can enter the corresponding commands

case $RETVAL in
  a)
    clear;
    ### this block installs git until script is updated to check if git is installed
    echo;echo -ne "checking for updates... \r";
    sudo apt-get -qq update > /dev/null  2>&1; wait;
    echo -ne "...                                 \r";
    echo -ne "installing git... \r";
    sudo apt-get -qq install git; wait;
    echo -ne "git installed!      \r";
    ###
    ~/gitstuff/preprep/preprep.sh;;

  b)
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

    bmenu -c ~/gitstuff/preprep/.bmenu ;;

  c)
    echo "I Am The Machine!";;
  d)
    whiptail --title "Rockin" --msgbox "Rock Star" 10 50;;
  *)
    echo "You have quit preprep.";;
esac
