# ./user-gtk_programs.nix
# Native for Budgie, Cinnamon, GNOME, Mate, Xfce, Pantheon, LXDE and Unity

{ config, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;    # Spotify

  # Adding packages with this method adds them to your path.
  environment.systemPackages = with pkgs; [
    aisleriot
    alacritty
    cinnamon.nemo-with-extensions
    clipgrab
    firefox
    free42    # Reverse Polish calculator
#    geany
    git
    gnome.gnome-sudoku
    gnome-system-monitor
    gnome-weather
    gnome_mplayer
    gparted
    htop
    inconsolata
    inxi
    isoimagewriter
    kanata    # Keyboard remapping
    kdePackages.kate
    keepassxc
    keymapviz    # QMK
    kicad
    kicadAddons.kikit-library
    kitty
    kmplayer
    ladybird
    libreoffice
    libsForQt5.dolphin
    libsForQt5.ksudoku
    libsForQt5.ktouch
    libsForQt5.polkit-kde-agent    # Dependency for kate
    libusb-compat-0_1    # Req'd in oredr to flash MCUs
    lshw
    pciutils
    pithos
    python3
#    qmk   /* qmk_hid qmk-udev-rules */
    ranger
    spotify
  ];

}
