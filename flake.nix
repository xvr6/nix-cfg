{
	description = "flakes :3";
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.11";
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

		# for mac
		nix-darwin = {
			url = "github:nix-darwin/nix-darwin/master";
			inputs = {
				nixpkgs.follows = "nixpkgs";
			};
		};

		self = {
			submodules = true;
		};	

	};

outputs = { self, nix-darwin, nixpkgs, home-manager, ... } @inputs: 
	let
		system = "";
		username = "xvr6";
	in {

# nix-darwin
		darwinConfigurations."nixbook" = nix-darwin.lib.darwinSystem {
			username = "prectriv";
			system = "aarch64-darwin";
			specialArgs = {inherit inputs system username; };

			modules = [ 
				./modules/systems/graphical.nix
				./modules/systems/nix-darwin/configuration.nix
				
					({ config, ... }: {
						home-manager.users.${username} = {
							imports = [ ./home.nix ];
						};
					})
			];
		};

		nixosConfigurations = {
# original UTM VM on my mac
			nixbook-pro = nixpkgs.lib.nixosSystem {
				username = "xvr6";
				system = "aarch64-linux";
				specialArgs = { inherit inputs system username; };
				modules = [
					./modules/systems/graphical.nix
					./modules/systems/nixbook-pro/configuration.nix
					# ./modules/systems/win-nixvm/configuration.nix
					({ config, ... }: {
						home-manager.users.${username} = {
							imports = [ ./home.nix ];
						};
					})
				];
			};

# Windows Hyper-V VM
			win-NixVM = nixpkgs.lib.nixosSystem {
				username = "xvr6";
				system = "x86_64-linux";
				specialArgs = { inherit inputs system username; };
				modules = [
					./modules/systems/common.nix
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
