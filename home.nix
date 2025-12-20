{ inputs, lib, pkgs, username, ...}: {
	imports = [
		./modules/config/h-m/shells/zsh.nix
		./modules/config/h-m/git.nix
	];

	
	home.username = username;
	home.homeDirectory = "/home/${username}";
	home.stateVersion = "25.11"; 
 

 	home.packages = with pkgs; [];
	#Allow home manager to self manage.
	programs.home-manager.enable = true;

	home.file = { #manually move config file from this flake to location expected by system
		".config/nixpkgs/config.nix".source = dotfiles/.config/nixpkgs/config.nix;
	};
			
	# home.packages = with pkgs; [
	# 	neovim
	# 	vscode-fhs
	# 	nodejs
	# 	gcc
	# 	nixpkgs-fmt
	# ];


}
