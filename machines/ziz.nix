# Edit this configuration file to define what should be installed on
# this specific machine.

{ config, pkgs, ... }:

{
  imports =
    [
      ../base.nix
      ../../hardware-configuration.nix
    ];

  boot.kernelModules = [
    "i2c-dev" # i2c bus utility for periferals
    "nct6775" # hardware sensors
  ];

  hardware.bluetooth.enable = true;

  networking.hostName = "tattletale";
  networking.firewall.allowedTCPPorts = [
    22      # OpenSSH
    5432    # Postgres
    27017   # MongoDB
  ];

  services = {
    # Enable the X11 windowing system.
    xserver.enable = true;
    xserver.videoDrivers = ["nvidia" ];

    mongodb = {
      enable = true;
      bind_ip = "0.0.0.0";
    };
    postgresql = {
      enable = true;
      package = pkgs.postgresql100;
      enableTCPIP = true;
      authentication = pkgs.lib.mkOverride 10 ''
        local all all trust
        host all all ::1/128 trust
        host all all 2601:40f:600:99b::/64 md5
        host all all 192.168.1.1/24 md5
      '';
    };
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
