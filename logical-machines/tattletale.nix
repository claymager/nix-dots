secrets: { config, pkgs, lib, ... }:

{
  profiles.gui.enable = true;
  profiles.dev.enable = true;

  users.extraUsers.john.hashedPassword =
    "$5$CbQyg4oESLBLL8gR$YcXU4JKZEiHiZQkDZN64ssZyWCW03m6W/wC6ET2MVk/";

  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = [{ command = "${pkgs.ddcutil}/bin/ddcutil"; options = [ "NOPASSWD" ]; }];
    }
  ];

  containers =
    let
      inherit (lib) recursiveUpdate imap listToAttrs attrNames;
      inherit (builtins) toString;

      host-hostName = config.networking.hostName;

      composeConfigs = conf: new:
        { config, pkgs, ... }@args:
        recursiveUpdate (conf args) (new args);

      imapAttrs = f: set:
        listToAttrs (imap
          (i: attr: {
            name = attr;
            value = f i attr set.${attr};
          })
          (attrNames set));

      onSubnet = i: name: vm:
        let
          id = i + 3;
          subnetMask = "192.168.5.";
        in
        recursiveUpdate vm {
          privateNetwork = true;
          config = composeConfigs vm.config ({ config, pkgs, ... }: {
            networking.defaultGateway = "${subnetMask}1";
            networking.extraHosts = ''
              ${subnetMask}1  ${host-hostName};
            '';
          });
          hostBridge = "br0";
          localAddress = subnetMask + toString id + "/24";
          localAddress6 = "fc00::" + toString id + "/7";
          autoStart = true;
        };

      backend = imapAttrs onSubnet {
        jellyfin = {
          config = import ./jellyfin.nix;
          bindMounts."/media/movies".hostPath = "/home/john/videos";
        };

        apacheEtc = {
          config = import ./apache.nix;
          ephemeral = true;
        };

        jitsiCont = {
          config = import ./jitsi.nix;
          ephemeral = true;
        };
      };

    in
    backend // rec {

      sverige = {
        config = import ./sverige.nix secrets.piaAuth;
        enableTun = true;
        privateNetwork = true;
        hostAddress = "192.168.100.10";
        localAddress = "192.168.100.11";
        autoStart = true;
      };

      kenz = onSubnet (-1) "kenz" {
        config = import ./kenz.nix backend;
        bindMounts."/www".hostPath = "/home/john/public/kenz.lan/";
        ephemeral = true;
        forwardPorts =
          [{ hostPort = 80; } { hostPort = 443; } { hostPort = 3000; }];
      };
    };

  programs.steam.enable = true;

  networking = {
    hostName = "tattletale";
    firewall.allowedTCPPorts = [
      80
      443
      # 3000 # Grafana
      # 5432 # Postgres
      # 8096 # jellyfin
      # 8888 # jupyter notebook
      # 27017 # MongoDB
      # 32400 # Plex
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

    # Some IOT things on the network keep pinging this port
    firewall.extraCommands = ''
      ip46tables -A nixos-fw -p tcp -m tcp --tcp-flags SYN,ACK,FIN,RST SYN -m length --length 60 --dport 32469 -j nixos-fw-refuse
    '';
  };

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
    };
  };

  virtualisation.virtualbox.host.enable = true;

}
