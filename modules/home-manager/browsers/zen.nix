{ inputs, ...}: {
  #https://github.com/0xc000022070/zen-browser-flake?tab=readme-ov-file#policies
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser.enable = true;
}
