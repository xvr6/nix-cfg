{
	description = "NixOS";
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

		self = {
			submodules = true;
		};	

	};

outputs = { self, nixpkgs, home-manager, ... }@inputs: {
	let
		systemNixbookPro = "aarch64-linux";
		systemWinNixVM = "x86_64-linux";
		username = "xvr6";
	in {
		nixosConfigurations = {
			nixbook-pro = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs systemNixbookPro username; };
				system = systemNixbookPro;
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
			win-NixVM = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs systemWinNixVM username; };
				system = systemWinNixVM;
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
