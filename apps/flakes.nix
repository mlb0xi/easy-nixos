{ config, lib, pkgs, ... }:
{
  environment.systemPackages = [
    #(builtins.getFlake "github:Unrud/video-downloader")
    (builtins.getFlake "github:matleborgne/video-downloader")
  ];

}
