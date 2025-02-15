# ./modules/systemd-boot.nix

{ config, lib, pkgs, … }:

{
  boot= {
    supportedFilesystems = [ “bcachefs” ];        # Bcachefs support
    kernel.sysctl = { "vm.swappiness" = 10;};  # Set virtual memory (swap) swappiness value
    kernelPackages = pkgs.linuxPackages_latest;   # Install latest kernel and associated packages
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

}

# Does not have dual/multi-boot capabilities.
