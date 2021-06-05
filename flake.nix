{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  inputs.secrets.url = "/etc/nixos/private/";

  outputs = { self, nixpkgs, nixos-hardware, secrets }: {
    nixosConfigurations =
      let
        basic = import ./modules/common.nix;
        server-modules = [
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-pc-ssd
          (import ./physical-machines/server.nix)
        ];
        laptop-modules = [
          nixos-hardware.nixosModules.dell-xps-15-9550-nvidia
          (import ./physical-machines/laptop.nix)
        ];
      in
      {
        tattletale = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = server-modules ++ [
            secrets.nixosModule
            basic
            (import ./logical-machines/tattletale.nix secrets.passThru)
          ];
        };
        fray = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            secrets.nixosModule
            basic
            (import ./logical-machines/fray.nix)
          ];
        };
      };
  };
}
