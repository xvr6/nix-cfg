{ ... }: {
	programs.zsh = {
		enable = true;

		shellAliases = {
			vi = "nvim";
			hai = "echo hai :3";
			nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles#nixbook-pro";
			nrt = "sudo nixos-rebuild test --flake ~/.dotfiles#nixbook-pro";
		};
	};
}
