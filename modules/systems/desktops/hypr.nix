{ inputs, pkgs, username, ...}: {
	imports = [
		../common.nix
	];

    environment.systemPackages = with pkgs; [
        waybar
        
        #walpaper manager
        swww

        #app launcher
        rofi

        #screen brightness adjustment
        brightnessctl
       
        #notification daemon
        dunst
        libnotify
    ];
	
    services.displayManager.sddm.wayland.enable = true;
    
    services.displayManager.autoLogin = {
        enable = true;
        user = username;
    };
    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };
    
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

    
    environment.sessionVariables = {
        #Hint electron apps use wayland
        NIXOS_OZONE_WL = "1";
    };
}

