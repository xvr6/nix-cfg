{ ... }: {
	programs.zsh = {
		enable = true;

		shellAliases = {
			vi = "nvim";
			hai = "echo hai :3";
			nrs = "nixos-rebuild switch --flake ~/.dotfiles#nixbook-pro";
			nrt = "nixos-rebuild test --flake ~/.dotfiles#nixbook-pro";
		};
	};
}
