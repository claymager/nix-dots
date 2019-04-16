# Edit this configuration file to define what should be installed on
# this specific machine.

{ config, pkgs, ... }:

{
  imports =
    [
      ../base.nix
      ../hardware-configuration/frey.nix
    ];

  boot.kernelParams = [ "acpi_rev_override" ];

  hardware = {
    bluetooth.enable = true;
    bumblebee = {
      enable = true;
      connectDisplay = true;
    };
    # steam needs 32Bit support
    opengl.driSupport32Bit = true;
    pulseaudio.support32Bit = true;
  };

  networking = {
    hostName = "frey";
    networkmanager.enable = true;
  };

  programs.light.enable = true;

  services = {
    xserver.enable = true;
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
    sshd.enable = true; # automatically opens port 22
    sshd.permitRootLogin = "yes";
  };

  systemd.services.nvidia-control-devices = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11}/bin/nvidia-smi";
  };

  services.udev.extraRules = ''SUBSYSTEM=="power_supply", KERNEL=="BAT0", ATTR{status}=="Discharging", ATTR{capacity}=="[0-9]", RUN+="${pkgs.systemd}/bin/systemctl hibernate"'';
  users.users.john.openssh.authorizedKeys.keyFiles = [ "/home/john/.ssh/authorized_keys" ];
  users.users.root.openssh.authorizedKeys.keyFiles = [ "/home/john/.ssh/authorized_keys" ];
}
