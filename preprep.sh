#!/bin/bash

# https://github.com/howkj1/preprep.git
# preprep.sh installs the packages and preparations needed for the rest of deployment.

# bmenu or whiptail needs to set its script perms to +x
# scripts then begin to run selection menus that drive installation of selections
#
# test files and directories
# http://tecadmin.net/bash-shell-test-if-file-or-directory-exists/#
#
# whiptail
# https://en.wikibooks.org/wiki/Bash_Shell_Scripting/Whiptail

### Stuff below this line should be converted to whiptail or other clui ###

# Here's how to import additional functions :
#. ./filename.sh --source-only

## Cheatsheet:
## A; B    Run A and then B, regardless of success of A
## A && B  Run B if A succeeded
## A || B  Run B if A failed
## A &     Run A in background.

## clear screen
clear;

## begin magical code land ##

export NEWT_COLORS='
root=,black
shadow=,black
window=,black
border=white,blue
textbox=white,black
button=white,magenta
title=white,blue
label=black,white
actsellistbox=white,brown
'


####    imports    ####
prepDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

## preprep function dependencies: ##
. $prepDIR/commonfunctions.lib --source-only;
. $prepDIR/pfunctions1604.lib --source-only;
. $prepDIR/pfunctions1804.lib --source-only;
. $prepDIR/pfunctions2019.lib --source-only;


#### end of imports ####

##### Statements Below This Line Kicks Off The Whole Shebang! #####
###>>>> whiptail menus >>>>>
function main_menu {

  RETVAL=$(whiptail --title "Make a selection and Enter" \
  --menu "Main Menu" 12 50 3 \
  "1." "Ubuntu 2019      -->" \
  "2." "Ubuntu 18.04 lts -->" \
  "3." "Ubuntu 16.04 lts -->" \
  "4." "RenderFarm       -->" \
  3>&1 1>&2 2>&3)

  # Below you can enter the corresponding commands

  case $RETVAL in
      # a) echo "custom menu goes here"; whiptail --title "cutom menu" --msgbox "goes here" 10 50;;
      1.) main_menu_2019;;
      2.) main_menu_1804;;
      3.) main_menu_1604;;
      4.) $prepDIR/sheepfarm.sh;;
       *) echo "Preprep has quit.";
  esac
  # c) echo "I Am The Machine!";;

}
###<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

#### Intro Info Menu + Disclaimer ####
if (whiptail --title "Preprep Begin" --yesno \
"                Preprep is here to help! \
\nHowever, Preprep comes without warranty nor liability.\
\n                  Use at your own risk." \
 --yes-button "Continue Preprep"\
 --no-button "quit" 10 60)
then
  main_menu;
else
  echo "You have quit preprep." # quits right away
fi;
### end menu ###
#########################
