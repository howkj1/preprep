#!/bin/bash

# preprepfunctions.sh is a helper for preprep.sh
# preprepfunctions.sh should be called from the preprep utilities
# and is not meant to be a standalone script.
#
# git clone https://github.com/howkj1/preprep.git
#

## begin magical code land ##

####    imports    ####

## macify.sh ##
. ./macify.sh --source-only
#
# install_ppa; / install_wallpapers; / install_macbuntuTheme;
# install_icons; / install_cursors; / install_launchpad;
# install_spotlight; / install_dock; / install_applemenu;
# install_applelogolauncher; / install_tools; / install_librefonts;
# install_macfonts; / install_allmacstuff;
## end of macify.sh ##
#### end of imports ####

function installGit {
  clear;
  ### this block installs git until script is updated to check if git is installed
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

function gitstuffdir {
  echo -ne "...                                 \r";
  echo -ne "making gitstuff folder... \r";sleep 1;
  [ ! -d ~/gitstuff ] && mkdir ~/gitstuff;

  echo -ne "opening gitstuff folder... \r"; sleep 1;
  cd ~/gitstuff;
}

# Installs and launches bmenu
# this could be modified to strictly use whiptail instead
# but I like bmenu and want it available, so here it is.
function installbmenu {
  [ ! -d ~/gitstuff ] && gitstuffdir; #might be overkill?
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
  # echo "Please run the following to continue setup:"
  # echo "  bmenu -c ~/gitstuff/preprep/.bmenu "
}

function set_wallpaper_matrix {
  # set wallpaper to Matrix
  echo "";
  echo -en "downloading matrix wallpaper\r";
  wget -P ~/Pictures/ -O matrix.jpg http://cdn.wonderfulengineering.com/wp-content/uploads/2014/04/code-wallpaper-16.jpg;
  [ -f ~/Pictures/matrix.jpg ] && gsettings set org.gnome.desktop.background picture-uri file://~/Pictures/matrix.jpg;
  echo "wallpaper set to: Matrix          ";
}

function set_wallpaper_mac {
  # set wallpaper to Matrix
  echo "";
  [ -f ~/Pictures/mbuntu-3.jpg ] && gsettings set org.gnome.desktop.background picture-uri file://~/Pictures/mbuntu-3.jpg;
  echo "wallpaper set to: mac";
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
  set_wallpaper_matrix; # NOTE this sets wallpaper and should be a choice of which wallpaper
# macify functions go here ________ !

  echo;
  echo "Preprep has finished!";
}

function fullyAutomaticShotgun {
  # installGit; #comes standard on ubuntu1604-desktop ?
  fix_locale; # NOTE this should be updated as a config choice for vagrant vs hardware
  preproutine;
  install_allmacstuff;
  echo "Bang!";
}

# TODO extend checklist to include more of the newly added functions
function customizeShotgun {
  whiptail --title "Preprep Setup" --checklist --separate-output "Check Options: (arrows/space/tab/enter)" 10 50 2 \
      "Git" "Install Git " off \
      "Preprep" "Run Preprep " off \
    2>lastrun

  while read choice
  do
          case $choice in
                  Git) installGit
                  ;;
                  Preprep) preproutine
                  ;;
                  *)
                  ;;
          esac
  done < lastrun

  echo "Preprep has closed.";
}
