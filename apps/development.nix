{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # Nix-tools
    nix-prefetch-git    
    nix-prefetch-github
    nixpkgs-fmt

    # Meson build
    meson ninja

    # GTK apps build
    glib appstream-glib
    pkg-config wrapGAppsHook

    # Other building packages (bazar)
    #busybox
    gettext librsvg
    desktop-file-utils
    sassc
    ack fzf pydf

  ];

}
