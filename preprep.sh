#!/bin/bash

# https://github.com/howkj1/preprep.git
# preprep.sh installs the packages and preparations needed for the rest of deployment.

# preprep depends on preprepfunctions.sh and macify.sh

# bmenu or whiptail needs to set its next script perms to +x
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

## clear screen
clear;


## begin magical code land ##

####    imports    ####
prepDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

## preprepfunctions.sh: ##
. $prepDIR/preprepfunctions.sh --source-only;
# installGit / preproutine / installbmenu
# fix_locale
# fullyAutomaticShotgun / customizeShotgun

#### end of imports ####


# function setscriptperms {
#   # if file exists, ensure executable
#   ## only run this function if import complains
#   [ -f ./preprepfunctions.sh ] && chmod +x ./preprepfunctions.sh;
#   [ -f ./macify.sh ] && chmod +x ./macify.sh;
# }


function move_preprep_to_gitstuff {
  # moves, copies, or clones preprep scripts and deps into ~/gitstuff/preprep/
  echo "creating local preprep in ~/gitstuff/preprep/";
  gitstuffdir;
  [ ! -d ~/gitstuff/preprep ] && cd ~/gitstuff && git clone https://github.com/howkj1/preprep.git;
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


##### Statements Below This Line Kicks Off The Whole Shebang! #####

### old way with yes/no ###
# TODO change this to menus?

# if (whiptail --title "Auto / Custom" --yesno "Yes To Pull The Trigger / Customize Options" --yes-button "Auto" --no-button "Custom" 8 78)
# then
#   echo "fully automatic shotgun engaged!...";
#   echo "please wait...";
#   gitstuffdir
#   fullyAutomaticShotgun;
# else
#   customizeShotgun;
# fi;
### end of old way with yes/no ###


#########################
### new way with menu ###

## example 1
# whiptail --title "Menu example" --menu "Choose an option" 25 78 16 \
# "<-- Back" "Return to the main menu." \
# "Add User" "Add a user to the system." \
# "Modify User" "Modify an existing user." \
# "List Users" "List all users on the system." \
# "Add Group" "Add a user group to the system." \
# "Modify Group" "Modify a group and its list of members." \
# "List Groups" "List all groups on the system."
## end example 1

## working example 2 from preprepfunctions.sh customizeShotgun()
# whiptail --title "Preprep Setup" --checklist --separate-output "Check Options: (arrows/space/tab/enter)" 10 50 2 \
#     "Git" "Install Git " off \
#     "Preprep" "Run Preprep " off \
#   2>lastrun
#
# while read choice
# do
#         case $choice in
#                 Git) installGit
#                 ;;
#                 Preprep) preproutine
#                 ;;
#                 *)
#                 ;;
#         esac
# done < lastrun
#
# echo "Preprep has closed.";
## end example 2

## Cheatsheet:
## A; B    Run A and then B, regardless of success of A
## A && B  Run B if A succeeded
## A || B  Run B if A failed
## A &     Run A in background.


## 1. ask user if they wish to fix locales and reboot or continue with preprep
## 2. clone preprep into ~/gitstuff/preprep and launch preprep from there without shell inception (quit preprep from current dir)
## 3. ...

# 1.
if (whiptail --title "Preprep Begin" --yesno "Preprep Assumes Ubuntu 16.04 w/ Unity" --yes-button "Continue Preprep" --no-button "quit" 8 78)
then
  customizeShotgun;
else
  # boxcutter_repair; # FIXME hitting esc coninues running this!
  echo "You have quit preprep."
fi;

# 2.

# 3.


### end new way menu ###
#########################
