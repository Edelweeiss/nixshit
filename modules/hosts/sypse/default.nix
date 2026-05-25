{ self, inputs, ... }: {
  flake.nixosConfigurations.sypse = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.sypseConfiguration ];
  };
}
