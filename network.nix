{
  network.description = "home network";

  fray = import ./logical-machines/fray.nix;
  tattletale = import ./logical-machines/tattletale.nix;
}
