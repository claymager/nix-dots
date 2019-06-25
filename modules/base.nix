# Edit this configuration file to define what should be installed on
# all systems.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let

  secrets = import ../private/secrets.nix;

in

{
  imports = [
    ./fish
  ];


  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "America/Detroit";

  nixpkgs.config = {
    allowUnfree = true;
  };

  environment = {
    systemPackages = with pkgs; [
      bat
      git
      gnupg
      htop
      tree
      wget
    ];
  };

  users = {
    mutableUsers = false;
    users.root = {
      openssh.authorizedKeys.keys = secrets.keys;
      initialHashedPassword = "$5$MqXY9HEJ6cgytphv$6mENYjITeTIm2nW8LzvUK4XC6.8Z31K/iXFs3a4TlX6";
    };
    extraUsers.john = {
      isNormalUser = true;
      home = "/home/john";
      extraGroups = [ "wheel" "networkmanager" "vboxusers" "audio" "docker"];
      shell = "${pkgs.fish}/bin/fish";
      openssh.authorizedKeys.keys = secrets.keys;
      initialHashedPassword = "$5$eFedV/r0fU9/3XwL$89FMUzv.t.EosfEQhDvRSrvX3t4LeDRrqMxXpkJ/HH6";
      uid = 1000;
    };
  };


  services.openssh.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
  system.fsPackages = [ pkgs.exfat ];

}
