{ config, pkgs, ... }:

let
  nameServer = "209.222.18.218";
  nameServerAlt = "209.222.18.222";
  vpnServer = "45.12.220.0/24";

in

{
  imports = [ ../modules/common.nix ];

  services = {
    openssh.forwardX11 = true;
    pia = {
      enable = true;
      authFile = "${./..}/private/pia.conf";
    };
  };

  environment.systemPackages = with pkgs; [ rtorrent chromium ];

  systemd.timers.openvpn-sweden = {
    description = "automatically start openvpn";
    wantedBy = [ "multi-user.target" ];
    timerConfig.OnBootSec = "0";
  };

  networking.resolvconf.extraConfig = ''
    name_servers='${nameServer}'
    name_servers_append='${nameServerAlt}'
  '';

  networking.firewall.extraCommands = ''
    ip46tables -N vpn-fw
    ip46tables -A OUTPUT -j vpn-fw

    # allow local ssh
    iptables -A vpn-fw -p tcp --dest 192.168.0.0/16 --sport 22 -j ACCEPT -m state --state ESTABLISHED

    # DNS
    iptables -A vpn-fw -j nixos-fw-accept --dest ${nameServer}
    iptables -A vpn-fw -j nixos-fw-accept --dest ${nameServerAlt}

    # connect to vpn
    iptables -A vpn-fw -j nixos-fw-accept -p udp --dest ${vpnServer} --dport 1198

    # The loopback device is harmless, and TUN is required for the VPN.
    ip46tables -A vpn-fw -j nixos-fw-accept -o lo
    ip46tables -A vpn-fw -j nixos-fw-accept -o tun0

    # The default policy, if no other rules match, is to refuse traffic.
    ip46tables -A vpn-fw -j nixos-fw-log-refuse
  '';

}
