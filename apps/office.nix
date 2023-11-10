{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libreoffice
    cherrytree
    drawio
  ];

}
