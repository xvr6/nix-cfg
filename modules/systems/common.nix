# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, inputs, username, ... }: {
	imports = [
  		inputs.home-manager.nixosModules.home-manager
  	];

	nix.settings = {
		experimental-features = ["nix-command" "flakes"];
	};   

	nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

	#Allow unfree (non-faos)
	nixpkgs.config = {
		allowUnFree = true;
	};

	#Enable networking
	networking.networkmanager.enable = true;

	#Time Zone
	time.timeZone = "America/New_York";

	# Select internationalization properties.
	i18n.defaultLocale = "en_US.UTF-8";

	# Enable the OpenSSH Daemon
	services.openssh.enable = true;

	# Select shell
	environment.shells = [pkgs.zsh];
	programs.zsh.enable = true;

	#define user account(s)
	users = {
	defaultUserShell = pkgs.zsh;
		users.${username} = {
			isNormalUser = true;
			description = username;
			extraGroups = ["wheel" "podman"];
		};
	};

	#default apps needed for now:
	environment.systemPackages = with pkgs; [
		neovim
		wget
		vscode-fhs
	];
	programs.firefox.enable = true;


	home-manager.users.${username}.nixpkgs.config = {allowUnfree = true; };
	home-manager.useUserPackages = true;

	#passing arguments to home.nix :D
	home-manager.extraSpecialArgs = {
		inherit inputs; 
		inherit username;
	};
}