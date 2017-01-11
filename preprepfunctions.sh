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
# install_ppa; / install_mac_wallpapers; / install_macbuntuTheme;
# install_icons; / install_cursors; / install_launchpad;
# install_spotlight; / install_dock; / install_applemenu;
# install_applelogolauncher; / install_tools; / install_librefonts;
# install_macfonts; / install_allmacstuff;
## end of macify.sh ##
#### end of imports ####

function gitstuffdir {
  echo -ne "...                                 \r";
  echo -ne "making gitstuff folder... \r";sleep 1;
  [ ! -d ~/gitstuff ] && mkdir ~/gitstuff;
  echo -ne "opening gitstuff folder... \r"; sleep 1;
  cd ~/gitstuff;
}

function move_preprep_to_gitstuff {
  # moves, copies, or clones preprep scripts and deps into ~/gitstuff/preprep/
  echo "creating local preprep in ~/gitstuff/preprep/";
  gitstuffdir;
  [ ! -d ~/gitstuff/preprep ] && cd ~/gitstuff && git clone https://github.com/howkj1/preprep.git;
}

function fix_locale {
  # fixes: vagrant boxcutter/ubuntu1604-desktop
  # failure to load gnome-terminal
  # http://askubuntu.com/questions/765580/ubuntu-16-04-live-usb-gnome-terminal-not-opening-by-any-means
  sudo locale-gen "en_US.UTF-8";
  sudo localectl set-locale LANG="en_US.UTF-8";
  #sudo shutdown -r now;
}

function boxcutter_repair {
  # repair routine for vagrant boxcutter/ubuntu1604-desktop
  echo "repairing terminal...";
  echo "please wait...";
  fix_locale;
  move_preprep_to_gitstuff;
  echo "rebooting...";sleep .5;
  echo "please run preprep after reboot to finish routines.";
  echo "~/gitstuff/preprep/preprep.sh";
  sleep 3;
  prep_reboot;
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

function prep_reboot {
  #extensible reboot routine.
  #reboot the machine!
  sudo shutdown -r now;
}

function installbmenu {
  # Installs and launches bmenu
  # this could be modified to strictly use whiptail instead
  # but I like bmenu and want it available, so here it is.
  [ ! -d ~/gitstuff ] && gitstuffdir; #might be overkill?
  echo -ne "...                                 \r";
  echo -ne "installing bmenu... \r"; sleep 1;
  cd ~/gitstuff/;
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
  # Quote of the day :
  # "All the colors went everywhere! - Josh McCall"

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
  # https://hangups.readthedocs.io/en/stable/installation.html
  echo -ne "installing hangups... \r"
  # [ -d ~/gitstuff ] && cd ~/gitstuff;
  # git clone https://github.com/tdryer/hangups.git;
  # cd ~/gitstuff/hangups/;
  sudo apt-get -qq -y install python3-pip;
  pip3 install hangups;
  # pip install --upgrade pip;
  # pip3 install --upgrade pip;
  echo;
  echo "hangups installed.         ";
  # cd ~/gitstuff/preprep/;
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
  # TODO full auto needs some updating once custom menu is done being built!
  preproutine;
  gitstuffdir;
  set_wallpaper_mac;
  install_allmacstuff;
  install_hangups;
  echo "Bang!";
}


# main menu
  # custom
  # repair
    ##--> checkbox menu
      ###--> macify sub checkbox menu? (or just show all?)
  # auto # TODO whiptail progress bar for auto.
  # quit

function customize_menu {
  RETVAL=$(whiptail --title "Custom Install Menu" \
  --checklist "Select all desired apps/settings to be installed:" 20 50 8 \
  "a" "mac menu -->" off \
  "b" "Repair gnome-terminal locales" off \
  "c" "Install Everything! - be careful!" off \
  3>&1 1>&2 2>&3)
  # Below you can enter the corresponding commands
  case $RETVAL in
      a) echo "mac menu goes here"; whiptail --title "cutom menu" --msgbox "goes here" 10 50;;
      b) boxcutter_repair;;
      c) fullyAutomaticShotgun;;
      *) main_menu;
  esac
}


###>>>> this format works for whiptail menus >>>>>
function main_menu {

  RETVAL=$(whiptail --title "Make a selection and Enter" \
  --menu "Main Menu" 10 50 4 \
  "a" "Custom Install menu -->" \
  "b" "Repair gnome-terminal locales - fix boxcutter" \
  "c" "Install Everything! - be careful!" \
  "d" "quit preprep" \
  3>&1 1>&2 2>&3)

  # Below you can enter the corresponding commands

  case $RETVAL in
      # a) echo "custom menu goes here"; whiptail --title "cutom menu" --msgbox "goes here" 10 50;;
      a) customize_menu;;
      b) boxcutter_repair;;
      c) fullyAutomaticShotgun;;
      d) echo "You have quit preprep.";;
      *) echo "Preprep has quit.";
  esac
  # c) echo "I Am The Machine!";;

}
###<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
