set number
set autochdir
set undofile
set ruler
set cursorline
syntax on
filetype plugin indent on
set bs=2
set smartindent
set wildmenu
set relativenumber
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set encoding=UTF-8
set mouse=a
set title
set ignorecase
set nobackup
set nowb
set noswapfile
set splitbelow
set splitright
set laststatus=2
set background=dark

""ctags
command! MakeTags !ctags -R .

call plug#begin()
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
Plug 'ervandew/supertab' 
Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-lua/plenary.nvim' 
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' } 
Plug 'nvim-lualine/lualine.nvim' 
Plug 'kyazdani42/nvim-web-devicons' 
Plug 'kdheepak/tabline.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" LSP Support
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'

"  Snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'VonHeikemen/lsp-zero.nvim'
Plug 'tjdevries/colorbuddy.nvim'
Plug 'svrana/neosolarized.nvim'

" coc-markdown-preview-enhanced
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'rderik/vim-markdown-toc', { 'branch': 'add-anchors-to-headings/drc2r' }

Plug 'windwp/nvim-autopairs'
call plug#end()

nnoremap <C-s> :w<Enter>
nnoremap <C-a> ggVG
vnoremap <C-c> :'<.'>%y+<Enter>
nnoremap <C-q> :bdelete!<Enter>
nnoremap <C-w> :q!<Enter>
nnoremap <C-z> :u<Enter>
nnoremap <C-d> :%d<Enter>
nnoremap <C-n> :Telescope file_browser<Enter>
nnoremap <C-t> :ToggleTerm direction=float<Enter>
nnoremap <TAB> :bnext<Enter>
nnoremap <C-f> :%s//g<Left><Left>
nnoremap <C-y> :noh<Enter>
nnoremap <silent> vim :e $MYVIMRC<TAB><cr>
nnoremap <silent> ;; :Telescope oldfiles<cr>


" Find files using Telescope command-line sugar.
nnoremap <silent>;f <cmd>Telescope find_files<cr>
nnoremap <silent>;g <cmd>Telescope live_grep<cr>
nnoremap <silent>;h <cmd>Telescope help_tags<cr>
nnoremap <silent>sf <cmd>Telescope file_browser<cr>


" let g:coc_global_extensions = [
"             \ 'coc-markdown-preview-enhanced',
"             \ 'coc-webview',
"             \ ]

if exists("&termguicolors") && exists("&winblend")
    syntax enable
    set termguicolors
    set winblend=10
    set wildoptions=pum
    set pumblend=20
    " let g:solarized_termtrans=1
    set background=dark
    " colorscheme solarized8
endif

lua << EOF

local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        -- your custom insert mode mappings
        ["i"] = {
          ["<C-w>"] = function() vim.cmd('normal vbd') end,
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd('startinsert')
          end
        },
      },
    },
  },
}

telescope.load_extension("file_browser")
EOF

lua << EOF
require'tabline'.setup {
    enable = true,
    options = {
        section_separators = {'', ''},
        component_separators = {'', ''},
        max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
        show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
        show_devicons = true, -- this shows devicons in buffer section
        show_bufnr = false, -- this appends [bufnr] to buffer section,
        show_filename_only = true, -- shows base filename only instead of relative path in filename
        modified_icon = "[*]", -- change the default modified icon
        modified_italic = true, -- set to true by default; this determines whether the filename turns italic if modified
        show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
    }
    }
requires = { { 'hoob3rt/lualine.nvim', opt=true }, {'kyazdani42/nvim-web-devicons', opt = true} }
EOF

lua<<EOF
require("toggleterm").setup{
}
EOF

lua<<EOF
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'solarized_dark',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
        },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff',},
        lualine_c = { {
            'filename',
        } },
        lualine_x = {
            { 'diagnostics', sources = { "nvim_diagnostic" }, symbols = { error = ' ', warn = ' ', info = ' ',
            hint = ' ' } },
            'encoding',
            'filetype',
            'fileformat',
        },
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}

EOF

lua << EOF
require 'Comment'.setup{}
EOF

lua << EOF
require 'colorizer'.setup{
      '*'; -- Highlight all files, but customize some others.
}
EOF

lua<<EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust", "cpp", "html", "css", "python" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

lua <<EOF
local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.setup()

lsp.set_preferences({
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = true,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = true,
  call_servers = 'local',
  sign_icons = {
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = ''
  }
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})

EOF

lua << EOF
  require('neosolarized').setup({
    comment_italics = true,
    background_set = false,
  })
EOF

let g:vmt_insert_anchors = 1
let g:vmt_auto_update_on_save = 1

lua << EOF
require("nvim-autopairs").setup {}
EOF
