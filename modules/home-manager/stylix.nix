{ inputs, pkgs, ... }: {
     imports = [
	    inputs.stylix.homeModules.stylix
    ];
    stylix = {
        enable = true;
        polarity = "dark";
        targets.nixos-icons.enable = true;

        base16Scheme = import ./themes/tokyo-night-dark.nix{};

    };   
}
