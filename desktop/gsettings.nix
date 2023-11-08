{ config, lib, pkgs, ... }:

## WORK IN PROGRESS

let
  cfgpath = import /etc/nixos/cfgpath.nix;
  machine = import /etc/nixos/machine.nix;

  config = import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix");
  username = config.username; 

in

{
  home-manager.users.${username} = { lib, ... }: {

    dconf = {
      enable = true;
      settings = {

      #-- Paramètres
      
        #-- Multi-tâches
        "org/gnome/mutter" = {
          dynamic-workspaces = true;
        };


        #-- Énergie
        "org/gnome/settings-daemon/plugins/power" = {
          sleep-inactive-battery-type = "nothing";
          sleep-inactive-ac-type = "nothing";
          idle-dim = false;
          power-saver-profile-on-low-battery = false;
        };

        "org/gnome/shell" = {
          last-selected-power-profile = "performance";
        };

        "org/gnome/desktop/session" = {
          idle-delay = lib.hm.gvariant.mkUint32 0;
        };


        #-- Écrans - Mode nuit
        "org/gnome/settings-daemon/plugins/color" = {
          night-light-enabled = true;
          night-light-temperature = lib.hm.gvariant.mkUint32 4700;          
          night-light-schedule-to = lib.hm.gvariant.mkDouble 3.9999;
          night-light-schedule-from = lib.hm.gvariant.mkDouble 4.00;
          night-light-schedule-automatic = false;
        };


        #-- Souris et pavé tactile
        "org/gnome/desktop/peripherals/touchpad" = {
          tap-to-click = true;
          speed = .25;
        };

        "org/gnome/desktop/peripherals/mouse" = {
          speed = .25;
        };
          

        #-- Clavier - Raccourcis (non fontionnel)
#        "org/gnome/desktop/wm/keybindings" = {
#          move-to-workspace-left = "['<Alt><Shift>Left']";
#          move-to-workspace-right = "['<Alt><Shift>Right']";
#          switch-to-workspace-left = "['<Alt>Left']";
#          switch-to-workspace-right = "['<Alt>Right']";
#        };


      #-- Ajustements

        #-- Apparence
        "org/gnome/desktop/interface" = {
          gtk-theme = "Fluent-green-Light";
          icon-theme = "Papirus";
        };      

        "org/gnome/desktop/background" = {
          picture-uri = "file:///home/${username}/.wallpaper.jpg";
        };

        "org/gnome/desktop/screensaver" = {
          picture-uri = "file:///home/${username}/.wallpaper.jpg";
        };


        #-- Fenêtres
        "org/gnome/desktop/wm/preferences" = {
          button-layout = ":minimize,close";
        };


        #-- Barre supérieure
        "org/gnome/desktop/interface" = {
          clock-show-weekday = true;
        };        


        #-- Polices
        "org/gnome/desktop/interface" = {
          font-name = "Ubuntu Regular 11";
          document-font-name = "Ubuntu Regular 11";
          monospace-font-name = "Ubuntu Mono Regular 12";
          #text-scaling-factor = 1.25;
        }; 

        "org/gnome/desktop/wm/preferences" = {
          titlebar-font = "Ubuntu Medium 11";
        };


      #-- Applications

        #-- Terminal
        "org/gnome/terminal/legacy" = {
          theme-variant = "dark";
        };

#        # Virt-manager
#        "org/virt-manager/virt-manager" = {
#          enable-libguestfs-vm-inspection = true;
#        };
#
#        "org/virt-manager/virt-manager/console" = {
#          resize-guest = lib.hm.gvariant.mkUint32 1;
#        };
#
#        "org/virt-manager/virt-manager/details" = {
#          show-toolbar = false;
#        };
#
#        "org/virt-manager/virt-manager/paths" = {
#          image-default = "~/.local/share/libvirt/images";
#        };
#
#
#        # Nautilus
#        "org/gnome/nautilus/preferences" = {
#          show-hidden-files = true;
#          show-delete-permanently = true;
#          show-create-link = true;
#          default-folder-viewer = "list-view";
#        };
#
#        "org/gnome/nautilus/list-view" = {
#          default-zoom-level = "small";
#          default-visible-columns = "['name', 'size', 'type', 'owner', 'group', 'permissions', 'date_modified', 'starred']";
#        };
#
#        "org/gtk/Settings/FileChooser" = {
#          show-hidden = true;
#          sort-directories-first = true;
#        };
#
#
#        # Epiphany
#        "org/gnome/Epiphany/web" = {
#          enable-webextensions = true;
#        };
#
#
#        # Scanner
#        "org/gnome/SimpleScan" = {
#          jpeg-quality = lib.hm.gvariant.mkUint32 23;
#        };
#

      #-- Extensions

#
#        # Just perfection
#        "org/gnome/shell/extensions/just-perfection" = {
#          animation = lib.hm.gvariant.mkUint32 4;
#          search = false;
#        };
#
#
#        # Tray icons reloaded
#        "org/gnome/shell/extensions/trayIconsReloaded" = {
#          tray-position = "center";
#          icon-size = lib.hm.gvariant.mkUint32 16;
#          icons-limit = lib.hm.gvariant.mkUint32 15;
#          icon-brightness = -50;
#          tray-margin-left = lib.hm.gvariant.mkUint32 4;
#          icon-margin-horizontal = lib.hm.gvariant.mkUint32 4;
#          icon-margin-vertical = lib.hm.gvariant.mkUint32 4; 
#          icon-padding-horizontal = lib.hm.gvariant.mkUint32 3;
#        };
#        
#
#        # Pop shell
#        "org/gnome/shell/extensions/pop-shell" = {
#          tile-by-default = true;
#          gap-inner = 2;
#          gap-outer = 2;
#        };
#
#
#        # Vitals
#        "org/gnome/shell/extensions/vitals" = {
#          update-time = lib.hm.gvariant.mkUint32 3;
#          hide-icons = true;
#          fixed-widths = true;
#          show-system = false;
#          show-fan = false;
#          show-voltage = false;
#          show-network = false;
#          show-storage = false;
#          show-battery = true;
#          battery-slot = lib.hm.gvariant.mkUint32 1;
#        };
#        
#        # Dash to panel
#        "org/gnome/shell/extensions/dash-to-panel" = {
#          dot-style-focused = "DASHES";
#          dot-style-unfocused = "SQUARES";
#          dot-position = "TOP";
#          dot-size = lib.hm.gvariant.mkUint32 2;
#          focus-highlight-opacity = lib.hm.gvariant.mkUint32 15;
##          panel-sizes = "{'0':32,'1':32}";
##          panel-positions = "{'0':'TOP','1':'TOP'}";
#          stockgs-keep-dash = true;
#          trans-panel-opacity = lib.hm.gvariant.mkUint32 0;
#          trans-use-custom-opacity = false;
#          animate-appicon-hover = false;
#          appicon-padding = lib.hm.gvariant.mkUint32 5;
#          appicon-margin = lib.hm.gvariant.mkUint32 0;
#          show-favorites = false;
#          show-activities-button = false;
#        };

        
      };
    };
  };


}
