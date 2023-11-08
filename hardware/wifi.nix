{ config, lib, pkgs, ... }:
{
#	hardware.enableAllFirmware = true;

  # Kernel module for TP-Link T2U nano
#  boot.extraModulePackages = with config.boot.kernelPackages; [
#    rtl88xxau-aircrack
#  ];

}
