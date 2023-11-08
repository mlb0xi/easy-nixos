{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bash bash-completion
  ];

  programs.bash.shellAliases = { 
    ip = "ip -c";
    cat = "bat -p";    
    nixsearch = "nix-env -qaP";
    nixinstall = "nix-env -iA";
    nixlist = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
    nixs = "nix-shell";
    nixsp = "nix-shell -p";
    nixup = "sudo nix-channel --update";
    nixrs = "sudo nixos-rebuild switch";
    nixrb = "sudo nixos-rebuild boot";
  };

}
