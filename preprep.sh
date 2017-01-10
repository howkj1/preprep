#!/bin/bash

# https://github.com/howkj1/preprep.git
# preprep.sh installs the packages and preparations needed for the rest of deployment.

# preprep depends on preprepfunctions.sh and macify.sh

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

####    imports    ####
prepDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

## preprepfunctions.sh: ##
. $prepDIR/preprepfunctions.sh --source-only;
# installGit / preproutine / installbmenu
# fix_locale
# fullyAutomaticShotgun / customizeShotgun

#### end of imports ####


##### Statements Below This Line Kicks Off The Whole Shebang! #####


if (whiptail --title "Preprep Begin" --yesno "Preprep is here to help! However, Preprep Assumes Ubuntu 16.04 w/ Unity desktop and comes witout warranty nor liability. Use at your own risk." --yes-button "Continue Preprep" --no-button "quit" 8 78)
then
  main_menu;
else
  echo "You have quit preprep." # quits right away
fi;

### end menu ###
#########################
