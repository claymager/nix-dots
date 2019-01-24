# Edit this configuration file to define what should be installed on
# this specific machine.

{ config, pkgs, ... }:

{
  imports =
    [
      ../base.nix
      ../../hardware-configuration.nix
    ];

  boot.kernelModules = [ "i2c-dev" "btusb" ];
  hardware.bluetooth.enable = true;

  networking.hostName = "wyvern";
  #networking.firewall.allowedTCPPorts = [ 27017 5900 ];

  services = {
    # Enable the X11 windowing system.
    xserver.enable = true;
    xserver.videoDrivers = ["nvidia" ];

    #mongodb.enable = true;
    #postgresql.enable = true;
    #printing.enable = true;
    openssh = {
      enable = true;
      permitRootLogin = "no";
      passwordAuthentication = false;
    };
  };

  users.users.john.openssh.authorizedKeys.keyFiles = [ "/home/john/.ssh/authorized_keys" ];
  #virtualisation.docker.enable = true;
}
