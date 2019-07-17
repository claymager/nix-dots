{ config, pkgs, lib, ... }:

with lib;

let

  cfg = config.services.pia;

  pia-config = authFile: stdenv.mkDerivation rec {
    name = "pia-config";

    buildInputs = [
      pkgs.unzip
      pkgs.libuuid
    ];

    src = builtins.fetchurl {
      url = "https://www.privateinternetaccess.com/openvpn/openvpn.zip";
      sha256 = "0249zdi87mi3dsnjvpqkk7jx8f9d9kaffl676zlqp7hfgfcbix17";
    };

    unpackPhase = ''
      unzip $src
    '';

    installPhase = ''
      mkdir -p "$out/uuids"
      ls *.ovpn | while read FILE; do
        uuidgen --md5 -n @url -N "$FILE" > "$out/uuids/$FILE"
      done

      mkdir -p "$out/config"
      mv *.ovpn "$out/config"

      mkdir -p "$out/certs"
      mv *.crt *.pem "$out/certs"
    '';

    fixupPhase = ''
      sed -i "s|crl.rsa.2048.pem|$out/certs/\0|g" "$out"/config/*.ovpn
      sed -i "s|ca.rsa.2048.crt|$out/certs/\0|g" "$out"/config/*.ovpn

      sed -i "s|auth-user-pass|auth-user-pass ${authFile}|g" "$out"/config/*.ovpn
    '';
  };


in
{
  options.services.pia = {
    enable = mkEnableOption "private internet access vpn";
    authFile = mkOption {
      description = "path to pia auth-user-pass";
      type = types.str;
      default = "";
    };
  };


  config = mkIf cfg.enable {

    # environment.systemPackages = with pkgs; [
    #   openresolv
    # ];

    # Configure all our servers
    # Use with `sudo systemctl start openvpn-us-east`
    services.openvpn.servers =
      let
        vpn_str = with strings;
          file: removeSuffix ".ovpn" (toLower (replaceStrings [" "] ["-"] file));
      in
        foldl' (init: file: init // {
          "${vpn_str file}" = {
            config = readFile "${pia-config cfg.authFile}/config/${file}";
            autoStart = false;
            up = "echo nameserver $nameserver | ${pkgs.openresolv}/sbin/resolvconf -m 0 -a $dev";
            down = "${pkgs.openresolv}/sbin/resolvconf -d $dev";
          }; })
          {}
          ( attrNames (readDir "${pia-config cfg.authFile}/config"));

  };
}