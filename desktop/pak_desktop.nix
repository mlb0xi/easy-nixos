{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [

    # Outils GNOME+
    gcolor3
    peek
    flameshot

    # Sound
    easyeffects

    # Plus
    flatpak
    krename

    # Icon theme
    papirus-icon-theme

  ];

}
