{ config, pkgs, ... }:

{
  imports = [ ../modules/common.nix ];

  profiles.gui.enable = true;
  profiles.dev.enable = true;

  users.extraUsers.john.hashedPassword =
    "$5$CbQyg4oESLBLL8gR$YcXU4JKZEiHiZQkDZN64ssZyWCW03m6W/wC6ET2MVk/";

  containers.sverige = {
    path = ./sverige.nix;
    enableTun = true;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";
    autoStart = false;
  };

  containers.jellyfin = {
    path = ./jellyfin.nix;
    bindMounts = {
      "/media/movies" = { hostPath = "/home/john/videos"; isReadOnly = false; };
    };
    autoStart = true;
  };

  containers.kenz = {
    path = ./kenz.nix;
    autoStart = true;
  };

  hardware = {
    opengl.driSupport32Bit = true;
    pulseaudio.support32Bit = true;
  };
  environment.systemPackages = [ pkgs.steam ];

  networking = {
    firewall.allowedTCPPorts = [
      5432 # Postgres
      80
      # 443
      27017 # MongoDB
      # 8096 # jellyfin
      # 32400   # Plex
    ];

    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      externalInterface = "enp31s0";
    };
  };

  # nix.nixPath = [
  #   "local=/nixpkgs"
  #   # "nixos-config=/etc/nixos/configuration.nix"
  #   # "/nix/var/nix/profiles/per-user/root/channels"
  # ];

  networking.firewall.extraCommands = ''
    ip46tables -A nixos-fw -p tcp -m tcp --tcp-flags SYN,ACK,FIN,RST SYN -m length --length 60 --dport 32469 -j nixos-fw-refuse
  '';

  services = {
    cron.enable = true;
    xserver.videoDrivers = [ "nvidia" ];

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
                PermitRootLogin without-password
      '';
    };
  };

  # virtualisation.virtualbox.host.enable = true;
}
