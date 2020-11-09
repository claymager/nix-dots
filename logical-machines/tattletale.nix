{ config, pkgs, ... }:

{
  imports = [ ../modules/common.nix ];

  profiles.gui.enable = true;
  profiles.dev.enable = true;

  users.extraUsers.john.hashedPassword =
    "$5$CbQyg4oESLBLL8gR$YcXU4JKZEiHiZQkDZN64ssZyWCW03m6W/wC6ET2MVk/";

  containers = let
    onSubnet = id: vm:
      vm // {
        privateNetwork = true;
        hostBridge = "br0";
        localAddress = "192.168.5." + builtins.toString id + "/24";
        localAddress6 = "fc00::" + builtins.toString id + "/7";
        autoStart = true;
      };
  in rec {
    sverige = {
      config = import ./sverige.nix;
      enableTun = true;
      privateNetwork = true;
      hostAddress = "192.168.100.10";
      localAddress = "192.168.100.11";
      autoStart = false;
    };

    jellyfin = onSubnet 5 {
      config = import ./jellyfin.nix;
      bindMounts."/media/movies".hostPath = "/home/john/videos";
    };

    apacheEtc = onSubnet 4 {
      config = { config, pkgs, ... }: {
        services.httpd = {
          adminAddr = "jmageriii@gmail.com";
          enable = true;
          virtualHosts.default = {
            servedDirs = [{
              dir = "/";
              urlPath = "/";
            }];
          };
        };
        networking.firewall.allowedTCPPorts = [ 80 443 ];
      };
      ephemeral = true;
    };

    jitsiCont = onSubnet 3 {
      config = { config, pkgs, ... }: {
        services.jitsi-meet = {
          enable = true;
          hostName = "jitsi.lan";
        };
        services.jitsi-videobridge.openFirewall = true;
        networking.defaultGateway = "192.168.5.1";
        networking.firewall.allowedTCPPorts = [ 80 443 ];
        security.acme = {
          email = "jmageriii@gmail.com";
          acceptTerms = true;
        };
      };
      ephemeral = true;
    };

    kenz = {
      config = { config, pkgs, ... }: {
        security.acme = {
          email = "jmageriii@gmail.com";
          acceptTerms = true;
        };
        services.nginx = {
          enable = true;
          statusPage = true;
          recommendedProxySettings = true;

          virtualHosts = let
            forceSSL = vhost:
              vhost // {
                forceSSL = true;
                enableACME = true;
              };
            proxy = address:
              forceSSL { locations."/".proxyPass = "http://${address}/"; };
          in {
            "tattletale.lan" = forceSSL {
              root = "/var/log/nginx";
              locations."/jellyfin/".proxyPass =
                "http://${jellyfin.localAddress}:8096/";
              locations."/apache/".proxyPass =
                "http://${apacheEtc.localAddress}/";
            };
            "apache.tattletale.lan" = proxy apacheEtc.localAddress;
            "jellyfin.tattletale.lan" = proxy "${jellyfin.localAddress}:8096";
            "notebook.tattletale.lan" = proxy "${kenz.localAddress}:3000";
            "jitsi.lan" = proxy jitsiCont.localAddress;
            "kenz.lan" = forceSSL {
              root = "/www";
              default = true;
            };
          };
        };
        networking.firewall.allowedTCPPorts = [ 80 443 8888 ];
      };
      bindMounts."/www".hostPath = "/home/john/tmp";
      ephemeral = true;
      autoStart = true;
      privateNetwork = true;
      forwardPorts =
        [ { hostPort = 80; } { hostPort = 443; } { hostPort = 8888; } ];
      hostBridge = "br0";
      localAddress = "192.168.5.2/24";
    };
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
      3000
      # 8888 # jupyter notebook
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
    grafana.enable = true;

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
