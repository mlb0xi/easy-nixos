{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sweethome3d.application
    sweethome3d.textures-editor
    sweethome3d.furniture-editor

#    exodus
    molotov
    
    bitwarden

    libsForQt5.k3b
    autorandr
    xorg.libxcvt
    
    # Non classées
    glaxnimate
    
    ];

}
