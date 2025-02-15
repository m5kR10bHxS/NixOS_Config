# ./networking.nix

{ config, lib, pkgs, ... }:

{

  networking = {
    hostName = "feynman";
    networkmanager.enable = true;
    #wireless.enable = true;    # wpa_supplicant
  };

  # Configure network proxy
  #networking.proxy = {
  #  default = "http://user:password@proxy:port/";
  #  noProxy = "127.0.0.1,localhost,internal.domain";
  #};

  # Firewall: is enabled by default w/ default deny
  #networking.firewall = {
  #  enable = false;    # Disable the firewall
  #  allowedTCPPorts = [ ... ];
  #  allowedUDPPorts = [ ... ];
  #};

# NixOS Hosts: tesla, feynman

}
