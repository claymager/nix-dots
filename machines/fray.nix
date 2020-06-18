# Edit this configuration file to define what should be installed on
# this specific machine.

{ config, pkgs, ... }:

{
  imports = [ ../logical-machines/fray.nix ../physical-machines/laptop.nix ];

  networking.hostName = "fray";
}
