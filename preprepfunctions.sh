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
# install_applelogolauncher; / install_tweak_tools; / install_librefonts;
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

function prep_reboot {
  #extensible reboot routine.
  #reboot the machine!
  sudo shutdown -r now;
}

function boxcutter_repair {
  # repair routine for vagrant boxcutter/ubuntu1604-desktop
  echo "repairing terminal...";
  echo "please wait...";
  fix_locale;
  # move_preprep_to_gitstuff;
  # echo "rebooting...";sleep .5;
  echo "please logout or reboot to finish locale repair.";
  # echo "please run preprep after reboot to finish routines.";
  # echo "~/gitstuff/preprep/preprep.sh";
  # sleep 3;
  # prep_reboot;
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
  [ ! -f ~/Pictures/matrix.jpg ] && wget -P ~/Pictures/ http://cdn.wonderfulengineering.com/wp-content/uploads/2014/04/code-wallpaper-16.jpg;
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

function autohide_launcher {
  # set Ubuntu Unity Launcher to Auto-hide
  gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-hide-mode 1
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
  sudo apt-get -qq -y install espeak;
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

function ssh_keygen {
  #generate ssh rsa keys
  your_email=$(whiptail --inputbox "Enter your full email address (yourname@gmail.com)" 8 78 email --title "SSH KeyGen" \
  3>&1 1>&2 2>&3)
  # A trick to swap stdout and stderr.
  exitstatus=$?
  if [ $exitstatus = 0 ]; then
      echo "User selected Ok and entered " $your_email
      ssh-keygen -t rsa -b 4096 -C $your_email
      ssh-add ~/.ssh/id_rsa
      sudo apt-get -qq -y install xclip
      xclip -sel clip < ~/.ssh/id_rsa.pub
  else
      echo "User selected Cancel."
  fi
  # echo "(Exit status was $exitstatus)"
}

function install_dconf_editor {
  # dconf-editor is a gui registry editor
  sudo apt-get -qq -y install dconf-editor;
}

function install_spotify {
  # Spotify music player
  # https://www.spotify.com/us/download/linux/
  # 1. Add the Spotify repository signing key to be able to verify downloaded packages
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
  # 2. Add the Spotify repository
  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
  # 3. Update list of available packages
  sudo apt-get update
  # 4. Install Spotify
  sudo apt-get -qq -y install spotify-client;
}

function install_redshift {
  # redshift reduces eyestrain by modifying display colors
  # redshift is an alternative to f.lux (flux)
    # http://ubuntuhandbook.org/index.php/2016/03/install-f-lux-in-ubuntu-16-04/
    # sudo add-apt-repository ppa:nathan-renniewaldock/flux
    # sudo apt-get install fluxgui ;
  sudo apt-get -qq -y install redshift redshift-gtk ;
  # https://github.com/jonls/redshift/issues/158
}

function install_openssh {
  # openssh server
  sudo apt-get -qq -y install openssh-server ;
}

function install_nautilus_image_manipulator {
  # adds image editing functions directly into nautilus file browser
  # these are similar to Mac Finder automation options
  # this tool can help you create thumbnails extremely quick
  sudo apt-get -qq -y install nautilus-image-manipulator nautilus-image-converter;
  sudo killall nautilus;
}

function install_pyrenamer {
  # pyrenamer can quickly rename files in a folder given a pattern
  # example is renaming all .jpeg to .jpg
  # or you could skip this and use rename function:
  # rename 's\thumb/\thmb/' *

  sudo apt-get -qq -y install pyrenamer;
  # pyrenamer ;
}

function install_atom {
  # http://tipsonubuntu.com/2016/08/05/install-atom-text-editor-ubuntu-16-04/
  # https://github.com/atom/atom
  # https://atom.io/
  sudo add-apt-repository ppa:webupd8team/atom;
  sudo apt update;
  sudo apt install atom;
}

function install_chromium {
  # chromium open source browser
  sudo apt-get -qq -y install chromium-browser;
}

function install_slack {
  # slack chat messenger
  sudo apt-get -qq -y install slack;
}

function install_javajre {
  #install java jre 8
  sudo apt -qq -y install openjdk-8-jre-headless;
}

function install_sheepit {
  # sheepit render farm client
  echo "";
  echo -en "downloading sheepit render client\r";
  [ ! -f ~/sheepit-client-5.590.2883.jar ] && wget -P ~/ https://www.sheepit-renderfarm.com/media/applet/sheepit-client-5.590.2883.jar;
  echo "sheepit client installed.                    ";
}


function install_tmux {
  #install tmux
  sudo apt -qq -y install tmux;
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

  # gitstuffdir;wait;
  # installbmenu;wait;

  # echo;
  # echo "Preprep has finished!";
}

function fullyAutomaticShotgun {
  # installGit; #comes standard on ubuntu1604-desktop ?
  preproutine;

  sudo apt-get update;
  fix_locale;
  gitstuffdir;
  move_preprep_to_gitstuff;
  installbmenu;
  set_wallpaper_matrix;
  install_allmacstuff;
  install_hangups;
  autohide_launcher;
  install_vncserver;
  ssh_keygen;
  install_dconf_editor;
  install_nautilus_image_manipulator;
  install_redshift;
  install_openssh;
  install_chromium;
  install_atom;
  install_pyrenamer;
  install_slack;
  install_spotify;
  install_espeak;

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
  --checklist --separate-output "Select all desired apps/settings to be installed:" 20 50 8 \
  "1." "apt-get update" off \
  "2." "Repair gnome-terminal locales" off \
  "3." "build ~/gitstuff" off \
  "4." "install preprep locally" off \
  "5." "install bmenu" off \
  "6." "set wallpaper: matrix" off \
  "7." "take the redpill" off \
  "8." "set wallpaper: mac" off \
  "9." "install hangups - cli gchat" off \
  "10." "install vncserver" off \
  "11." "install espeak" off \
  "12." "install ALL mac stuff" off \
  "13." "|- install noobslab ppa" off \
  "14." "|- install mac wallpapers" off \
  "15." "|- install mac theme" off \
  "16." "|- install mac icons" off \
  "17." "|- install launchpad" off \
  "18." "|- install spotlight" off \
  "19." "|- install dock" off \
  "20." "|- install apple logo" off \
  "21." "|- install tweak tools" off \
  "22." "|- install libre fonts" off \
  "23." "|- install mac fonts" off \
  "24." "|- set mac themes" off \
  "25." "ssh rsa keygen" off \
  "26." "install dconf-editor" off \
  "27." "install spotify" off \
  "28." "install redshift" off \
  "29." "install openssh server" off \
  "30." "install nautilus image editing" off \
  "31." "install pyrenamer" off \
  "32." "install Atom IDE" off \
  "33." "install chromium browser" off \
  "34." "install slack chat" off \
  "35." "set autohide Unity launcher" off \
  "36." "install java jre 8" off \
  "37." "install sheepit render client" off \
  "38." "install tmux" off \
  3>&1 1>&2 2>&3)
  # Below you can enter the corresponding commands

  # http://www.gnu.org/software/bash/manual/bashref.html#Conditional-Constructs
  # If the ‘;;’ operator is used, no subsequent matches are attempted after the first pattern match.
  # Using ‘;&’ in place of ‘;;’ causes execution to continue with the command-list associated with the next clause, if any.
  # Using ‘;;&’ in place of ‘;;’ causes the shell to test the patterns in the next clause, if any, and execute any associated command-list on a successful match.

  for thing in $RETVAL
    do
    case $thing in
        # 1.) echo "mac menu goes here"; whiptail --title "cutom menu" --msgbox "goes here" 10 50;;
        1.) sudo apt-get update;;
        2.) fix_locale;;
        3.) gitstuffdir;;
        4.) move_preprep_to_gitstuff;;
        5.) installbmenu;;
        6.) set_wallpaper_matrix;;
        7.) redpill;;
        8.) set_wallpaper_mac;;
        9.) install_hangups;;
        10.) install_vncserver;;
        11.) install_espeak;;
        12.) install_allmacstuff;;
        13.) install_ppa;;
        14.) install_mac_wallpapers;;
        15.) install_macbuntuTheme;;
        16.) install_icons;;
        17.) install_launchpad;;
        18.) install_spotlight;;
        19.) install_dock;;
        20.) install_applelogolauncher;;
        21.) install_tweak_tools;;
        22.) install_librefonts;;
        23.) install_macfonts;;
        24.) set_macthemes;;
        25.) ssh_keygen;;
        26.) install_dconf_editor;;
        27.) install_spotify;;
        28.) install_redshift;;
        29.) install_openssh;;
        30.) install_nautilus_image_manipulator;;
        31.) install_pyrenamer;;
        32.) install_atom;;
        33.) install_chromium;;
        34.) install_slack;;
        35.) autohide_launcher;;
        36.) install_javajre;;
        37.) install_sheepit;;
        38.) install_tmux;;

        *) main_menu;;
    esac
  done

}


###>>>> this format works for whiptail menus >>>>>
function main_menu {

  RETVAL=$(whiptail --title "Make a selection and Enter" \
  --menu "Main Menu" 10 50 4 \
  "1." "Custom Install menu -->" \
  "2." "Repair gnome-terminal locales - fix boxcutter" \
  "3." "Install Everything! - be careful!" \
  "4." "quit preprep" \
  3>&1 1>&2 2>&3)

  # Below you can enter the corresponding commands

  case $RETVAL in
      # a) echo "custom menu goes here"; whiptail --title "cutom menu" --msgbox "goes here" 10 50;;
      1.) customize_menu;;
      2.) boxcutter_repair;;
      3.) fullyAutomaticShotgun;;
      4.) echo "You have quit preprep.";;
      *) echo "Preprep has quit.";
  esac
  # c) echo "I Am The Machine!";;

}
###<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
