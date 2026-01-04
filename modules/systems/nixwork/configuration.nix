# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, pkgs, ... }: {

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

    #firmware update tool
    services.fwupd = {
        enable = true;
        extraRemotes = ["lvfs-testing"];
    };

    boot.kernelPackages = pkgs.linuxPackages_latest;
    
    #TODO: get screen brightness control working
    programs.light.enable = true;

    
    #Sound with Pipewire
    services.pipewire = {
        enable = true;
        alsa = {
            enable = true;
            support32Bit = true;
        };
        pulse.enable = true;
   };
    
    #Bluetooth
    hardware.bluetooth.settings = {
        General = {
            Experimental = true;
        }; 
    };
    
    networking.hostName = "nixwork"; # Define your hostname.
    system.stateVersion = "25.11"; # Did you read the comment?
}
