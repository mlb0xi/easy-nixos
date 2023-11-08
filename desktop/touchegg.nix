{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    touchegg
    gnomeExtensions.x11-gestures
  ];


  systemd.services.touchegg = {
    enable = true;
    description = "Touchegg";
    wantedBy = [ "multi-user.target" ];
      
    serviceConfig = {
      Type = "simple";
      Group = "input";
      Restart = "on-failure";
      RestartSec = 5;
      ExecStart = "${pkgs.touchegg}/bin/touchegg --daemon";
      };
    };



 systemd.user.services.touchegg-client = {
      description = "Touchégg. The client.";

      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];

      serviceConfig = {
        Restart = "on-failure";
        ExecStart = "${pkgs.touchegg}/bin/touchegg";
      };
    };
    

}
