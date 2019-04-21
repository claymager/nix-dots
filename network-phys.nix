
{
  frey = 
    { config, pkgs, ... }:
    {
      deployment.targetHost = "fec0::2";
      # deployment.targetHost = "::1";
      # deployment.targetPort = 22922;
    };
  tattletale = 
    { config, pkgs, ... }:
    { deployment.targetHost = "::1";
    };
}
