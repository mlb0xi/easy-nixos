{ config, lib, pkgs, ... }:
{
  fonts = {
    fonts = with pkgs; [
      open-fonts

      #fira
      #fira-mono
      #fira-code
      #fira-code-symbols
      ubuntu_font_family
      #nerdfonts
      #(nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Ubuntu" ];
        sansSerif = [ "Ubuntu" ];
        monospace = [ "Ubuntu" ];  
      };
    };

  };


}
