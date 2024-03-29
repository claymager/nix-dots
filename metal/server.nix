# Edit this configuration file to define what should be installed on
# this specific machine.

{ config, pkgs, ... }:

{
  imports = [
    ./generated/server.nix
  ];

  boot = {
    supportedFilesystems = [ "zfs" "ntfs" ];
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

  networking.hostId = "f985e230";
  services.xserver.screenSection = ''
    Option         "metamodes" "nvidia-auto-select +0+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
  '';
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.enableAllFirmware = true;
  hardware.opentabletdriver = {
    daemon.enable = true;
    enable = true;
  };

  environment.systemPackages = with pkgs;
    [
      ddcutil # software control of vga monitor
    ];
  programs.fish.interactiveShellInit = ''
    function bright
      sudo ddcutil --bus=6 setvcp 10 $argv
    end
  '';

  location = {
    latitude = 41.88;
    longitude = -87.62;
  };

  services.udev.extraRules = ''
    SUBSYSTEMS=="tty", ATTRS{idVendor}=="feed", ATTRS{idProduct}=="1337", ATTRS{serial}=="0", MODE="0666", SYMLINK+="georgi"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2341", ATTRS{idProduct}=="0037", MODE="0666"
  '';
}
