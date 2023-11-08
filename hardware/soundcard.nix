{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    sof-firmware
  ];

  sound.enable = true;
  security.rtkit.enable = true;

  hardware.pulseaudio = {
    enable = false;  
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


}
