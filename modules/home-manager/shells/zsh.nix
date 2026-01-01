{ ... }: {
	programs.zsh = {
		enable = true;

		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		
		oh-my-zsh = {
			enable = true;
			plugins = [
				"git"
				"sudo"
				"vscode"
			];
		};

		shellAliases = {
#			drs = "sudo darwin-rebuild switch --flake ~/.dotfiles#nixbook";
			hai = "echo hai :3";
			nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles";
			nrt = "sudo nixos-rebuild test --flake ~/.dotfiles";
            ns_test = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
    
        };
	};

    programs.ghostty = {
		enable = true;
    
        settings = {
			font-size = 10;
		};

	};

	
	programs.oh-my-posh = {
		enable = true;
		enableZshIntegration = true;
		useTheme = "catppuccin_mocha";
	};

}
