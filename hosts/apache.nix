{ config, pkgs, ... }: {
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
}
