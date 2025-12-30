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

outputs = { nixpkgs, ... } @inputs: 
	let
		system = "aarch64-linux";
		username = "xvr6";
	in {

		nixosConfigurations = {

        # original UTM VM on my mac
			nixbook-pro = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs system username; };
				modules = [
					./modules/systems/graphical.nix
					./modules/systems/nixbook-pro/configuration.nix
					({ config, ... }: {
						home-manager = {
							backupFileExtension = "backup";
							users.${username} = {
								imports = [ ./home.nix ];
							};
						}; 
					})
				];
			};

        # Windows Hyper-V VM
			win-NixVM = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				specialArgs = { inherit inputs system username; };
				pkgs = import nixpkgs {
                    system = "x86_64-linux";
                    config.allowUnfree = true;
                };
                modules = [
                    inputs.hyprland.nixosModules.default
                    inputs.stylix.nixosModules.stylix
					./modules/systems/graphical.nix
					./modules/systems/win-nixvm/configuration.nix

					({ ... }: {		
                        home-manager = {
                            overwriteBackup = true;
                            backupFileExtension = "backup";
                            users.${username} = {
                                imports = [
                                    ./home.nix 
                                ];
						    };
                        };
					})
				];
			};
		};
	};
}
