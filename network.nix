{
  network.description = "home network";

  fray = import ./hosts/fray.nix;
  tattletale = import ./hosts/tattletale.nix;
}
