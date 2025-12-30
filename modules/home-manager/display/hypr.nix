{ pkgs, ... }: {
   
#   xdg.portal.enable = true;
#   xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    home.packages = with pkgs; [
        waybar 
        hyprpaper #wallpaper manager
        kitty #default for hyprland

        dunst #notification manager
            libnotify #dependancy for abovei
        
        rofi # app launcher
    ];
    
    wayland.windowManager.hyprland = {
        enable = true;

        settings = {
           monitor = "DP-1, 1980x1080@60, 0x0, 1";

            "$mod" = "SUPER";
            bind = [
                "$mod, O, exec, ghostty"
            ]
            ++ (
                builtins.concatLists (builtins.genList (i: 
                    let ws = i + 1;
                    in [
                        "$mod, code:1${toString i}, workspace, ${toString ws}"
                        "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                    ]
                ) 9)
            );
        };
    };




}
