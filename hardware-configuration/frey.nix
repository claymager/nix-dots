# Edit this configuration file to define what should be installed on
# this specific machine.

{ config, pkgs, ... }:

{
  imports =
    [
      ../hardware-configuration/generated/frey.nix
      <nixos-hardware/dell/xps/15-9550>
    ];

  boot.kernelParams = [ "acpi_rev_override" ];

  hardware = {
    bluetooth.enable = true;
    bumblebee = {
      enable = true;
      connectDisplay = true;
    };
  };

  # programs.light.enable = true; # no-op since 19.03

  services.udev.extraRules = ''SUBSYSTEM=="power_supply", KERNEL=="BAT0", ATTR{status}=="Discharging", ATTR{capacity}=="[0-19]", RUN+="${pkgs.systemd}/bin/systemctl hibernate"'';

  # systemd.services.nvidia-control-devices = {
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11}/bin/nvidia-smi";
  # };

  networking.interfaces.wlp2s0 = {
    useDHCP = true;
    ipv6.addresses = [
      { address = "fec0::2";
        prefixLength = 10;
      }
    ];
  };

}
