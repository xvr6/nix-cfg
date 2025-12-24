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
			drs = "sudo darwin-rebuild switch --flake ~/.dotfiles#nixbook";
			hai = "echo hai :3";
			nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles";
			nrt = "sudo nixos-rebuild test --flake ~/.dotfiles";
		};
	};
 	programs.ghostty = {
		enable = true;
		themes = {
			tokyo-night-default = {
  	      	background = "#1a1b26";
        	foreground = "#c0caf5";
	        selection-background = "#283457";
        	selection-foreground = "#c0caf5";
       		cursor-color = "#c0caf5";
        	cursor-text = "#1a1b26";
        	palette = [
	            "0=#15161e"
        	    "1=#f7768e"
       		    "2=#9ece6a"
                    "3=#e0af68"
 	            "4=#7aa2f7"
        	    "5=#bb9af7"
        	    "6=#7dcfff"
       	            "7=#a9b1d6"
                    "8=#414868"
	            "9=#f7768e"
	            "10=#9ece6a"
	            "11=#e0af68"
	            "12=#7aa2f7"
	            "13=#bb9af7"
	            "14=#7dcfff"
	            "15=#c0caf5"
	        ];
			};
		};


		settings = {
			theme = "tokyo-night-default";
			font-size = 10;
		};

	};

	
	programs.oh-my-posh = {
		enable = true;
		enableZshIntegration = true;
		useTheme = "catppuccin_mocha";
	};

}
