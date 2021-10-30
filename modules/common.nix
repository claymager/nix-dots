# Edit this configuration file to define what should be installed on
# all systems.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports = (import ../modules/modules-list.nix) ++ [ ./../cachix.nix ];

  profiles.fish.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  time.timeZone = lib.mkDefault "America/Detroit";

  nixpkgs.config.allowUnfree = true;

  programs.gnupg.agent.enable = true;
  environment.systemPackages = with pkgs; [
    # bat
    # git
    lsof
    htop
    # tree
    wget
    ranger
    nixFlakes
    # highlight
  ];

  location = lib.mkDefault {
    latitude = 41.88;
    longitude = -87.62;
  };

  nix = {
    optimise.automatic = true;
    package = pkgs.nixUnstable;
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes ca-derivations ca-references
    '';
    # Binary cache for Haskell.nix
    binaryCachePublicKeys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    ];
    binaryCaches = [
      "https://hydra.iohk.io"
    ];
  };

  users = {
    mutableUsers = false;
    users.root = {
      initialHashedPassword =
        "$5$MqXY9HEJ6cgytphv$6mENYjITeTIm2nW8LzvUK4XC6.8Z31K/iXFs3a4TlX6";
    };
    extraUsers.john = {
      isNormalUser = true;
      home = "/home/john";
      extraGroups = [ "wheel" "networkmanager" "vboxusers" "audio" "docker" "plugdev" ];
      shell = "${pkgs.fish}/bin/fish";
      initialHashedPassword =
        "$5$eFedV/r0fU9/3XwL$89FMUzv.t.EosfEQhDvRSrvX3t4LeDRrqMxXpkJ/HH6";
      uid = 1000;
    };
    groups = { plugdev = { }; };
  };

  services.openssh = { enable = true; };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?
  system.fsPackages = [ pkgs.exfat ];
}
