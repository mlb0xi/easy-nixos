{ config, pkgs, ... }:

let

  pkgs = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/ee01de29d2f58d56b1be4ae24c24bd91c5380cea.tar.gz";
    }) {};

  myPkg = pkgs.gnome.nautilus;

in

{
  environment.systemPackages = [ myPkg ];
}
