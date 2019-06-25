
{
  frey = 
    { config, pkgs, ... }:
    {
      deployment.targetHost = "fe80::305b:6fcb:541b:5b85";
      # deployment.targetHost = "::1";
      # deployment.targetPort = 22922;
    };
  tattletale = 
    { config, pkgs, ... }:
    { deployment.targetHost = "::1";
    };
}
