{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs.gnomeExtensions; [

    just-perfection
    dash-to-panel
    appindicator
    
    #arcmenu
    vitals
    #tray-icons-reloaded
    forge
    
    pop-shell
    #custom-hot-corners-extended
    user-themes
    
  ];

}
