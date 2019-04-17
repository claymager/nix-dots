{ config, pkgs, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [ 17500 ];
    allowedUDPPorts = [ 17500 ];
  };

  environment.systemPackages = [ dropbox-cli ];

  systemd.user.services.dropbox = {
    description = "Dropbox";
    wantedBy = [ "graphical-session.target" ];
    environment = {
      QT_PLUGIN_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtPluginPrefix;
      QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
      HOME = "%h/.dropbox";
    };
    serviceConfig = {
      ExecStart = "${pkgs.dropbox}/bin/dropbox start";
      ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
      KillMode = "control-group"; # upstream recommends process
      Restart = "on-failure";
      PrivateTmp = true;
      ProtectSystem = "full";
      Nice = 10;
    };
  };
}
