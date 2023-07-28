{
    description = "A very basic flake";
  
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/master";
    };
    outputs = { self, nixpkgs }:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config = {
                allowUnfree= true;
            };
        };
    in
    {
        nixosConfigurations = {
            myNixos = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit system; };
                modules = [
                  ./configuration.nix
                ];
            };
        };
    };
}
