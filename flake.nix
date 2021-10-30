{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  inputs.secrets.url = "/etc/nixos/private/";

  outputs = { self, nixpkgs, nixos-hardware, secrets }: {
    nixosConfigurations =
      let
        basic = import ./modules/common.nix;
        server-modules = [
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-pc-ssd
          (import ./metal/server.nix)
        ];
        laptop-modules = [
          nixos-hardware.nixosModules.dell-xps-15-9550-nvidia
          (import ./metal/laptop.nix)
        ];
      in
      rec {
        tattletale = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = server-modules ++ [
            secrets.nixosModule
            basic
            (import ./hosts/tattletale.nix secrets.passThru)
          ];
        };
        fray = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            secrets.nixosModule
            basic
            (import ./hosts/fray.nix)
          ];
        };
      };
    nixopsConfigurations = {
      network.storage.memory  = {};
    };
  };
}
