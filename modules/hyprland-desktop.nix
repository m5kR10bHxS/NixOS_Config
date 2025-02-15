# ./hyprland-desktop.nix

{ config, pkgs, ... }:

{
  imports = [

  ];

  services.xserver = {
    enable = true;                                        # Enable X11 and Wayland services.
    displayManager.sddm.enable = true;    # Enable the SDDM display manager. SDDM must be  ⩾ v0.20.0
  #  libinput.enable = true;                         # Manually enable the touchpad if necessary.
  };

  programs = {
    hyprland.enable = true;                        # Enable the Hyprland compositor
    hyprland.portalPackage = true;             # Enable the Hyprland xdg portal
    nm-applet.enable = true;                      # Enable network manager applet
    nvidiaPatches = true;                            # Apply available patches
    xwayland.enable = true;                       # Enable xWayland
  };

  environment.sessionVariables = {
    NIXOS_OZONE_ML = "1";                        # Application hint to use Wayland, instead of xWayland
    WLR_NO_HARDWARE_CURSORS = "1";  # If your cursor becomes invisible
  };

  environment.systemPackages = with pkgs; [
    dunst                                             # Notifications
    grim                                               # Snapshot desktop utility
    hyprshade                                     # Adjusts color temperature
    kdePackages.systemsettings        # System settings
    libnotify                                         # Notifications dependency
    nwg-look                                        # Wayland compatible GTK3 settings editor
    polkit.kde-agent                            # Policy kit
    qt5-wayland                                  # qt library
    qt6-wayland                                  # qt library
    rofi-wayland                                  # Wayland app launcher
    seat                                               # Seat manager
    slurp                                              # Select area for snapshot - works with grim
    swww                                             # Wayland wallpaper damon
    udiskie                                           # Front end for udisks2
    udisks2                                          # Auto mounter for USB sticks and such
    wl-copy                                         # xclip for screenshots - works with grim
    wl-logout                                       # Logout menu
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true;"];    # Vimjoyer
      })
    )

    # To make a screen shot, select the desired area and then:
    # grim -l 0 -g "$(slurp)" - | wl-copy

  ];

  fonts.packages = with pkgs; [
    font-awesome
    inconsolata
    nerdfonts
    ttf-liberation
    terminus_font
    ];
  };

  hardware = {                  # Thanks to vimjoyer
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;                         # Requried for Hyprland!
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;    # Required for Hyprland!
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    exec-once=bash ~/.config/hypr/start.sh
    # Create the start.sh script:
    # $ touch ~/.config/hypr/start.sh
    # $ chmod +x ~/.config/hypr/start.sh
    #
    #!/usr/bin/env bash
    swww init &                        # Init the wallpaper damon
    sww img ~/Wallpaper/gruvbox-mountain-village.png &
    nm-applet --indicator &      # init the network manager applet
    waybar &                            # init the waybar
    dunst                                  # init messaging

}

  # LibrePhoenix snippit follows:
{ inputs, pkgs, ... }:

{
  # Import wayland config
  imports = [ ./wayland.nix
                     ./pipewire.nix
                     ./dbus.nix
                   ];

  # Security
  security = {
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
#    pam.services.gtklock = {};
    pam.services.login.enableGnomeKeyring = true;
  };

  services.gnome.gnome-keyring.enable = true;

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland = {
        enable = true;
      };
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  };
}

  # Wayland.nix follows:

  { config, pkgs, ... }:

{
  imports = [ ./pipewire.nix
              ./dbus.nix
              ./gnome-keyring.nix
              ./fonts.nix
            ];

  environment.systemPackages = with pkgs;
    [ wayland waydroid
      (sddm-chili-theme.override {
        themeConfig = {
          background = config.stylix.image;
          ScreenWidth = 1920;
          ScreenHeight = 1080;
          blur = true;
          recursiveBlurLoops = 3;
          recursiveBlurRadius = 5;
        };})
    ];

  # Configure xwayland
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
      options = "caps:escape";
    };
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = true;
      theme = "chili";
      package = pkgs.sddm;
    };
  };
}

# Fonts.nix follows:

{ pkgs, ... }:

{
  # Fonts are nice to have
  fonts.packages = with pkgs; [
    # Fonts
    (nerdfonts.override { fonts = [ "Inconsolata" ]; })
    powerline
    inconsolata
    inconsolata-nerdfont
    iosevka
    font-awesome
    ubuntu_font_family
    terminus_font
  ];

}

# dbus.nix follows:

{ pkgs, ... }:

{
  services.dbus = {
    enable = true;
    packages = [ pkgs.dconf ];
  };

  programs.dconf = {
    enable = true;
  };
}

# gnome-keyring.nix follows:

{ pkgs, ... }:

{
  services.dbus = {
    enable = true;
    packages = [ pkgs.dconf ];
  };

  programs.dconf = {
    enable = true;
  };
}

# Pipewire.nix follows:

{ ... }:

{
  # Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
