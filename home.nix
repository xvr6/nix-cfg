{ pkgs, username, ... }: {
	imports = [
        #./modules/home-manager/stylix.nix
		./modules/home-manager/nixvim.nix
		./modules/home-manager/shells/zsh.nix
		./modules/home-manager/git.nix
	    ./modules/home-manager/display/ii.nix
        # TODO: ./modules/home-manager/browsers/zen.nix
	];
	
	home.username = username;
	home.homeDirectory = "/home/${username}";
	home.stateVersion = "25.11";
 					     	 
	# Allow home manager to self manage.
	programs.home-manager.enable = true;

 	home.packages = with pkgs; [  
    ];

    # Manually move config file from this flake to location expected by system
	home.file = { 	
        ".config/nixpkgs/config.nix".source = dotfiles/.config/nixpkgs/config.nix;
       # ".config/ghostty/theme/tokyo-night-default.nix".source = dotfiles/.config/ghostty/theme/tokyo-night-default.nix;
    };
}
