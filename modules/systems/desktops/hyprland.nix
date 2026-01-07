{ inputs, lib, pkgs, username, ... }: {
	imports = [
		../common.nix
        ./hypr-components/waybar-min.nix
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
            inherit (lib) getExe;
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

                        env = [
                            "XDG_CURRENT_DESKTOP,Hyprland"
                            "XDG_SESSION_DESKTOP,Hyprland"
                            "NIXOS_OZONE_WL,1"
                            "ELECTRON_OZONE_PLATFORM_HINT,wayland"
                            "OZONE_PLATFORM,wayland"
                        ];
                        
                        # Launch Script
                        exec-once = [
                            "waybar"
                        ];
                       
                        input = {
                            numlock_by_default = true;
                            follow_mouse = 1;

                            touchpad.natural_scroll = false;
                            sensitivity = 0; # [-1.0, 1.0]; 0 means no modification.
                            force_no_accel = false;
                        };

                        general = {
                            gaps_in = 4;
                            gaps_out = 9;
                            border_size = 2;
                            resize_on_border = true;
                        #   "col.active_border" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
                        #   "col.inactive_border" = "rgba(b4befecc) rgba(6c7068cc) 45deg";
                        };

                        misc = {
                            mouse_move_focuses_monitor = true;
                            disable_hyprland_logo = true;
                            vfr = true;
                            vrr = 2; #variable refresh rate; 0 = off, 1 = on, 2 = fullscreen only, 3 = fullscreen games/media)
                        };

                        decoration = {
                            shadow.enabled = true;
                            rounding = 10;
                            dim_special = 0.3;
                            blur = {
                                enabled = true;
                                special = true;
                                size = 6;
                                passes = 2;
                                new_optimizations = true;
                                ignore_opacity = true;
                                xray = false;
                            };
                        };
                        ecosystem = {
                            no_update_news = true;
                            no_donation_nag = true;
                        };
                        layerrule = [
                            "blur, rofi"
                        ];     
                        animations = {
                            enabled = true;
                            bezier = [
                                "linear,        0, 0, 1, 1"
                                "md3_standard,  0.2, 0, 0, 1"
                                "md3_decel, 	0.05, 0.7, 0.1, 1"
                                "md3_accel,	    0.3, 0, 0.8, 0.15"
                                "overshoot,	    0.05, 0.9, 0.1, 0.1"
                                "crazyshot,	    0.1, 1.5, 0.76, 0.92"
                                "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
                                "fluent_decel,  0.1, 1, 0, 1"
                                "easeInOutCirc, 0.08, 0, 0.15,1"
                                "easeOutCirc,   0, 0.55, 0.45, 1"
                                "easeOutExpo,   0.16, 1, 0.3, 1"
                            ];
                            animation = [
                                "windows, 1, 3, md3_decel, popin 60%"
                                "border, 1, 10, default"
                                "fade, 1, 2.5, md3_decel"
                                "workspaces, 1, 3.5, easeOutExpo, slide"
                                "specialWorkspace, 1, 3, md3_decel, slidevert"
                            ];
                        };


                        windowrule = [
                            # FLOAT FLOAT for active/inactive
                            "opacity 0.80 0.70,class:^(Ghostty|zsh|~|ghostty)$"
                        ];

                        gesture = [
                            "3, horizontal, workspace"
                        ];  
                        binde = [
                            #functional keybinds
                            ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
                            ",XF86MonBrightnessUp, exec, brightnessctl set +5%"
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
