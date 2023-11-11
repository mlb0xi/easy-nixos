{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

  # Console tools
  vim
  git
  openssl
  
  # Automatisation
    jq
    yq
    ansible
    yt-dlp
    thefuck

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
