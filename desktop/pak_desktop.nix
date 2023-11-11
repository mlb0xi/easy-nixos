{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [

    # Outils GNOME+
    gcolor3
    flameshot

    # Plus
    flatpak

    # Icon theme
    papirus-icon-theme

  ];

}
