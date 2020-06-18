{ config, pkgs, ... }:

{
  services = {
    httpd = {
      enable = true;
      adminAddr = "jmageriii@gmail.com";
      virtualHosts = {
        "kenz.lan".locations."/".extraConfig = ''
          ProxyPass http://kenz.lan:3000/
          ProxyPreserveHost On
        '';

        "lisa.lan" = { documentRoot = "/home"; };

        "tattletale.lan" = { documentRoot = "/webroot"; };
      };
    };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
