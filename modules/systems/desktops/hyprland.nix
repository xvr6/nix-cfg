{ inputs, lib, pkgs, username, ...}: {
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
	
    services.displayManager = {
        sddm.wayland.enable = true;
        autoLogin = {
            enable = true;
            user = username;
        };
    };   

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };
    
    
    environment.sessionVariables = {
        #Hint electron apps use wayland
        NIXOS_OZONE_WL = "1";
    };

    home-manager.sharedModules = 
        let
            inherit (lib) getExe getExe';
        in [
            ({ ... }: {
                home.packages = with pkgs; [
                    #bar
                    waybar

                    #walpaper manager
                    swww

                    #screen brightness control
                    brightnessctl
                    
                    networkmanagerapplet
                ];

                xdg.portal = { 
                    enable = true;
                    extraPortals = [
                        pkgs.xdg-desktop-portal-gtk
                    ];
                    
                    config.hyprland = {
                        default = [
                            "hyprland"
                            "gtk"
                        ];
                    };
                };
    
                #Walpaper manager
                services.swww.enable = true;

                wayland.windowManager.hyprland = {
                    enable = true;
                    systemd = {
                        enable = true;
                        variables = ["--all"];
                    };
                    
                    #Hyprland Settings
                    settings = {
                        #variables
                        "$mainMod" = "SUPER";
                        "$term" = "${getExe pkgs.ghostty}";
                        "$editor" = "vi";
                        "$browser" = "firefox";

                        env = [];
                        
                        binde = [
                            #functional keybinds
                            ",XF86MonBrightnessDown, exec, brightnessctl set 2%-"
                            ",XF86MonBrightnessUp, exec, brightnessctl set +2%"
                        ];

                        #keybinds
                        bind = [
                            #Apps and Programs
                            "$mainMod, Return, exec, $term"
                            "$mainMod, T, exec, $term"
                            "$mainMod, B, exec, $browser"
                        ];

                    };
                };
            })
        ];
}
