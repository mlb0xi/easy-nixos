{
  # configuration.nix (system)
  nixos_version   = "23.05";
  username        = "tuxedo";

  # fullencrypt.nix (system)
  # ne pas oublier de labéliser les partitions
  luks_partlabel  = "nixos1";
  luks_data_label = "data2";

  # fstab.nix (system)
  # ne pas oublier de labéliser les partitions
  efi_partlabel   = "uefi1";
  root_label      = "nixos1";
  external_hdd_label    = "backup1";
  swap_options    = [ "noatime" ];
  ext4_options    = [ "noatime" ];
  resume_offset   = "9335484";

  # network.nix (system)
  hostName        = "nix-tux";

  # python.nix (server)
  pyVersion       = "python311Packages";

  # locale.nix (system) / gnome.nix (desktop)
  timeZone        = "Europe/Paris";
  locales         = "fr_FR.UTF-8";
  font            = "Lat2-Terminus16";
  keyMap          = "fr";
  xkbVariant      = "azerty";
  xkbOptions      = "eurosign:e";
 
}
