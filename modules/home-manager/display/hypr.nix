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
        package = null;
        portalPackage = null;
    };




}
