# Edit this configuration file to define what should be installed on
# this specific machine.

{ config, pkgs, ... }:

{
  imports = [ ../modules/common.nix ];

  profiles.dev.enable = true;
  profiles.gui.enable = true;

  users.extraUsers.john.hashedPassword =
    "$5$QIlpPxYhSVGcTd8k$ISN3TP3r1iLag2YB1Tw3vQ2oTrC8It.wcxUmplfAM94";

  networking.networkmanager.enable = true;

  services = {
    mongodb.enable = true;

    postgresql = {
      enable = true;
      package = pkgs.postgresql_10;
      enableTCPIP = true;
    };

    printing = {
      enable = true;
      drivers = [ pkgs.brlaser pkgs.brgenml1lpr pkgs.brgenml1cupswrapper ];
    };
  };

}
