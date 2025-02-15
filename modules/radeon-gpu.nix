# ./modules/radeon/nix

{ config, lib, pkgs, … }:

{
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];        # Mesa kernel driver
    deviceSection = ‘ ‘
      Option "TearFree" "False"         # Screen tearing allowed?
      Option "VariableRefresh" "True"   # FreeSync 
    ‘ ‘;
  };

  hardware.opengl = {
    enable = true;                      # Mesa / OpenGL
    driSupport = true;                  # Mesa / Vulkan
    driSupport32Bit = true;             # Mesa / Vulkan
    extraPackages = [
  #    rocmPackages.clr.icd             # OpenCL compute - $ cliinfo for details
    ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";               # Hint to use Wayland instead of xWayland
  };

  environment.systemPackages = with pkgs; [
  #   clinfo
    vulkan-tools
  ];

}

# Radeon user space drivers:
# AMDGPU is the open source Mesa kernel module.
# Radeon SI (OpenGL) and RADV (Vulkan) are the Mesa user space componets for AMDGPU.
# AMDVLK is an open source Vulkan driver based on AMD's proprietary driver.
# ROCm is and open source OpenCL compute driver.
# AMDVLK and ROCm are compatible with the Mesa drivers.
# Video decoding is provided by the Mesa libva and vdpau drivers.
# The DDX driver in the xf86-video-amdgpu package provides 2D acceleration in X.
# Note: AMDGPU-PRO is AMD's proprietary driver. It has good compute performance, but otherwise lags behind Mesa in other areas. Probably best used with LTS distros.
# lact is a control panel for Radeon, compatible with the AMDGPU driver.