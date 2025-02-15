# ./lxqt-desktop.nix

{ config, pkgs, ... }:

{

  # Enable the LXQt desktop environment
  services.xserver = {
    enable = true;                         # Enable X11 and Wayland services.
    displayManager.lightdm.enable = true;
    desktopManager.lxqt.enable = ture;
  #  libinput.enable = true;               # Manually enable the touchpad if necessary.
  };

  programs.nm-applet.enable = true;        # Enable the network manager applet.

}

/*
# ./kde-desktop.nix

{ config, pkgs, ... }:

{

  # Enable the KDE Plasma 5 desktop environment
  services = {
    displayManager.sddm.enable = true;
      xserver = {
      enable = true;                         # Enable X11 and Wayland services.
      desktopManager.plasma5.enable = true;
  #    libinput.enable = true;               # Manually enable the touchpad if necessary.
       };
  };


}
*/
