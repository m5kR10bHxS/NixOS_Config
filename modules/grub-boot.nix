# ./modules/grub.nix

{ config, lib, pkgs, … }:

{
  boot = {
    supportedFilesystems = [ “bcachefs” ];        # Bcachefs support
    kernel.sysctl = { "vm.swappiness" = 10; };    # Set virtual memory (swap) swappiness value
    kernelPackages = pkgs.linuxPackages_latest;   # Install latest kernel and associated packages
    loader.grub = {
      enable = true;
      device = “/dev/sda”;
      useOSProber = true;                         # Probe for other bootable installs
    };
  };

}

# Best option for dual/multi-booting.
