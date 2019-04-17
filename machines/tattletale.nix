# Edit this configuration file to define what should be installed on
# this specific machine.

{ config, pkgs, ... }:

{
  imports =
    [
      ../base.nix
      ../gui.nix
      ../hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [
    "i2c-dev" # i2c bus utility for periferals
    "nct6775" # hardware sensors
  ];

  hardware.bluetooth.enable = true;

  networking = {
    hostName = "tattletale";
    firewall.allowedTCPPorts = [
      22      # OpenSSH
      5432    # Postgres
      27017   # MongoDB
    ];
  };

  users.extraUsers.john.hashedPassword = "$5$CbQyg4oESLBLL8gR$YcXU4JKZEiHiZQkDZN64ssZyWCW03m6W/wC6ET2MVk/";

  services = {
    xserver.videoDrivers = ["nvidia" ];

    mongodb = {
      enable = true;
      bind_ip = "0.0.0.0";
    };

    postgresql = {
      enable = true;
      package = pkgs.postgresql_10;
      enableTCPIP = true;
      authentication = pkgs.lib.mkOverride 10 ''
        local all all trust
        host all all ::1/128 trust
        host all all 2601:40f:600:99b::/64 md5
        host all all 192.168.1.1/24 md5
      '';
    };

    openssh = {
      permitRootLogin = "no";
      passwordAuthentication = false;
      extraConfig = ''
        Match Address ::1
                PermitRootLogin yes
      '';
    };
  };
}
