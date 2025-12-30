# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, username, ... }: {
	nix.settings = {
		experimental-features = ["nix-command" "flakes"];
	};   
  # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;


	#Enable networking
	networking.networkmanager.enable = true;
    networking.hostName = "win-NixVM"; # Define your hostname.
    
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
            openssh.authorizedKeys.keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHJuKddbB35VXhD45nRSu6mkGkeZOqup8Cnmfg2dykGP xvr6.dev"
            ];
        };
    };

	# for both graphical and common
    environment.systemPackages = with pkgs; [
        vim
		wget
        nix-search-tv
        fzf
        foot
        kitty
        waybar
        hyprpaper
    ];

    
	programs.firefox.enable = true;
  
    system.stateVersion = "25.11";
}
