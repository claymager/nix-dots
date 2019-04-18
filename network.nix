
{
  network.description = "home network";

  frey = import ./machines/frey.nix;
  tattletale = import ./machines/tattletale.nix;
}
