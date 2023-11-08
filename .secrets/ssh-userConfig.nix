{ config, lib, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix;
  machine = import /etc/nixos/machine.nix;
  
  username = (import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix")).username;

in

{
  home-manager.users.${username}.home.file = {

    ".ssh/config" = {
      executable = false;
      text = ''
        Host server1
          HostName 192.168.0.X
          Port 10000
          User myUser
          RequestTTY yes
          RemoteCommand exec /usr/local/bin/fish

        Host server2
          HostName 192.168.0.X
          Port 10000
          User ${username}
          IdentityFile=~/.ssh/id_rsa.key
      '';
    };
  };

}
