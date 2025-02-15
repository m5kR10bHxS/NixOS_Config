# ./user-QT_programs.nix
# Native for KDE and LXQT

{ config, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;    # Spotify

  # Adding packages with this method adds them to your path.
  environment.systemPackages = with pkgs; [
    aisleriot
    alacritty
#    cinnamon.nemo-with-extensions
    clipgrab
    firefox
    free42    # Reverse Polish calculator
#    geany
    git
    glib #gnome weather requires gapplication, which is provided by glib (and is not available in Kde by default)
#   gnome.gnome-sudoku
    gnome-system-monitor
    gnome-weather
    gparted
    htop
    inconsolata
    invidious    # Front end for the plasmatube youtube viewer
    inxi
    kanata    # Keyboard remapping
    kdePackages.isoimagewriter    # Write ISO image files
    kdePackages.kalarm    # Alarm clock
    kdePackages.kcharselect    # Select special characters from installed fonts
    kdePackages.kdf    # Storage information
    kdePackages.kmahjongg    # Mahjongg
    kdePackages.kmines    # Mine sweeper
    kdePackages.kpat    # Patience card games
    kdePackages.ksudoku    # Sudoku
    kdePackages.ksystemlog
    kdePackages.ktimer    # Countdown timer
#    kdePackages.ktouch    # Typing tutor - broken?!?!?!
    kdePackages.kweather    # Weather forecast
    kdePackages.plasmatube    # Youtube video viewer
    keepassxc
    keymapviz    # QMK
#    kicad
#    kicadAddons.kikit-library
    kitty
    kmplayer
    ladybird
    libreoffice
    libusb-compat-0_1    # Req'd in oredr to flash MCUs
    lshw
    pciutils
    pithos
    python3
#    qmk   /* qmk_hid qmk-udev-rules */
    ranger
#    rpcalt    # Simple reverse Polish calculator - NOT in NixOS repo!
    spotify
#   weather    # Is this QT weather, or GTK weather?
  ];

}
