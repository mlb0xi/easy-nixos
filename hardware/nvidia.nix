{ config, lib, pkgs, ... }:

{
  hardware.opengl = {
    enable = true;

    driSupport = lib.mkDefault true;
    extraPackages = with pkgs; [
      vaapiVdpau
    ];

    driSupport32Bit = lib.mkDefault true;
    extraPackages32 = with pkgs; [
      driversi686Linux.vaapiVdpau
    ];

  };


  services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

}
