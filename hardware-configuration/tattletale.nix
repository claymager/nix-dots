# Edit this configuration file to define what should be installed on
# this specific machine.

{ config, pkgs, ... }:

{
  imports =
    [
      ../hardware-configuration/generated/tattletale.nix
      <nixos-hardware/common/cpu/amd>
      <nixos-hardware/common/pc/ssd>
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [
    "i2c-dev" # i2c bus utility for periferals
    "nct6775" # hardware sensors
    "amd-kvm" # amd virtualisation
  ];

  hardware.bluetooth.enable = true;

  networking.interfaces.enp31s0 = {
    useDHCP = true;
    ipv6.addresses = [
      { address = "fec0::1";
        prefixLength = 10;
      }
    ];
  };
}