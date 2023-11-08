{ config, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix;
  machine = import /etc/nixos/machine.nix;
  config = import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix");

  username = config.username;

  
in

{
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };


  home-manager.users."${username}" = {
    programs.home-manager.enable = true;

    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;

      extensions = with pkgs.vscode-extensions; [

        ms-ceintl.vscode-language-pack-fr    # Pack FR
        pkief.material-icon-theme            # Pack d'icones 
        gruntfuggly.todo-tree                # Arbre montrant les TODO et FIXME

        ms-python.python                     # Python metapackage
        ms-python.vscode-pylance             # Python LSP support
        ms-toolsai.jupyter                   # Jupyter Notebook (metapack)

        oderwat.indent-rainbow               # Highlight indentation
        christian-kohler.path-intellisense   # Path auto-completion
        tabnine.tabnine-vscode               # AI autocomplete
        #GitHub.copilot

        yzhang.markdown-all-in-one           # Markdown ext1
        davidanson.vscode-markdownlint       # MarkDown ext2

        jnoortheen.nix-ide                   # Integrated environment for NIX
        brettm12345.nixfmt-vscode            # 
        arrterian.nix-env-selector           # NixOS environment

        mads-hartmann.bash-ide-vscode        # IDE for bash scripting
        timonwong.shellcheck                 # ShellCheck for bash script
        foxundermoon.shell-format            # Formatting shell scripts

        #KevinRose.vsc-python-indent
        #hediet.vscode-drawio

        ];
      };  
    };

}
