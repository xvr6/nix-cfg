# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, ... }: {

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series 
    ];

    #bios tool
    services.fwupd.enable = true;

    networking.hostName = "nixwork"; # Define your hostname.
  system.stateVersion = "25.11"; # Did you read the comment?
}
