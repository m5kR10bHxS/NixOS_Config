# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  # IMPORT MODULES
  imports = [
    ./hardware-configuration.nix    # Include the results of the hardware scan.
    #./modules/budgie-desktop.nix
    #./modules/gaming.nix
    #./modules/hyprland-desktop.nix
    ./modules/intel-gpu.nix
    ./modules/kde-desktop.nix
    #./modules/lxqt-desktop.nix
    ./modules/maintenance.nix
    #./modules/nvidia.nix
    #./modules/sh.nix
    #./modules/user-GTK_programs.nix
    ./modules/user-QT_programs.nix
  ];

  # BOOT
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;    # Install latest kernel.
    supportedFilesystems = [ "bcachefs" ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable= true;
    };
  };

  # NETWORK
  networking = {
    hostName = "feynman";
    networkmanager.enable = true;
    #wireless.enable = true;
  };

  # TIME ZONE
  time.timeZone = "America/Chicago";

  # INTERNATIONALISATION
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # REGULAR USERS -Don't forget to set a password with ‘passwd’.
  users.users.gumby = {
    isNormalUser = true;
    description = "DW";
    initialPassword = "pw123";
    extraGroups = [ "networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      #firefox
      #tree
    ];
  };

  # List packages installed in system profile. To search, run:
    #$ nix search wget
  environment.systemPackages = with pkgs; [
    #vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #wget
    alacritty
    brave
    firefox
    kdePackages.kate
    librewolf
    # libsForQt5.polkit-kde-agent    # Dependency for kate req'd for GTK DE's
    nano
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  #programs.mtr.enable = true;
  #programs.gnupg.agent = {
  #  enable = true;
  #  enableSSHSupport = true;
  #};

  # HARDWARE & SERVICES
  console = {
    earlySetup = true;
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty
  };

  security.rtkit.enable = true;
  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
    bluetooth.settings = {
    };
  };

  services = {
    blueman.enable = false;
    openssh.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      jack.enable = false;
    };
    printing = {
      enable = true;
      cups-pdf.enable = true;
    };
    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "workman";
      xkb.options = "";
    };
  };

  #sound.enable = true; Removed for 24.11 channel upgrade.

  systemd.services = {
    "systemd-suspend-then-hibernate".aliases = [ "systemd-suspend.service" ];
  };

  zramSwap = {
    enable = true;
    memoryPercent = 75;
    priority = 5;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
