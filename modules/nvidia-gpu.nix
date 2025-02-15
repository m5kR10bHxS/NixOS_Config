# nvidia-gpu.nix

{ config, lib, pkgs, … }:

{

  services.xserver = {
    enable = true;
    videoDrivers = [“nvidia”];         # Use the proprietary driver for GTX 1000 series and newer.
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;          # Needed for booting into Wayland environment.
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";               # Hint to use Wayland instead of xWayland.
  };

  powerManagement = {
    enable = false;                     # Enable if graphical corruption, or crashes after waking from sleep.
    finegrained = false;                # Only works with Turing, or newer hardware.
  }

  open = false;                         # Use open source Nvidia kernel driver (not nouveau).

  nvidiaSettings = true;                # Nvidia settings menu.

  #package = config.boot.kernelPackages.nvidiaPackages = legacy_340;    # GT340 and older.
  #package = config.boot.kernelPackages.nvidiaPackages = legacy_390;    # GTX470, GTX570
  #package = config.boot.kernelPackages.nvidiaPackages = legacy_470;    # GTX780
  #package = config.boot.kernelPackages.nvidiaPackages = stable;        # Stable proprietary driver.
  #package = config.boot.kernelPackages.nvidiaPackages = beta;          # Beta proprietary driver.
  package = config.boot.kernelPackages.nvidiaPackages = production;    # Production proprietary v555+ driver.

# Nvidia user space drivers:
# Nouveau is the community open source driver providing OpenGL and other functionality.
# Nouveau has only partial support for the GTX 1000 series and newer GPUs.
# NVK is part of Mesa and is the community open source driver for Vulkan.
# NVK can be used in conjunction with Nouveau.
# As of Spring 2024, Nvidia's open source driver still isn't at parity with their proprietary driver and still isn't merged into the kernel.
# Nvidia also, obviously, offer a series of proprietary drivers. This is currently the best option for the GTX 1000 series and newer hardware.
# Starting with Nvidia's driver 545 and newer, Wayland compatibility has been introduced.
# CUDA compute support 's ien available via the proprietary driver.
# After launching a game, open a terminal and run $ nvidia-smi, to see if the game is listed among the running processes.

}
