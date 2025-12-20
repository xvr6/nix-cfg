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

	outputs = {nixpkgs, ...} @inputs: 
	let
		system = "aarch64-linux";
		username = "xvr6";
	in {
		nixosConfigurations = {
			nixbook-pro = nixpkgs.lib.nixosSystem {
				# pass args into modules
				specialArgs = {inherit inputs; inherit system; inherit username;};
				inherit system; #what does this do?

				modules = [
					./modules/systems/graphical.nix
					./modules/systems/nixbook-pro/configuration.nix
					{
						home-manager.users.${username} = {
							imports = [./home.nix];
						};
					}
				];
			};
		};
	};
}
