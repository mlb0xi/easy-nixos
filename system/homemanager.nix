{ config, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix;
  machine = import /etc/nixos/machine.nix;

  config = import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix");
  username = config.username;
  nixos_version = config.nixos_version;

  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-${nixos_version}.tar.gz";

in

{
  home-manager.users.${username}.home.stateVersion = "${nixos_version}";

  imports = [
    <nixpkgs/nixos/modules/services/hardware/sane_extra_backends/brscan4.nix>
    (import "${home-manager}/nixos")
  ];

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "users" "input" "video" "wheel" "fuse" "networkmanager" ];    
  };

}
