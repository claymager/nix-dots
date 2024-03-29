{ config, pkgs, ... }:

{
  profiles.dev.enable = true;
  profiles.gui.enable = true;

  users.extraUsers.john.hashedPassword =
    "$5$QIlpPxYhSVGcTd8k$ISN3TP3r1iLag2YB1Tw3vQ2oTrC8It.wcxUmplfAM94";

  environment.systemPackages = [ pkgs.ripgrep ];

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
