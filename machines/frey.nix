# Edit this configuration file to define what should be installed on
# this specific machine.

{ config, pkgs, ... }:

{
  imports =
    [
      ../modules/base.nix
      ../modules/gui.nix
      ../modules/dev.nix
      ../hardware-configuration/frey.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "acpi_rev_override" ];

  hardware = {
    bluetooth.enable = true;
    bumblebee = {
      enable = true;
      connectDisplay = true;
    };
  };

  users.extraUsers.john.hashedPassword = "$5$QIlpPxYhSVGcTd8k$ISN3TP3r1iLag2YB1Tw3vQ2oTrC8It.wcxUmplfAM94";

  networking = {
    hostName = "genevieve";
    networkmanager.enable = true;
  };

  # programs.light.enable = true; # no-op since 19.03

  services = {
    xserver.libinput.enable = true; # touchpad

    mongodb.enable = true;
    postgresql = {
      enable = true;
      package = pkgs.postgresql_10;
      enableTCPIP = true;
    };

    printing = {
      enable = true;
      drivers = [ pkgs.brlaser pkgs.brgenml1lpr pkgs.brgenml1cupswrapper];
    };
  };

  systemd.services.nvidia-control-devices = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11}/bin/nvidia-smi";
  };

  services.udev.extraRules = ''SUBSYSTEM=="power_supply", KERNEL=="BAT0", ATTR{status}=="Discharging", ATTR{capacity}=="[0-9]", RUN+="${pkgs.systemd}/bin/systemctl hibernate"'';
}
