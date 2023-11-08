{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tlp
  ];


  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;

  environment.etc."tlp.conf".text = ''
    DISK_IDLE_SECS_ON_AC=0
    DISK_IDLE_SECS_ON_BAT=2
    MAX_LOST_WORK_SECS_ON_AC=15
    MAX_LOST_WORK_SECS_ON_BAT=60
    CPU_SCALING_GOVERNOR_ON_AC=performance
    CPU_SCALING_GOVERNOR_ON_BAT=schedutil
    CPU_SCALING_MAX_FREQ_ON_BAT=1600000
    SCHED_POWERSAVE_ON_AC=0
    SCHED_POWERSAVE_ON_BAT=1
    NMI_WATCHDOG=0
    DISK_APM_LEVEL_ON_AC="254 254"
    DISK_APM_LEVEL_ON_BAT="128 128"
    DISK_IOSCHED="mq-deadline mq-deadline"
    SATA_LINKPWR_ON_AC="med_power_with_dipm max_performance"
    SATA_LINKPWR_ON_BAT="med_power_with_dipm min_power"
    AHCI_RUNTIME_PM_TIMEOUT=15
    PCIE_ASPM_ON_AC=default
    PCIE_ASPM_ON_BAT=powersave
    RADEON_POWER_PROFILE_ON_AC=default
    RADEON_POWER_PROFILE_ON_BAT=low
    RADEON_DPM_STATE_ON_AC=performance
    RADEON_DPM_STATE_ON_BAT=battery
    RADEON_DPM_PERF_LEVEL_ON_AC=auto
    RADEON_DPM_PERF_LEVEL_ON_BAT=low
    WIFI_PWR_ON_AC=off
    WIFI_PWR_ON_BAT=on
    WOL_DISABLE=Y
    RUNTIME_PM_ON_AC=on
    RUNTIME_PM_ON_BAT=auto
    USB_AUTOSUSPEND=1
    START_CHARGE_THRESH_BAT0=60
    STOP_CHARGE_THRESH_BAT0=80
    START_CHARGE_THRESH_BAT1=60
    STOP_CHARGE_THRESH_BAT1=80
  '';  

}
