# ./budgie-desktop.nix

{ config, pkgs, ... }:

{

  # Enable the Budgie desktop environment
  services.xserver = {
    enable = true;                         # Enable X11 and Wayland services.
    displayManager.lightdm.enable = true;
    desktopManager.budgie.enable = true;
  # libinput.enable = true;                # Manually enable the touchpad if necessary.
  };

}
