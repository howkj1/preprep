#!/bin/bash

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

## preprepfunctions.sh: ##
. ./preprepfunctions.sh --source-only
# installGit / preproutine / installbmenu
# fullyAutomaticShotgun / customizeShotgun

#### end of imports ####


function setscriptperms {
  # if file exists, ensure executable
  [ -f ./preprepfunctions.sh ] && chmod +x ./preprepfunctions.sh;
  [ -f ./macify.sh ] && chmod +x ./macify.sh;
}

## only run this function if import complains
# setscriptperms;

##### If Statement Below This Line Kicks Off The Whole Shebang! #####

if (whiptail --title "Auto / Custom" --yesno "Yes To Pull The Trigger / Customize Options" --yes-button "Auto" --no-button "Custom" 8 78) then
  echo "fully automatic shotgun engaged!...";
  echo "please wait...";
  fullyAutomaticShotgun;
else
  customizeShotgun;
fi;
