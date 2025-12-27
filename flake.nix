{
	description = "flakes :3";
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.11";
		
		# for mac
		darwin = {
			url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
			inputs = {
				nixpkgs.follows = "nixpkgs";
				# home-manager.follows = "home-manager";

			};
		};

		nixvim = {
			url = "github:nix-community/nixvim/nixos-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};	
		
		home-manager = {
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";	
		};

		# quickshell = {
		# 	url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
		# 	inputs.nixpkgs.follows = "nixpkgs";
		# };	

		zen-browser = {
			url = "github:0xc000022070/zen-browser-flake";
			inputs = {
				# IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
				# to have it up-to-date or simply don't specify the nixpkgs input
				nixpkgs.follows = "nixpkgs";
				home-manager.follows = "home-manager";

			};
		};

		self = {
			submodules = true;
		};	

	};

outputs = { self, darwin, nixpkgs, home-manager, ... } @inputs: 
	let
		system = "aarch64-darwin";
		username = "xvr6";
	in {

# nix-darwin
		darwinConfigurations = {
			nixbook = darwin.lib.darwinSystem {
				inherit system;
				# username = "prectriv";
				
				specialArgs = {inherit inputs system; };

				modules = [ 
					./modules/hone-manager/shells/zsh.nix
					./modules/systems/nix-darwin/configuration.nix
					
						# ({ config, ... }: {
						# 	home-manager.users.${username} = {
						# 		imports = [ ./home.nix ];
						# 	};
						# })
				];
			};
		};
		
		nixosConfigurations = {

# original UTM VM on my mac
			nixbook-pro = nixpkgs.lib.nixosSystem {
				system = "aarch64-linux";
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
					./modules/systems/graphical.nix
					./modules/systems/win-nixvm/configuration.nix
					({ config, ... }: {
						home-manager.users.${username} = {
							imports = [ ./home.nix ];
						};
					})
				];
			};
		};
	};
}
