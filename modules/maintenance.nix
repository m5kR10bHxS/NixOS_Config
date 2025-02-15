# ./maintenance.nix

{ config, pkgs, inupts, ... }:

{
/*
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
};
*/

  environment.systemPackages = with pkgs; [
    #microcodeAmd
    microcodeIntel
    nixseparatedebuginfod  # package to support capturing debug information
  ];

  hardware.cpu = {
    #amd.updateMicrocode = true;
    intel.updateMicrocode = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";    # Every Monday at midnight
    options = "--delete-older-than 5d";
  };

  nix.optimise = {
    automatic = true;
    dates = [ "03:45"];
  };

/*
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
  }
*/

}
