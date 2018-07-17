#!/bin/bash

# preprepfunctions is a helper for preprep.sh
# preprepfunctions should be called from the preprep utilities
# and is not meant to be a standalone script.
#
# git clone https://github.com/howkj1/preprep.git
#

## begin magical code land ##

export NEWT_COLORS='
window=,black
border=white,blue
textbox=white,black
button=white,magenta
title=black,white
label=black,white
actsellistbox=white,brown
'

####    imports    ####
prepDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

## commonfunctiohs.lib ##
. $prepDIR/commonfunctions.lib --source-only;
. $prepDIR/pfunctions1804.lib --source-only;
##

#### end of imports ####

function sheep_prep {

  preproutine;

  sudo apt update;
  installGit;
  gitstuffdir;
  move_preprep_to_gitstuff;
  # installbmenu;

  install_vncserver;
  install_openssh;
  ssh_keygen;

  install_javajre;
  install_sheepit;

  # install_chromium18;
  # install_googlechrome18;
  install_tmux18;

  echo "preprep has completed!";
}

function update_sheepit {
  # sheepit render farm client
  echo "";
  echo -en "downloading latest sheepit render client\r";
  wget -P ~/ https://www.sheepit-renderfarm.com/media/applet/sheepit-client-5.620.2885.jar;
  # wget -P ~/ https://www.sheepit-renderfarm.com/media/applet/client-latest.php;
  echo "latest sheepit client installed.                    ";
}

function farm_sheep {
  ### autofire render agent ###
  cd ~/;
  [! -d ~/old-sheepits] && mkdir ~/old-sheepit;
  mv ~/sheepit-client-* ~/old-sheepit/;
  update_sheepit;
  SHEEPIT="$(printf "%s\n" sheep* | head -1)";
  echo "I Am The Machine!";
  java -jar $SHEEPIT -ui text -login howkj1 -password EjsndbGhL05UpZvPEgkoBcuBgNDlByEPQ8OtKJFg
  #######################
}

function main_sheep_menu {
  # visible menu options:
  RETVAL=$(whiptail --title "Make a selection and Enter" \
  --menu "Main Menu" 12 50 4 \
  "1." "Build Rendering Machine -->" \
  "2." "Run the latest SheepIt -->" \
  "3." "Download Latest SheepIt -->" \
  "4." "Quit" \
  3>&1 1>&2 2>&3)

  # Below you can enter the corresponding commands
  case $RETVAL in
      # a) echo "custom menu goes here"; whiptail --title "cutom menu" --msgbox "goes here" 10 50;;
      1.) sheep_prep;;
      2.) farm_sheep;;
      3.) update_sheepit;;
      4.) echo "You have quit preprep.";;
      *) echo "Preprep has quit.";
  esac
}

#### Intro Info Menu + Disclaimer ####
if (whiptail --title "Disclaimer" --yesno "This utility script comes without warranty nor liability. \n\n                 Use at your own risk." --yes-button "Continue" --no-button "quit" 10 62)
then
  main_sheep_menu;
else
  echo "You have quit preprep." # quits right away
fi;
### end menu ###
#########################
