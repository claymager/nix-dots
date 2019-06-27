# Edit this configuration file to define what should be installed on
# this specific machine.

{ config, pkgs, ... }:

{
  imports =
    [
      ../logical-machines/frey.nix
     ../physical-machines/laptop.nix
    ];

  networking.hostName = "frey";
}
