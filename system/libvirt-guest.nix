{ config, lib, pkgs,  ... }:

{
  boot.initrd.availableKernelModules = [ 
    "virtio_pci" "sr_mod" "virtio_blk"
  ];

  environment.systemPackages = with pkgs; [
    spice-vdagent  
  ];
  
  services.spice-vdagentd.enable = true;

}
