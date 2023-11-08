{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lutris
    steam steam-tui
    goverlay mangohud

    wine-staging wine64
    vulkan-loader vulkan-headers vulkan-tools dxvk
    giflib libpng gnutls mpg123 openal v4l-utils libgpg-error
    libjpeg sqlite xorg.libXcomposite xorg.libXinerama libgcrypt
    ncurses ocl-icd libxslt libva
  ];

  programs = {  
    steam = {
      enable = true;      
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

  };
  
}
