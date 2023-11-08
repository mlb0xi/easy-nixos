{ config, lib, pkgs, ... }:

{
  boot.kernelParams = [
    "console=ttyS0,115200"
    "console=tty1"
  ];
}
