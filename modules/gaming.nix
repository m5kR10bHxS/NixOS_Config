# ./gaming.nix

{ config, pkgs, ... }:

{

  programs.steam = {
    enable = true;    # Install Steam
    gamescopeSession.enable = true;    # Helps with resolution & upscaling problems
  };

  environment.systemPackages = with pkgs; [
    lutris                    # Game launcher
    mangohud           # HUD for game performance
    protonup              # Tool to dl the latest proton builds
  ];

  extraGroups = [ "gamemode" ];
  programs.gamemode = {
    enable = true;    # Gaming optimizations
    settings.general.inhibit_screensaver = 0;
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "home/user/.steam/root/compatibilitytools.d";    # Proton
  };

}

/*
To take advantage of the features, like mangohud, prepend the following commands to your Steam games:
  gamemoderun %command%
  gamescope %command%
  mangohud %command%

Configure a separate subvolume for Steam's game repo and disable COW for that subvolume.
  ~/.steam/steam/steamapps/common                         # Default location for game files on Linux.
  C:\Program Files (x86)\Steam\steamapps\common    # Default location for game files on Windows.
*/
