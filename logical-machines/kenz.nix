{ config, pkgs, ... }:

{
  services = {
    httpd = {
      enable = true;
      adminAddr = "jmageriii@gmail.com";
      virtualHosts = {
        "jellyfin.lan".locations."/".proxyPass = "http://jellyfin.lan:8096/";
        "kenz.lan".locations."/".proxyPass = "http://localhost:3000/" ;
        "lisa.lan" = { documentRoot = "/home"; };
        "tattletale.lan" = { documentRoot = "/webroot"; };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
