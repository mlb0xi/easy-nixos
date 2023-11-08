{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libreoffice

    obsidian
    cherrytree
    drawio

    meld
    pdfarranger   
   
    sqlitebrowser
    sqlite

  ];

}
