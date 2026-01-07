{ inputs, pkgs, username, ... }: {
imports = [
    ./modules/home-manager/stylix.nix
	./modules/home-manager/nixvim.nix
	./modules/home-manager/shells/zsh.nix
	./modules/home-manager/git.nix 
    ./modules/home-manager/browsers/zen.nix
];

	home.username = username;
	home.homeDirectory = "/home/${username}";
	home.stateVersion = "25.11";

    home.packages = with pkgs; [  
        (pkgs.writeShellScriptBin "ns" (builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh"))
    ];

    # Manually move config file from this flake to location expected by system
	home.file = { 	
        ".config/nixpkgs/config.nix".source = dotfiles/.config/nixpkgs/config.nix;
#       ".config/hypr/hyprland.conf".source = dotfiles/.config/hypr/hyprland.conf;
#       ".config/hypr/start.sh".source = dotfiles/.config/hypr/start.sh;
    };					     	 
	# Home manager to self manage.
	programs.home-manager = {
        enable = true;
    };


}
