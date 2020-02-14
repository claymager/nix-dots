# Edit this configuration file to define what should be installed on
# this specific machine.

{ config, pkgs, ... }:

{
  imports =
    [
      ./generated/server.nix
      <nixos-hardware/common/cpu/amd>
      <nixos-hardware/common/pc/ssd>
    ];

  boot = {
    supportedFilesystems = [ "ntfs" ];
    kernelModules = [
      "i2c-dev" # i2c bus utility for periferals
      "nct6775" # hardware sensors
      "amd-kvm" # amd virtualisation
    ];

    loader.systemd-boot = {
      enable = true;
      editor = false;
      consoleMode = "max";
    };
    loader.efi.canTouchEfiVariables = true;
  };

  hardware.bluetooth.enable = true;
  environment.systemPackages = with pkgs; [
    ddcutil   # software control of vga monitor
  ];
  programs.fish.interactiveShellInit = ''
    function bright
      sudo ddcutil --bus=9 setvcp 10 $argv
    end
  '';

  location = {
    latitude = 41.88;
    longitude = -87.62;
  };


  services.udev.extraRules = ''
    SUBSYSTEM=="tty", ATTRS{idVendor}=="feed", ATTRS{idProduct}=="1337", ATTRS{serial}=="0", MODE="0666", SYMLINK+="georgi"
  '';
}
