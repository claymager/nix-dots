backend: { config, pkgs, ... }: {
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

    virtualHosts =
      let
        inherit (builtins) split head;

        forceSSL = vhost:
          vhost // {
            forceSSL = true;
            enableACME = true;
          };

        ipv4 = vm: head (split "/" vm.localAddress);

        proxy = vm: port:
          {
            locations."/".proxyPass = "http://${ipv4 vm}:${toString port}/";
          };
      in
      {
        "tattletale.lan" = forceSSL {
          root = "/var/log/nginx";
          locations."/jellyfin/".proxyPass =
            "http://${ipv4 backend.jellyfin}:8096/";
          locations."/apache/".proxyPass =
            "http://${ipv4 backend.apacheEtc}/";
        };
        "apache.tattletale.lan" = proxy backend.apacheEtc 80 // {
          serverAliases = [ "apache.lan" ];
        };
        "jellyfin.tattletale.lan" = proxy backend.jellyfin 8096 // {
          serverAliases = [ "lisa.lan" "jellyfin.lan" ];
        };
        "notebook.tattletale.lan" = {
          locations."/".proxyPass = "https://localhost:3000/";
        };
        "kenz.lan" = {
          root = "/www";
          default = true;
        };
      };
  };
  networking.firewall.allowedTCPPorts = [ 80 443 3000 ];
}
