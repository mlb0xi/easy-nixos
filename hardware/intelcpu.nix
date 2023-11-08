{ config, lib, pkgs, ... }:

{
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  #boot.initrd.kernelModules = [ "i915.force_probe=46a6" ];

}
