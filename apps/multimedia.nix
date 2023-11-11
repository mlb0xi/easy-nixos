{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    
    # Sound
    easyeffects
    clementine

    # Image
    gimp
    
    # Video
    vlc
    celluloid
    hypnotix

    mediainfo-gui
    mkvtoolnix
    handbrake

    kdenlive
    #davinci-resolve
    obs-studio  
    peek

  ];
}
