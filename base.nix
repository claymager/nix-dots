# Edit this configuration file to define what should be installed on
# all systems.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  imports = [
    ./fish
    ./pia
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.extraHosts = ''
    2601:40f:600:99b::83e8     frey_wlan
    2601:40f:600:99b::8308     frey
    2601:40f:600:99b::6250     lisa
    24.128.157.105       tattletale
    '';

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

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
      myNeovim = import ./nvim;
      guiPackages = if config.services.xserver.enable then
          [ (conky.override {
              nvidiaSupport=true;
              pulseSupport=true;
            })
            discord
            feh
            google-chrome
            kitty
            pavucontrol
            playerctl
            qutebrowser
            scrot
            slack
            spotify
            vlc
            xclip
            xkb_switch
          ] else [ ];
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
        myNeovim
        neovim-remote
        texlive.combined.scheme-full
        pass
        pavucontrol
        pciutils
        todo-txt-cli
        tree
        wget
      ] ++ guiPackages;
  };

  fonts.enableFontDir = true;
  fonts.fonts = with pkgs; [
    #fantasque-sans-mono # installed imperatively for alpha version
    fira-code
    corefonts
    terminus_font
    font-awesome_5
    hasklig
  ];

  networking.firewall = {
    allowedTCPPorts = [ 17500 ];
    allowedUDPPorts = [ 17500 ];
    # 17500 : Dropbox
  };

  services = {
    xserver = {
      # keyboard
      layout = "us";
      xkbVariant = "altgr-intl";
      xkbOptions = "nodeadkeys";

      windowManager = {
        xmonad.enable = true;
        xmonad.enableContribAndExtras = true;
        default = "xmonad";
      };

      displayManager.slim = {
        enable = true;
        theme = pkgs.fetchurl {
          url = "https://github.com/edwtjo/nixos-black-theme/archive/v1.0.tar.gz";
          sha256 = "13bm7k3p6k7yq47nba08bn48cfv536k4ipnwwp1q1l2ydlp85r9d";
        };
        defaultUser = "john";
      };

      desktopManager.xterm.enable = false;
    };

    unclutter.enable = true;
    redshift = {
      enable = true;
      latitude = "41.881";
      longitude = "-87.623";
      temperature.night = 3000;
    };
  };

  users.extraUsers.john = {
    isNormalUser = true;
    home = "/home/john";
    extraGroups = [ "wheel" "networkmanager" "audio" "docker"];
    shell = "/run/current-system/sw/bin/fish";
    uid = 1000;
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
      ExecStart = "${pkgs.dropbox.out}/bin/dropbox start";
      ExecReload = "${pkgs.coreutils.out}/bin/kill -HUP $MAINPID";
      KillMode = "control-group"; # upstream recommends process
      Restart = "on-failure";
      PrivateTmp = true;
      ProtectSystem = "full";
      Nice = 10;
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
  system.fsPackages = [ pkgs.exfat ];

}
