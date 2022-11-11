vim.cmd [[
let g:coc_global_extensions = [
            \ 'coc-html',
            \ 'coc-css',
            \ 'coc-highlight',
            \ 'coc-eslint',
            \ 'coc-prettier',
            \ 'coc-pyright',
            \ 'coc-emmet',
            \ 'coc-pairs',
            \ 'coc-snippets',
            \ 'coc-java',
            \ 'coc-tsserver',
            \ 'coc-clangd',
            \ ]

if exists("&termguicolors") && exists("&winblend")
    syntax enable
    set termguicolors
    set winblend=10
    set wildoptions=pum
    set pumblend=10
    set background=dark
    colorscheme tokyonight-moon
endif

lua << EOF
-- You don't need to set any of these options.
-- IMPORTANT!: this is only a showcase of how you can set default options!
require("telescope").setup {
    extensions = {
        file_browser = {
            previewer=false,
            theme = "dropdown",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
                ["i"] = {
                    -- your custom insert mode mappings
                },
                ["n"] = {
                    -- your custom normal mode mappings
                },
            },
        },
    },
}
require("telescope").load_extension "file_browser"
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
        modified_icon = "[have not save]", -- change the default modified icon
        modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
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
        theme = 'tokyonight',
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
]]

