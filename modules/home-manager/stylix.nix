{ pkgs, ... }: {
    stylix = {
        enable = true;
        polarity = "dark";
        targets.nixos-icons.enable = true;


        base16Scheme = import ./shells/theme/tokyo-night-dark{};














        };


        
}
