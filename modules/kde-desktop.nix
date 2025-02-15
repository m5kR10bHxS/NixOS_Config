# ./kde-desktop.nix

{ config, pkgs, ... }:

{

  # Enable the KDE Plasma 6 desktop
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

}

