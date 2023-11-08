{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    clementine

    vlc
    celluloid
    hypnotix

    mediainfo-gui
    mkvtoolnix
    handbrake

    kdenlive
    #davinci-resolve

    obs-studio


    bitwarden

    molotov

    protonvpn-gui
    networkmanagerapplet
  ];
}
