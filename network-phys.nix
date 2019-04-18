
{
  frey = 
    { config, pkgs, ... }:
    { deployment.targetHost = "192.168.1.16";
    };
  tattletale = 
    { config, pkgs, ... }:
    { deployment.targetHost = "::1";
    };
}
