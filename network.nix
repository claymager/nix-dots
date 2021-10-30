{
  network.description = "home network";
  network.storage.legacy = { };

  fray = import ./hosts/fray.nix;
  tattletale = import ./hosts/tattletale.nix;
}
