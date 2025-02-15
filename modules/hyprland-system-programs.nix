# ./modules/hyprland-system-programs.nix

{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    dunst
    grim
    kdePackages.systemsettings
    networkmanagerapplet
    polkit.kde-agent
    qt5-wayland
    qt6-wayland
    rofi-wayland
    seat
    swww
    udiskie
    waybar
    wl-copy
    wl-logout
  ];

  fonts = {
    fontDir.enable =true;
    fonts = with pkgs; [
      font-awesome
      nerdfonts
      ttf-liberation
    ];
  };

}
