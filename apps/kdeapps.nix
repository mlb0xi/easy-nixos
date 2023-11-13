{ config, lib, pkgs, ... }:

let

otherApps = with pkgs; [
    media-downloader
    partition-manager
    vorta
];

in
{
  environment.systemPackages = with pkgs.libsForQt5; [
    kitinerary
    knotes
    audiotube
    kwave
    juk  
  ] ++ otherApps;

}
