{
	description = "flakes :3";
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.11";
        stylix = {
            url = "github:nix-community/stylix/release-25.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        
        hyprland = {
            url = "github:hyprwm/Hyprland";
        };
            
        nixvim = {
			url = "github:nix-community/nixvim/nixos-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};	
		
		home-manager = {
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		zen-browser = {
			url = "github:0xc000022070/zen-browser-flake";
			inputs = {
				# IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
				# to have it up-to-date or simply don't specify the nixpkgs input
				#nixpkgs.follows = "nixpkgs";
				home-manager.follows = "home-manager";

			};
		};
	};

outputs = {nixpkgs, ... } @inputs: 
	let
		system = "x86_64-linux";
		username = "xvr6";
	in {
		nixosConfigurations = {
            #macbook vm
            nixbook-pro = nixpkgs.lib.nixosSystem {
                inherit system;
                pkgs = import nixpkgs {
                    system = "aarch64-linux";
                    config.allowUnfree = true;
                };
                specialArgs = {inherit inputs system username; };
                modules = [
                    ./modules/systems/graphical.nix
                    ./modules/systems/nixbook-pro/configuration.nix
                    inputs.home-manager.nixosModules.home-manager
                    {
                        home-manager = {
                            useGlobalPkgs = true;
                            useUserPackages = true;
                            extraSpecialArgs = { inherit inputs system username; };
                            users.${username} = import ./home.nix;
                            backupFileExtension = "backup";
                        	overwriteBackup = true;
			};
                    }
                ];
                
            };

            
            # Windows Hyper-V VM
            win-NixVM = nixpkgs.lib.nixosSystem {
                    inherit system;
                    pkgs = import nixpkgs {
                        system = "x86_64-linux";
                        config.allowUnfree = true;
                    };

                    # imports for modules basically
                    specialArgs = { inherit inputs system username; };
                    modules = [               
                        ./modules/systems/graphical.nix
                        ./modules/systems/win-nixvm/configuration.nix
                        inputs.home-manager.nixosModules.home-manager
                        {		
                            home-manager = {
                               # useGlobalPkgs = true;
                                useUserPackages = true;
                                extraSpecialArgs = { inherit inputs system username; };
                                users.${username} = import ./home.nix;
                                backupFileExtension = "backup";
                            };
                        }
                    ];
                };
            };
        };
}
