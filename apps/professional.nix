{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fsearch
    discord
#   nextcloud-client
#   synology-drive-client
    wireguard-tools
    vncdo

    android-tools

    logseq #obsidian alternative
    appflowy #notion
    anytype #notion best
    #focalboard #trello  => flatpak   
  ];
}