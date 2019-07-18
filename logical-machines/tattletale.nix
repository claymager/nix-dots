{ config, pkgs, ... }:

{
  imports = [ ../modules/common.nix ];

  profiles.gui.enable = true;
  profiles.dev.enable = true;

  users.extraUsers.john.hashedPassword = "$5$CbQyg4oESLBLL8gR$YcXU4JKZEiHiZQkDZN64ssZyWCW03m6W/wC6ET2MVk/";

  networking = {
    firewall.allowedTCPPorts = [
      5432    # Postgres
      27017   # MongoDB
    ];

    nat = {
      enable = true;
      internalInterfaces = ["ve-+"];
      externalInterface = "enp31s0";
    };
  };

  nix.nixPath = [
    "nixpkgs=/nixpkgs"
    "nixos-config=/etc/nixos/configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

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
                PermitRootLogin forced-commands-only
      '';
    };
  };

  virtualisation.virtualbox.host.enable = true;
}
