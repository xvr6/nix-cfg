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
			theme = "robbyrussell";
		};

		shellAliases = {
			vi = "nvim";
			hai = "echo hai :3";
			nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles#nixbook-pro";
			nrt = "sudo nixos-rebuild test --flake ~/.dotfiles#nixbook-pro";
		};
	};
}
