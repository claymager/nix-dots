# Edit this configuration file to define what should be installed on
# this specific machine.

{ config, pkgs, ... }:

{
  imports =
    [ ../logical-machines/tattletale.nix ../physical-machines/server.nix ];

  networking.hostName = "tattletale";
}
