{ ... }: {
  #Install neovim and dependencies
  home.packages = with pkgs; [ #dependencies

  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
}