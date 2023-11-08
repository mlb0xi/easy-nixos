{ config, lib, pkgs, ... }:

let
  cfgpath = import /etc/nixos/cfgpath.nix;
  machine = import /etc/nixos/machine.nix;
  config = import (builtins.toPath "${cfgpath}/config/${machine}-conf.nix");

  pyVersion = config.pyVersion;

in

{
  environment.systemPackages = with pkgs.${pyVersion} ; [
    python
    pip pipdeptree

    ipykernel openpyxl xlrd
    pandas numpy chardet
    levenshtein

    matplotlib seaborn plotly
    scikit-learn scikit-learn-extra hdbscan
    statsmodels

    mariadb
    jellyfish
    flake8 pygobject3
  ];


}
