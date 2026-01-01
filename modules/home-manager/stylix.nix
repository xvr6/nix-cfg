{ inputs, pkgs, ... }: {
     imports = [
	    inputs.stylix.homeModules.stylix
    ];
    stylix = {
        enable = true;
        polarity = "dark";
        targets.nixos-icons.enable = true;

        base16Scheme = "../../dotfiles/theme.yaml";
        #base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-dark.yaml";
    };   
}
