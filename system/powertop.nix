{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    powertop
  ];


  systemd.services.powertop = {
    enable = true;
    description = "Powertop optimizations";
    unitConfig.Type = "oneshot";
    serviceConfig.ExecStart = "${pkgs.powertop}/bin/powertop --auto-tune";
    wantedBy = [ "multi-user.target" ];
  };

}
