{ config, pkgs, lib, ... }:

{
  imports = [ ../modules/common.nix ];

  profiles.gui.enable = true;
  profiles.dev.enable = true;

  users.extraUsers.john.hashedPassword =
    "$5$CbQyg4oESLBLL8gR$YcXU4JKZEiHiZQkDZN64ssZyWCW03m6W/wC6ET2MVk/";

  containers = let
    subnet = "192.168.5.";
    hostConfig = config;

    composeConfigs = conf: new:
      { config, pkgs, ... }@args:
      lib.recursiveUpdate (conf args) (new args);

    onSubnet = id: vm:
      lib.recursiveUpdate vm {
        privateNetwork = true;
        config = composeConfigs vm.config ({ config, pkgs, ... }: {
          networking.defaultGateway = "${subnet}1";
          networking.extraHosts = ''
            ${subnet}1  ${hostConfig.networking.hostName};
          '';
        });
        hostBridge = "br0";
        localAddress = subnet + builtins.toString id + "/24";
        localAddress6 = "fc00::" + builtins.toString id + "/7";
        autoStart = true;
      };

    jellyfin = onSubnet 5 {
      config = import ./jellyfin.nix;
      bindMounts."/media/movies".hostPath = "/home/john/videos";
    };

    apacheEtc = onSubnet 4 {
      config = import ./apache.nix;
      ephemeral = true;
    };

    jitsiCont = onSubnet 3 {
      config = import ./jitsi.nix;
      ephemeral = true;
    };

    backend = { inherit jellyfin apacheEtc jitsiCont; };

  in backend // rec {

    kenz = onSubnet 2 {
      config = { config, pkgs, ... }: {
        security.acme = {
          email = "jmageriii@gmail.com";
          acceptTerms = true;
        };
        services.nginx = {
          enable = true;
          statusPage = true;
          recommendedProxySettings = true;
          recommendedGzipSettings = true;
          recommendedOptimisation = true;

          virtualHosts = let
            inherit (builtins) split head toString;

            forceSSL = vhost:
              vhost // {
                addSSL = true;
                enableACME = true;
              };

            ipv4 = vm: head (split "/" vm.localAddress);

            proxy = vm: port:
              forceSSL {
                locations."/".proxyPass = "http://${ipv4 vm}:${toString port}/";
              };
          in {
            "tattletale.lan" = forceSSL {
              root = "/var/log/nginx";
              locations."/jellyfin/".proxyPass = "http://${ipv4 backend.jellyfin}:8096/";
              locations."/apache/".proxyPass = "http://${ipv4 backend.apacheEtc}/";
            };
            "apache.tattletale.lan" = proxy backend.apacheEtc 80 // {
              serverAliases = ["apache.lan"];
            };
            "jellyfin.tattletale.lan" = proxy backend.jellyfin 8096 // {
              serverAliases = [ "lisa.lan" "jellyfin.lan" ];
            };
            "notebook.tattletale.lan" = proxy kenz 3000;
            "jitsi.lan".locations."/".proxyPass = "https://${ipv4 backend.jitsiCont}/";
            "kenz.lan" = forceSSL {
              root = "/www";
              default = true;
            };
          };
        };
        networking.firewall.allowedTCPPorts = [ 80 443 3000 ];
      };
      bindMounts."/www".hostPath = "/home/john/tmp";
      ephemeral = true;
      forwardPorts =
        [ { hostPort = 80; } { hostPort = 443; } { hostPort = 3000; } ];
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

    bridges.br0.interfaces = [ ];

    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" "br0" ];
      externalInterface = "enp31s0";
    };

    interfaces.br0 = {
      ipv4.addresses = [{
        address = "192.168.5.1";
        prefixLength = 24;
      }];
      ipv6.addresses = [{
        address = "fc00::1";
        prefixLength = 7;
      }];
    };

    firewall.extraCommands = ''
      ip46tables -A nixos-fw -p tcp -m tcp --tcp-flags SYN,ACK,FIN,RST SYN -m length --length 60 --dport 32469 -j nixos-fw-refuse
    '';
  };

  # nix.nixPath = [
  #   "local=/nixpkgs"
  #   # "nixos-config=/etc/nixos/configuration.nix"
  #   # "/nix/var/nix/profiles/per-user/root/channels"
  # ];

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
