{
	description = "flakes :3";
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.11";
#    nixpkgsUnstable.url = "nixpkgs/nixos-unstable";
		# for mac
		darwin = {
			url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
			inputs = {
				nixpkgs.follows = "nixpkgs";
				# home-manager.follows = "home-manager";

			};
		};
        

        stylix = {
            url = "github:nix-community/stylix/release-25.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
		
        nixvim = {
			url = "github:nix-community/nixvim/nixos-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};	
		
		home-manager = {
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		quickshell = {
			url = "github:quickshell-mirror/quickshell";
			inputs.nixpkgs.follows = "nixpkgs";
		};	


        illogical-flake = {
            url = "github:soymou/illogical-flake";
            inputs.nixpkgs.follows = "nixpkgs";
           # inputs.home-manager.follows = "home-manager";
            inputs.quickshell.follows = "quickshell";
        };

		zen-browser = {
			url = "github:0xc000022070/zen-browser-flake";
			inputs = {
				# IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
				# to have it up-to-date or simply don't specify the nixpkgs input
				nixpkgs.follows = "nixpkgs";
				home-manager.follows = "home-manager";

			};
		};

        #NOTE: wtf do this actually do?
		self = {
			submodules = true;
		};	

	};

outputs = { self, nixpkgs, illogical-flake, stylix, ... } @inputs: 
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
				modules = [        
                    stylix.nixosModules.stylix
					./modules/systems/graphical.nix
					./modules/systems/win-nixvm/configuration.nix

					({ config, nixpkgs, ... }: {		
                        home-manager = {
                            backupFileExtension = "backup";
                            users.${username} = {
                                imports = [
                                    illogical-flake.homeManagerModules.default{
                                        programs.illogical-impulse.enable = true;
                                    }                                
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
