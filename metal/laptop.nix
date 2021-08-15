# Edit this configuration file to define what should be installed on
# this specific machine.

{ config, pkgs, ... }:

{
  imports = [ ./generated/laptop.nix ];

  boot.kernelParams = [ "acpi_rev_override" ];

  networking.networkmanager.enable = true;

  hardware = {
    bluetooth.enable = true;
    bumblebee = {
      enable = true;
      connectDisplay = true;
    };
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", KERNEL=="BAT0", ATTR{status}=="Discharging", ATTR{capacity}=="[0-19]", RUN+="${pkgs.systemd}/bin/systemctl hibernate"
  '';

  networking.interfaces.wlp2s0 = {
    useDHCP = true;
    ipv6.addresses = [{
      address = "fec0::2";
      prefixLength = 10;
    }];
  };

}
