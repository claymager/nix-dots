# Edit this configuration file to define what should be installed on
# this specific machine.

{ config, pkgs, ... }:

{
  imports =
    [
      ../base.nix
      ../../hardware-configuration.nix
    ];

  boot.kernelModules = [ "kvm-amd" "i2c-dev" ];
  hardware.bluetooth.enable = true;

  networking.hostName = "wyvern";
  #networking.firewall.allowedTCPPorts = [ 61209 ];
  #networking.firewall.allowedUDPPorts = [ ];
  #networking.firewall.enable = false;
  #networking.networkmanager.enable = true; # wifi

  services = {
    # Enable the X11 windowing system.
    xserver.enable = true;
    xserver.videoDrivers = ["nvidia" ];

    mongodb.enable = true;
    postgresql.enable = true;
    #printing.enable = true;
    openssh = {
      enable = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
    };
  };

  users.users.john.openssh.authorizedKeys.keyFiles = [ "/home/john/.ssh/authorized_keys" ];
#  systemd.services.nvidia-control-devices = {
#    wantedBy = [ "multi-user.target" ];
#    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11}/bin/nvidia-smi";
#  };

  virtualisation.docker.enable = true;

  #environment.systemPackages = [ virtualboxHardened ];
  virtualisation.virtualbox.host.enable = true;
  users.extraUsers.john.extraGroups = ["vboxusers"];
}
