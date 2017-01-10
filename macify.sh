#!/bin/bash

# macify.sh installs a modified mbuntu-y 2015 styles from noobslab
# macify.sh is designed around Ubuntu 16.04 LTS
# http://www.noobslab.com/2015/05/mbuntu-y-macbuntu-transformation-pack.html
#http://www.noobslab.com/2016/04/macbuntu-1604-transformation-pack-for.html

# macify.sh should be called from the preprep utilities
# and is not meant to be a standalone script.
# git clone https://github.com/howkj1/preprep.git
#

## begin magical code land ##

function install_ppa {
  sudo add-apt-repository -y ppa:noobslab/macbuntu;
  sudo add-apt-repository -y ppa:noobslab/themes;
  sudo apt-get update;
}

function install_mac_wallpapers {
  # #2015
  # wget -P ~/Pictures http://drive.noobslab.com/data/Mac-14.10/MBuntu-Wallpapers.zip ;
  # unzip ~/Pictures/MBuntu-Wallpapers.zip -d ~/Pictures;
  # rm ~/Pictures/MBuntu-Wallpapers.zip;

  #2016
  wget -P ~/Pictures http://drive.noobslab.com/data/Mac/MacBuntu-Wallpapers.zip ;
  unzip ~/Pictures/MacBuntu-Wallpapers.zip -d ~/Pictures;
  rm ~/Pictures/MacBuntu-Wallpapers.zip;
}

function install_macbuntuTheme {
  sudo apt-get -y install macbuntu-os-ithemes-lts-v7;
}

function install_icons {
  sudo apt-get -y install macbuntu-os-icons-lts-v7;
}

# function install_cursors {
#   #cursors come with the icons in 2016 version
# }

function install_launchpad {
  sudo apt-get -y install slingscold;
}

function install_spotlight {
  sudo apt-get -y install albert;
}

function install_dock {
  sudo apt-get -y install plank;
  sudo apt-get -y install macbuntu-os-plank-theme-lts-v7;
}

function install_applemenu {
  # this could use some cleanup / mod from the noobslab version
  # this comes straight from noobslab and isn't condensed
  cd && wget -O Mac.po http://drive.noobslab.com/data/Mac/change-name-on-panel/mac.po;
  cd /usr/share/locale/en/LC_MESSAGES; sudo msgfmt -o unity.mo ~/Mac.po;
  rm ~/Mac.po;
  cd;

  cd ~/gitstuff/preprep/;
}

function install_applelogolauncher {
  wget -O launcher_bfb.png http://drive.noobslab.com/data/Mac/launcher-logo/apple/launcher_bfb.png;
  sudo mv launcher_bfb.png /usr/share/unity/icons/;
}

function install_tools {
  sudo apt-get -y install unity-tweak-tool;
  sudo apt-get -y install gnome-tweak-tool;
}

function install_librefonts {
  sudo apt-get -y install libreoffice-style-sifr;
  # After installation go to LibreOffice menu
  # select "Tools" > "Options" > "LibreOffice" > "View"
  # and select "Sifr" under "Icon size and style".
  echo "LibreOffice font: ";
  echo "LibreOffice menu > Tools > Options > LibreOffice > View";
  echo "select Sifr under Icon size and style";
}

function install_macfonts {
  wget -O mac-fonts.zip http://drive.noobslab.com/data/Mac/macfonts.zip;
  sudo unzip mac-fonts.zip -d /usr/share/fonts; rm mac-fonts.zip;
  sudo fc-cache -f -v;
  # You can change fonts from :
  # Unity-Tweak-Tool, Gnome-Tweak-Tool or Ubuntu Tweak
  echo "You can change fonts from: ";
  echo "Unity-Tweak-Tool, Gnome-Tweak-Tool or Ubuntu Tweak";
}

function set_macthemes {
  # gtk-theme
  gsettings set org.gnome.desktop.interface gtk-theme "MacBuntu-OS-UCGM";
  # icon-theme
  gsettings set org.gnome.desktop.interface icon-theme "MacBuntu-OS";
  # window-theme
  gsettings set org.gnome.desktop.wm.preferences theme "MacBuntu-OS-UCGM";
}

function install_allmacstuff {
  install_ppa;
  install_mac_wallpapers;
  install_macbuntuTheme;
  install_icons;
  # install_cursors;
  install_launchpad;
  install_spotlight;
  install_dock;
  # install_applemenu;
  install_applelogolauncher;
  install_tools;
  install_librefonts;
  install_macfonts;
  set_macthemes;
  echo "";
  echo "all the mac stuffs!";
  echo "shiny.";
}
