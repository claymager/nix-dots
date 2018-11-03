# Edit this configuration file to define what should be installed on
# this specific machine.

{ config, pkgs, ... }:

{
  imports =
    [
      ../base.nix
      ../../hardware-configuration.nix
    ];

  # Bumblebee!
  #hardware.bumblebee.enable = true;
  #hardware.bumblebee.connectDisplay = true;

  hardware.bluetooth.enable = true;

  networking.hostName = "wyvern";
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  #programs.bash.enableCompletion = true;
  #programs.mtr.enable = true;
  #programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Enable the OpenSSH daemon.
  #services.openssh.enable = true;

  # Open ports in the firewall.
  #networking.firewall.allowedTCPPorts = [ 5900 5901 5902 5903];
  #networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  #networking.firewall.enable = false;
  #networking.networkmanager.enable = true;


  services = {
    # Enable the X11 windowing system.
    xserver.enable = true;
    xserver.videoDrivers = ["nvidia" ];

    mongodb.enable = true;
    postgresql.enable = true;
    #printing.enable = true;
    sshd.enable = true;
  };

#  systemd.services.nvidia-control-devices = {
#    wantedBy = [ "multi-user.target" ];
#    serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11}/bin/nvidia-smi";
#  };

  virtualisation.docker.enable = true;
}
