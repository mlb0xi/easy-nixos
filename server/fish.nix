{ config, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix;
  machine = import /etc/nixos/machine.nix;
  
  username = (import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix")).username;
  

in
{
  environment.systemPackages = with pkgs; [
    fish
  ];

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  programs.fish.shellAliases = {
    ip = "ip -c";
    cat = "bat -p";    
    nixsearch = "nix-env -qaP";
    nixinstall = "nix-env -iA";
    nixlist = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
    nixs = "nix-shell";
    nixsp = "nix-shell -p";
    nixup = "bash ${cfgpath}/bash/nixos-autoModules.sh && bash ${cfgpath}/bash/prefetch-update.sh && sudo nix-channel --update && nixrb";
    nixrs = "bash ${cfgpath}/bash/nixos-autoModules.sh && bash ${cfgpath}/bash/prefetch-update.sh && sudo nixos-rebuild switch";
    nixrb = "bash ${cfgpath}/bash/nixos-autoModules.sh && bash ${cfgpath}/bash/prefetch-update.sh && sudo nixos-rebuild boot";
  };


  home-manager.users.${username}.home.file = {

    ".config/fish/functions/nixspr.fish" = {
      executable = false;
      text = ''
        function nixspr
          nix-shell -p $argv --run $argv
        end
      '';
    };

    ".config/fish/functions/nixclean.fish" = {
      executable = false;
      text = ''
        function nixclean
          sudo nix-collect-garbage --delete-older-than $argv
        end
      '';
    };

  };


}
