{
    description = "NixOS first install from scratch";
    inputs = {
        nixpkgs.url = "nixpkgs/release-26.05";

	#Home-manager
        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
	
    };

    outputs = { self, nixpkgs, home-manager, zephyr-nix, ... }@inputs: 
        let
            system = "x86_64-linux";
	    pkgs = nixpkgs.legacyPackages.${system};
	    zephyr = zephyr-nix.packages.${system};
        in
        {
            nixosConfigurations = {
                barkopc = nixpkgs.lib.nixosSystem {
                    modules = [
                        ./hosts/barkopc/configuration.nix
                        home-manager.nixosModules.home-manager
                        {  
                            home-manager = {
                                useGlobalPkgs = true;
                                useUserPackages = true;
                                users.orca = import ./hosts/barkopc/home.nix;
                                backupFileExtension = "backup";
                            };
                        }
                    ];
                };
                twinkpad = nixpkgs.lib.nixosSystem {
                    modules = [
                        ./hosts/twinkpad/configuration.nix
                        home-manager.nixosModules.home-manager
                        {  
                            home-manager = {
                                useGlobalPkgs = true;
                                useUserPackages = true;
                                users.barko = import ./hosts/twinkpad/home.nix;
                                backupFileExtension = "backup";
                            };
                        }
                    ];
                };
            };
	};
}
