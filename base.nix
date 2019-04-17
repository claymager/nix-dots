# Edit this configuration file to define what should be installed on
# all systems.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let

  secrets = import ./private/secrets.nix;

in

{
  imports = [
    ./fish
    ./pia
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
    systemPackages = with pkgs; let
      nvimPkgs = [
        (import ./nvim)
        neovim-remote
        (python3.withPackages(ps: [
          ps.python-language-server
          ps.pyls-mypy ps.pyls-isort ps.pyls-black
      ]))];
      in [
        alsaUtils
        bat
        #cudatoolkit
        dropbox-cli
        file
        git
        gnupg
        htop
        lm_sensors
        mongodb-tools
        pass
        pciutils
        todo-txt-cli
        tree
        wget
      ] ++ nvimPkgs;
  };

  networking.extraHosts = secrets.hosts;

  networking.firewall = {
    allowedTCPPorts = [ 17500 ];
    allowedUDPPorts = [ 17500 ];
    # 17500 : Dropbox
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

  systemd.user.services.dropbox = {
    description = "Dropbox";
    wantedBy = [ "graphical-session.target" ];
    environment = {
      QT_PLUGIN_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtPluginPrefix;
      QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
      HOME = "%h/.dropbox";
    };
    serviceConfig = {
      ExecStart = "${pkgs.dropbox}/bin/dropbox start";
      ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
      KillMode = "control-group"; # upstream recommends process
      Restart = "on-failure";
      PrivateTmp = true;
      ProtectSystem = "full";
      Nice = 10;
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
