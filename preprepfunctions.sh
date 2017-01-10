#!/bin/bash

# preprepfunctions.sh is a helper for preprep.sh
# preprepfunctions.sh should be called from the preprep utilities
# and is not meant to be a standalone script.
#
# git clone https://github.com/howkj1/preprep.git
#

## begin magical code land ##

####    imports    ####
prepDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

## macify.sh ##
. $prepDIR/macify.sh --source-only;
#
# install_ppa; / install_wallpapers; / install_macbuntuTheme;
# install_icons; / install_cursors; / install_launchpad;
# install_spotlight; / install_dock; / install_applemenu;
# install_applelogolauncher; / install_tools; / install_librefonts;
# install_macfonts; / install_allmacstuff;
## end of macify.sh ##
#### end of imports ####

function gitstuffdir {
  # Quote of the day :
  # "All the colors went everywhere! - Josh McCall"
  echo -ne "...                                 \r";
  echo -ne "making gitstuff folder... \r";sleep 1;
  [ ! -d ~/gitstuff ] && mkdir ~/gitstuff;

  echo -ne "opening gitstuff folder... \r"; sleep 1;
  cd ~/gitstuff;
}

function installGit {
  clear;
  ### this block installs git
  # TODO until script is updated to check if git is installed
  echo;echo "checking for updates... ";
  sudo apt-get -qq update > /dev/null  2>&1; wait;
  echo -ne "...                                 \r";
  echo -ne "installing git... \r";
  sudo apt-get -qq -y install git; wait;
  echo -ne "git installed!      \r";
  ###
}

function fix_locale {
  # fixes: vagrant boxcutter/ubuntu1604-desktop
  # failure to load gnome-terminal
  # http://askubuntu.com/questions/765580/ubuntu-16-04-live-usb-gnome-terminal-not-opening-by-any-means
  sudo locale-gen "en_US.UTF-8";
  sudo localectl set-locale LANG="en_US.UTF-8";
  #sudo shutdown -r now;
}

function prep_reboot {
  #extensible reboot routine.
  #reboot the machine!
  sudo shutdown -r now;
}

# Installs and launches bmenu
# this could be modified to strictly use whiptail instead
# but I like bmenu and want it available, so here it is.
function installbmenu {
  [ ! -d ~/gitstuff ] && gitstuffdir; #might be overkill?
  echo -ne "...                                 \r";
  echo -ne "installing bmenu... \r"; sleep 1;
  [ ! -d ~/gitstuff/bmenu ] && sudo apt-get -y install libncurses5-dev libncursesw5-dev;
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
  # echo "Please run the following to continue setup:"
  # echo "  bmenu -c ~/gitstuff/preprep/.bmenu "
}

function set_wallpaper_matrix {
  # set wallpaper to Matrix
  echo "";
  echo -en "downloading matrix wallpaper\r";
  wget -P ~/Pictures/ http://cdn.wonderfulengineering.com/wp-content/uploads/2014/04/code-wallpaper-16.jpg;
  echo -en "renaming matrix wallpaper    \r";
  [ -f ~/Pictures/code-wallpaper-16.jpg ] && mv ~/Pictures/code-wallpaper-16.jpg ~/Pictures/matrix.jpg;
  echo -en "setting desktop wallpaper to matrix.jpg \r";
  # [ -f ~/Pictures/matrix.jpg ] && gsettings set org.gnome.desktop.background picture-uri file://~/Pictures/matrix.jpg;
  [ -f ~/Pictures/matrix.jpg ] && gsettings set org.gnome.desktop.background picture-uri file:///home/$USER/Pictures/matrix.jpg;
  echo "wallpaper set to: Matrix                    ";
}

function enter_matrix {
  # Enter The Matrix
    echo -e "\033[2J\033[?25l"; R=`tput lines` C=`tput cols`;: $[R--] ; while true
    do ( e=echo\ -e s=sleep j=$[RANDOM%C] d=$[RANDOM%R];for i in `eval $e {1..$R}`;
    do c=`printf '\\\\0%o' $[RANDOM%57+33]` ### http://bruxy.regnet.cz/web/linux ###
    $e "\033[$[i-1];${j}H\033[32m$c\033[$i;${j}H\033[37m"$c; $s 0.1;if [ $i -ge $d ]
    then $e "\033[$[i-d];${j}H ";fi;done;for i in `eval $e {$[i-d]..$R}`; #[mat!rix]
    do echo -e "\033[$i;${j}f ";$s 0.1;done)& sleep 0.05;done #(c) 2011 -- [ BruXy ]
}

function set_wallpaper_mac {
  # set wallpaper to Matrix
  echo "";
  [ -f ~/Pictures/mbuntu-3.jpg ] && gsettings set org.gnome.desktop.background picture-uri file:///home/$USER/Pictures/mbuntu-3.jpg;
  echo "wallpaper set to: mac";
}

function install_hangups {
  # hangups = google hangouts for cli terminals
  # TODO double check this for efficiency
  echo -ne "installing hangups... \r"
  [ -d ~/gitstuff ] && cd ~/gitstuff;
  git clone https://github.com/tdryer/hangups.git;
  cd ~/gitstuff/hangups/;
  sudo apt-get -y install python3-pip;
  pip3 install hangups;
  pip install --upgrade pip;
  pip3 install --upgrade pip;
  echo;
  echo "hangups installed.         ";
  cd ~/gitstuff/preprep/;
}

function install_vncserver {
  echo;
  echo "installing tightvncserver...";
  sudo apt-get -qq -y install tightvncserver;
  echo;
  echo "tightvncserver installed.";
}

function install_espeak {
  # It Talks!
  sudo apt-get install espeak;
  espeak "you have been weighed"; wait 1;
  espeak "you have been measured"; wait 1;
  espeak "and you have been found wanting";
}

function redpill {
  # example background process
  set_wallpaper_matrix;
  enter_matrix &
  # get the PID
  BG_PID=$!
  ### HERE, YOU TELL THE SHELL TO NOT CARE ANY MORE ###
  disown $BG_PID
  ###
  sleep 5s;
  # kill it, hard and mercyless, now without a trace
  kill -9 $BG_PID;
  sleep 4;
  clear;
  echo "red pill";
}



function preproutine {
  echo;
  echo -ne "starting preproutine... \r";
  echo -ne 'here we go... \r';
  sleep .5;
  echo -ne 'here we go... ... \r';
  sleep .5;
  echo -ne 'here we go... ... ... \r';
  sleep .5;
  echo -ne 'here we go... ... ... ...\r';
  echo -ne '\n';

  gitstuffdir;wait;
  installbmenu;wait;

  echo;
  echo "Preprep has finished!";
}






function fullyAutomaticShotgun {
  # installGit; #comes standard on ubuntu1604-desktop ?
  fix_locale; # NOTE this should be updated as a config choice for vagrant vs hardware
  preproutine;
  set_wallpaper_mac; # NOTE this sets wallpaper and should be a choice of which wallpaper
  install_allmacstuff;
  install_hangups;
  echo "Bang!";
}





# TODO extend checklist to include more of the newly added functions
# function customizeShotgun {
#   whiptail --title "Preprep Setup" --checklist --separate-output \
#     "Check Options: (arrows/space/tab/enter)" 10 50 2 \
#       "Git" "Install Git " off \
#       "Preprep" "Run Preprep " off \
#     2>lastrun
#
#   while read choice
#   do
#           case $choice in
#                   Git) installGit
#                   ;;
#                   Preprep) preproutine
#                   ;;
#                   *)
#                   ;;
#           esac
#   done < lastrun
#
#   echo "Preprep has closed.";
# }


###>>>> this format works for whiptail menus >>>>>
function working_whiptail_menu {

  RETVAL=$(whiptail --title "Make a selection and Enter" \
  --menu "Menu" 10 50 4 \
  "a" "Custom Install menu -->" \
  "b" "Repair gnome-terminal locales" \
  "c" "Install VNC Server" \
  "d" "Set Wallpaper to Matrix" \
  "e" "quit preprep" \
  3>&1 1>&2 2>&3)

  # Below you can enter the corresponding commands

  case $RETVAL in
      a) echo "custom menu goes here"; whiptail --title "cutom menu" --msgbox "goes here" 10 50;;
      b) fix_locale;;
      c) install_vncserver;;
      d) redpill;;
      e) echo "You have quit preprep.";;
      *) echo "Preprep has quit.";
  esac
  # c) echo "I Am The Machine!";;

}
###<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

function customizeShotgun {
  whiptail --title "Preprep Setup" --menu \
   "Check Options: (arrows/space/tab/enter)" 10 50 3 \
      "Git" "Install Git " \
      "Preprep" "Run Preprep " \
      "Matrix" "Set Wallpaper" \
    2>lastrun

  while read choice
  do
          case $choice in
                  Git) installGit
                  ;;
                  Preprep) preproutine
                  ;;
                  Matrix) set_wallpaper_matrix
                  ;;
                  *)
                  ;;
          esac
  done < lastrun

  echo "Preprep has closed.";
}
