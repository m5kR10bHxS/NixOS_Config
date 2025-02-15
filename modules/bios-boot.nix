# Grub for coreboot / SeaBIOS

{

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;    # Install latest kernel.
    kernel.sysctl = { "vm.swappiness" = 0; };    # Set virtual memory (swap) swappiness value
    supportedFilesystems = [ "bcachefs" ];
    loader = {
      grub = {
        enable = true;
        backgroundColor = "#7EBAE4";
        device = "/dev/sda"; # or "/dev/disk/by-id/wwn-0x500001234567890a"
        memtest86.enable = true;
        useOSProber = false;
        version = 2;
      };
    };
  };

}


# Use: boot.loader.grub.useOSProber for dual / multi boot
