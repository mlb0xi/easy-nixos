{ config, lib, pkgs, ... }:

{
  boot = {

    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
    ];

    kernelParams = [
      "amd_iommu=on"
      "iommu=pt"
      "pcie_aspm=off"
    ];

    extraModprobeConfig = ''
      options vfio-pci ids=1002:731f,1002:ab38
      options kvm_amd nested=1
    '';

    postBootCommands = ''
      DEVS="0000:12:00.0 0000:12:00.1"
      for DEV in $DEVS; do
        echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
      done
      modprobe -i vfio-pci
    '';

  };

}
