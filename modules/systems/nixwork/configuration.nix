# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, pkgs, ... }: {

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

    environment.systemPackages = with pkgs; [
       #screen brightness adjustment
       brightnessctl
    ];

    #firmware update tool
    services.fwupd = {
        enable = true;
        extraRemotes = ["lvfs-testing"];
    };

    boot.kernelPackages = pkgs.linuxPackages_latest;
    
    #Sound
    services.pulseaudio = {
        enable = false;
        extraConfig = "load-module module-combine-sink";
    };
    services.pipewire = {
        enable = true;
        alsa = {
            enable = true;
            support32Bit = true;
        };
        pulse.enable = true;
   };
    
    #Bluetooth
    hardware.bluetooth = {
        enable = true;
        settings = {
            General = {
                Experimental = true;
            };   
        };
    };
    services.blueman.enable = true;
    
    networking.hostName = "nixwork"; # Define your hostname.
    system.stateVersion = "25.11"; # Did you read the comment?
}
