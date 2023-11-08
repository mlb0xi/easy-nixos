{ config, lib, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix;

in

{
  environment.systemPackages = with pkgs; [
    openssh
    sshfs
  ];


  environment.etc."fuse.conf".text = ''
    user_allow_other
  '';


  services.openssh = {
    enable = true;
    ports = [ 10000 ];
  };

  imports = [
    "${cfgpath}.secrets/ssh-userConfig.nix"
  ];

}
