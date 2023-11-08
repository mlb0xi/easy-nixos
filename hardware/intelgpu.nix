{ config, lib, pkgs, ... }:

{
  hardware.opengl = {
    enable = true;

    driSupport = lib.mkDefault true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-media-sdk
      vaapiVdpau
      libvdpau-va-gl
    ];

    driSupport32Bit = lib.mkDefault true;
    extraPackages32 = with pkgs; [
      driversi686Linux.vaapiVdpau
      driversi686Linux.libvdpau-va-gl
    ];

  };


  environment.variables = {
    LIBVA_DRIVER_NAME = lib.mkDefault "iHD";
    VDPAU_DRIVER = lib.mkDefault "va_gl";
  };

}
