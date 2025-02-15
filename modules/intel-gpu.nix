# ./modules/intel-gpu.nix

{ config, lib, pkgs, ... }:

{

  hardware.graphics = {  # Replaces hardware.opengl = { as of 24.11
    enable = true;                        # Mesa / OpenG
  };
  environment.systemPackages = with pkgs; [
    aha
    clinfo
    glxinfo
    vulkan-tools
    wayland-utils
  ];

}

/*
  hardware.graphics = {  # Replaces hardware.opengl = { as of 24.11
    enable = true;                        # Mesa / OpenG
    enable32Bit = true;
    extraPackages32 = with pkgs; [
      driversi686Linux.intel-vaapi-driver # 32-bit video acclelertion
    ];
    extraPackages = with pkgs; [
      #intel-compute-runtime              # OpenCL compute - $ cliinfo for details
      intel-media-driver                  # New libva driver: iHD for Broadwell and newer
      # intel-vaapi-driver                # Old libva driver: i965 video acceleration
      libvdpau-va-gl                      # h264 and other codec support
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";            # Enable if using the intel-media-driver so that the Installable Client Driver (ICD) can find the iHD driver
  };

  environment.systemPackages = with pkgs; [
    aha
    clinfo
    glxinfo
    vulkan-tools
    wayland-utils
  ];
  #nixpkgs.config.packageOverrides = pkgs: (
  #  intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  #);

}
*/

# Note: The Acer Nitro CPU = Gen 9 Coffee Lake i5-8500H.
# Note: The ASRock Extereme4 CPU = Gen 4 Haswell E i7-5930K.
# Note: The Lenovo X230 CPU = Gen 3 Ivy Bridge i5-3320M.
# Note: The Dell Inspiron CPU = Gen 3 Ivy Bridge i3-3217U.
# Intel user space GPU drivers:
# i915 is the kernel driver for all integrated GPUs.
# i965 is the user space driver for i915 and provides OpenGL.
# i965 is part of the Mesa package.
# ANV is the Vulkan driver that is also included in Mesa.
# Intel is currently working on the Xe driver, which is expected to eventually replace i915.
