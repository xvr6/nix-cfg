{ inputs, lib, pkgs, username, ...}: {
	imports = [
		./modules/home-manager/nixvim.nix
		./modules/home-manager/shells/zsh.nix
		./modules/home-manager/git.nix
	    ./modules/home-manager/display/quickshell.nix
        # TODO: ./modules/config/h-m/browsers/zen.nix
	];
	
	home.username = username;
	home.homeDirectory = "/home/${username}";
	home.stateVersion = "25.11";
 

 	home.packages = with pkgs; [];
	
	#Allow home manager to self manage.
	programs.home-manager.enable = true;
    programs.dconf.enable = true;

    programs.illogical-impulse = {
        dotfiles = {
        };
    };
    
	home.file = { #manually move config file from this flake to location expected by system
		".config/nixpkgs/config.nix".source = dotfiles/.config/nixpkgs/config.nix;
        ".config/ghostty/theme/tokyo-night-default.nix".source = dotfiles/.config/ghostty/theme/tokyo-night-default.nix;
    };
			
	# home.packages = with pkgs; [
	# 	neovim
	# 	vscode-fhs
	# 	nodejs
	# 	gcc
	# 	nixpkgs-fmt
	# ];


}
