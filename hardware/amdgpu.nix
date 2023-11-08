{ config, lib, pkgs, ... }:

{
  hardware.opengl = {
    enable = true;
    
    driSupport = lib.mkDefault true;
    extraPackages = with pkgs; [
      rocm-opencl-icd
      rocm-opencl-runtime
      amdvlk
    ];

    driSupport32Bit = lib.mkDefault true;
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];

  };


  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Force RADV (vulkan-radeon) over amdvlk - via environment variable
  environment.variables.AMD_VULKAN_ICD = lib.mkDefault "RADV";

}
