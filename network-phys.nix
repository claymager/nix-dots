let

  myHosts = (import ./private/secrets.nix).hosts;

in
{

  fray = {
    deployment.targetHost = "192.168.1.202";
    imports = [ ./metal/laptop.nix ];
    networking.extraHosts = myHosts;
    # deployment.targetHost = "::1";
    # deployment.targetPort = 22922;
  };

  tattletale = {
    deployment.targetHost = "::1";
    imports = [ ./metal/server.nix ];
    networking.extraHosts = myHosts;
  };

}
