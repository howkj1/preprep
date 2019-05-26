# preprep

Prep's vanilla Ubuntu to gets the system ready for development.

Primarily and originally for making my laptop install portable in case it gets nuked.

developed on Ubuntu 16.04 LTS / 18.04 LTS

designed with developers in mind:
* options to customize system
* runs completely from terminal
* cli gui prevents mistakes
* scripts have practical and functional examples making extending preprep a breeze


# https://github.com/howkj1/preprep.git
* preprep.sh installs the packages and preparations needed for the rest of deployment.

* bmenu or whiptail needs to set its script perms to +x
* scripts then begin to run selection menus that drive installation of selections
*
* test files and directories
* http://tecadmin.net/bash-shell-test-if-file-or-directory-exists/#
*
* whiptail
* https://en.wikibooks.org/wiki/Bash_Shell_Scripting/Whiptail

### Stuff below this line should be converted to whiptail or other clui ###

* Here's how to import additional functions :
* . ./filename.sh --source-only

** Cheatsheet:
** A; B    Run A and then B, regardless of success of A
** A && B  Run B if A succeeded
** A || B  Run B if A failed
** A &     Run A in background.



# TODO

## App Design :

 main menu
  # custom
  # repair
    ##--> checkbox menu
      ###--> macify sub checkbox menu? (or just show all?)
  # auto # TODO whiptail progress bar for auto.
  # quit
