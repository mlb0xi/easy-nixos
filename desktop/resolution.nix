{ config, lib, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix;
  machine = import /etc/nixos/machine.nix;
  
  username = (import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix")).username;

in

{
  home-manager.users.${username}.home.file = {

    ".xprofile" = {
#      owner = "${username}";
      executable = false;
      text = ''

#        xrandr --newmode "2048x1280_60.00"  220.25  2048 2192 2408 2768  1280 1283 1289 1327 -hsync +vsync
#        xrandr --addmode eDP-1 2048x1280_60.00

        xrandr --newmode "2112x1320_60.00"  235.00  2112 2264 2488 2864  1320 1323 1329 1369 -hsync +vsync
        xrandr --addmode eDP-1 2112x1320_60.00
        xrandr --output eDP-1 --mode 2112x1320_60.00
        
      '';
    };
    
  };

}
