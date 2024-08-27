# This overlay, when applied to nixpkgs, adds the final neovim derivation to nixpkgs.
{inputs}: final: prev:
with final.pkgs.lib; let
  pkgs = final;

  # Use this to create a plugin from a flake input
  mkNvimPlugin = src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

  # Make sure we use the pinned nixpkgs instance for wrapNeovimUnstable,
  # otherwise it could have an incompatible signature when applying this overlay.
  pkgs-wrapNeovim = inputs.nixpkgs.legacyPackages.${pkgs.system};

  # This is the helper function that builds the Neovim derivation.
  mkNeovim = pkgs.callPackage ./mkNeovim.nix { inherit pkgs-wrapNeovim; };

  # A plugin can either be a package or an attrset, such as
  # { plugin = <plugin>; # the package, e.g. pkgs.vimPlugins.nvim-cmp
  #   config = <config>; # String; a config that will be loaded with the plugin
  #   # Boolean; Whether to automatically load the plugin as a 'start' plugin,
  #   # or as an 'opt' plugin, that can be loaded with `:packadd!`
  #   optional = <true|false>; # Default: false
  #   ...
  # }
  all-plugins = with pkgs.vimPlugins; [
    # plugins from nixpkgs go in here.
    # https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=vimPlugins

    nvim-dap # https://github.com/mfussenegger/nvim-dap/
    nvim-treesitter.withAllGrammars
    luasnip # snippets | https://github.com/l3mon4d3/luasnip/
    # nvim-cmp (autocompletion) and extensions
    nvim-cmp # https://github.com/hrsh7th/nvim-cmp
    cmp_luasnip # snippets autocompletion extension for nvim-cmp | https://github.com/saadparwaiz1/cmp_luasnip/
    lspkind-nvim # vscode-like LSP pictograms | https://github.com/onsails/lspkind.nvim/
    cmp-nvim-lsp # LSP as completion source | https://github.com/hrsh7th/cmp-nvim-lsp/
    cmp-nvim-lsp-signature-help # https://github.com/hrsh7th/cmp-nvim-lsp-signature-help/
    cmp-buffer # current buffer as completion source | https://github.com/hrsh7th/cmp-buffer/
    cmp-path # file paths as completion source | https://github.com/hrsh7th/cmp-path/
    cmp-nvim-lua # neovim lua API as completion source | https://github.com/hrsh7th/cmp-nvim-lua/
    cmp-cmdline # cmp command line suggestions
    cmp-cmdline-history # cmp command line history suggestions
    # ^ nvim-cmp extensions

    # git integration plugins
    diffview-nvim # https://github.com/sindrets/diffview.nvim/
    neogit # https://github.com/TimUntersberger/neogit/
    gitsigns-nvim # https://github.com/lewis6991/gitsigns.nvim/
    vim-fugitive # https://github.com/tpope/vim-fugitive/
    # ^ git integration plugins

    # telescope and extensions
    telescope-nvim # https://github.com/nvim-telescope/telescope.nvim/
    telescope-fzy-native-nvim # https://github.com/nvim-telescope/telescope-fzy-native.nvim
    # telescope-smart-history-nvim # https://github.com/nvim-telescope/telescope-smart-history.nvim
    # ^ telescope and extensions

    # theme
    neovim-ayu # https://github.com/Shatur/neovim-ayu/
    # ^ theme

    # UI
    lualine-nvim # Status line | https://github.com/nvim-lualine/lualine.nvim/
    nvim-navic # Add LSP location to lualine | https://github.com/SmiteshP/nvim-navic
    statuscol-nvim # Status column | https://github.com/luukvbaal/statuscol.nvim/
    neo-tree-nvim # https://github.com/nvim-neo-tree/neo-tree.nvim
    neoscroll-nvim # https://github.com/karb94/neoscroll.nvim/
    nvim-treesitter-context # nvim-treesitter-context
    toggleterm-nvim # https://github.com/akinsho/toggleterm.nvim/
    undotree # https://github.com/mbbill/undotree/

    # HACK: pull which-key directly from github instead of using nixpkgs, since that version contains a bug 
    # once the neovim flake is pulled into a system. Can probably remove once nixos unstable channel updates 
    # the plugin.
    (mkNvimPlugin inputs.which-key-nvim "which-key-nvim")
    # which-key-nvim # https://github.com/folke/which-key.nvim
    # ^ UI
    
    # language support
    rustaceanvim # https://github.com/mrcjkb/rustaceanvim
    # ^ language support

    # Editor
    highlight-undo-nvim # https://github.com/tzachar/highlight-undo.nvim/
    leap-nvim # https://github.com/ggandor/leap.nvim/
    nvim-treesitter-textobjects # https://github.com/nvim-treesitter/nvim-treesitter-textobjects/
    nvim-ts-context-commentstring # https://github.com/joosepalviste/nvim-ts-context-commentstring/
    todo-comments-nvim # https://github.com/folke/todo-comments.nvim
    treesj # https://github.com/Wansmer/treesj/
    vim-unimpaired # predefined ] and [ navigation keymaps | https://github.com/tpope/vim-unimpaired/
    # ^ Editor

    # Useful utilities
    mini-nvim # https://github.com/echasnovski/mini.nvim?tab=readme-ov-file
    nvim-unception # Prevent nested neovim sessions | nvim-unception
    project-nvim # https://github.com/ahmedkhalf/project.nvim/
    # ^ Useful utilities

    # libraries that other plugins depend on
    sqlite-lua
    plenary-nvim
    nui-nvim # https://github.com/MunifTanjim/nui.nvim
    nvim-web-devicons
    vim-repeat
    # ^ libraries that other plugins depend on

    # bleeding-edge plugins from flake inputs
    # (mkNvimPlugin inputs.wf-nvim "wf.nvim") # (example) keymap hints | https://github.com/Cassin01/wf.nvim
    (mkNvimPlugin inputs.leap-spooky-nvim "leap-spooky-nvim") # https://github.com/ggandor/leap-spooky.nvim
    (mkNvimPlugin inputs.snipe-nvim "snipe-nvim") # https://github.com/leath-dub/snipe.nvim
    # ^ bleeding-edge plugins from flake inputs
  ];

  extraPackages = with pkgs; [
    # language servers, etc.
    # codelldb # Provided by rustaceanvim flake
    vscode-extensions.vadimcn.vscode-lldb.adapter
    gcc
    lua-language-server
    nil # nix LSP
  ];
in {
  # This is the neovim derivation
  # returned by the overlay
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  # This can be symlinked in the devShell's shellHook
  nvim-luarc-json = final.mk-luarc-json {
    plugins = all-plugins;
  };

  # You can add as many derivations as you like.
  # Use `ignoreConfigRegexes` to filter out config
  # files you would not like to include.
  #
  # For example:
  #
  # nvim-pkg-no-telescope = mkNeovim {
  #   plugins = [];
  #   ignoreConfigRegexes = [
  #     "^plugin/telescope.lua"
  #     "^ftplugin/.*.lua"
  #   ];
  #   inherit extraPackages;
  # };
}
