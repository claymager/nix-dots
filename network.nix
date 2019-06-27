{
  network.description = "home network";

  frey = import ./logical-machines/frey.nix;
  tattletale = import ./logical-machines/tattletale.nix;
}
