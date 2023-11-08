{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nano nanorc
  ];


  programs.nano = {
    syntaxHighlight = true;

    # ~/.nanorc
    # https://www.nano-editor.org/dist/v2.1/nanorc.5.html
    nanorc = ''
      set tabsize 2      
      set tabstospaces   
      set autoindent  
    '';

  };

}
