let

  virt = {
    environment.variables.TERM = "xterm-color";

    deployment.targetEnv = "container";

    # deployment.targetEnv = "virtualbox";
    # deployment.virtualbox = {
    #   memorySize = 4096;
    #   headless = false;
    # };

  };
in {
  fray = virt // { networking.hostName = "fray-v"; };
  tattletale = virt // { networking.hostName = "tattle-v"; };
}
