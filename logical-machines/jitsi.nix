{ config, pkgs, ... }: {
  services.jitsi-meet = {
    enable = true;
    hostName = "jitsi.lan";
  };
  services.jitsi-videobridge.openFirewall = true;
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  security.acme = {
    email = "jmageriii@gmail.com";
    acceptTerms = true;
  };
}
