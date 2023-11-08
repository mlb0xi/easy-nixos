{ config, lib, pkgs, ... }:

## WORK IN PROGRESS

{
  environment.systemPackages = with pkgs; [
    etcher
  
    dmg2img libguestfs  
    gnumake
    p7zip
  ];
                
}
