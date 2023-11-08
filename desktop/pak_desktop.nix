{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [

    veracrypt

    # Outils GNOME+
    gcolor3
    peek
    flameshot

    # Sound
    easyeffects

    # Plus
    flatpak

    barrier
    krename
#    freefilesync

    # Icon theme
    papirus-icon-theme

    arc-icon-theme
    qogir-icon-theme

    libsForQt5.k3b
    autorandr
    xorg.libxcvt
  ];

}
