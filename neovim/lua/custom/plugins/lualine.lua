return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'DaikyXendo/nvim-material-icon',
    'greed-d/lualine-so-fancy.nvim',
  },

  event = 'VeryLazy',
  config = function()
    -- Eviline config for lualine
    -- Author: shadmansaleh
    -- Credit: glepnir
    local lualine = require 'lualine'

-- Color table for highlights
-- stylua: ignore
    local colors = {
      bg       = '#1a1b2A',
      fg       = '#bbc2cf',
      yellow   = '#ECBE7B',
      cyan     = '#008080',
      darkblue = '#081633',
      green    = '#98be65',
      orange   = '#FF8800',
      violet   = '#a9a1e1',
      magenta  = '#c678dd',
      blue     = '#82AAFF',
      red      = '#ec5f67',
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand '%:t') ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand '%:p:h'
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Config
    local config = {
      options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        theme = {
          -- We are going to use lualine_c an lualine_x as left and
          -- right section. Both are highlighted by c theme .  So we
          -- are just setting default looks o statusline
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- These will be filled later
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },

      extensions = {
        'oil',
        'neo-tree',
        'lazy',
        'overseer',
        'mason',
        'man',
        -- require('custom.plugins.snacks.lualine').lualine_custom,
        'trouble',
        {
          sections = {
            lualine_a = {
              function()
                return ' Lazygit'
              end,
            },
            lualine_b = { 'branch' },
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
          },
          filetypes = { 'lazygit' },
        },
        require 'custom.plugins.snacks.lualine',
      },
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x at right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left {
      function()
        return '▊'
      end,
      color = { fg = colors.blue }, -- Sets highlighting of component
      padding = { left = 0, right = 1 }, -- We don't need space before this
    }

    ins_left {
      -- mode component
      function()
        return '󱓻'
      end,
      color = function()
        -- auto change color according to neovims mode
        local mode_color = {
          n = colors.red,
          i = colors.green,
          v = colors.blue,
          [''] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [''] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ['r?'] = colors.cyan,
          ['!'] = colors.red,
          t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { right = 1 },
    }

    -- ins_left {
    --   -- filesize component
    --   'filesize',
    --   cond = conditions.buffer_not_empty,
    -- }

    ins_left {
      'filename',
      cond = conditions.buffer_not_empty,
      color = { fg = colors.magenta, gui = 'bold' },
    }

    ins_left {
      'branch',
      icon = '',
      color = { fg = colors.violet, gui = 'bold' },
    }

    ins_left {
      'diff',
      -- Is it me or the symbol for modified us really weird
      symbols = { added = ' ', modified = ' ', removed = ' ' },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
      },
      cond = conditions.hide_in_width,
    }

    -- Insert mid section. You can make any number of sections in neovim :)
    -- for lualine it's any number greater then 2
    ins_left {
      function()
        return '%='
      end,
    }

    ins_left {
      -- Lsp server name .
      function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = ' LSP:',
      color = { fg = '#ffffff', gui = 'bold' },
    }
    ins_right {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      symbols = { error = '󰅙 ', warn = ' ', info = ' ', hint = '󰌵 ' },
      diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
        color_hint = { fg = colors.blue },
      },
    }
    ins_right { 'fancy_macro' }
    ins_right { 'fancy_location' }

    ins_right {
      'fancy_cwd',
      color = { fg = colors.magenta, gui = 'bold' },
    }

    -- Add components to right sections
    -- ins_right {
    --   'o:encoding', -- option component same as &encoding in viml
    --   fmt = string.upper, -- I'm not sure why it's upper case either ;)
    --   cond = conditions.hide_in_width,
    --   color = { fg = colors.green, gui = 'bold' },
    -- }

    -- ins_right {
    --   'fileformat',
    --   fmt = string.upper,
    --   icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
    --   color = { fg = colors.green, gui = 'bold' },
    -- }

    ins_right {
      function()
        return '▊'
      end,
      color = { fg = colors.blue },
      padding = { left = 1 },
    }

    -- Now don't forget to initialize lualine
    lualine.setup(config)
  end,
}
-- return {
--   'nvim-lualine/lualine.nvim',
--
--   dependencies = {
--     'DaikyXendo/nvim-material-icon',
--     'greed-d/lualine-so-fancy.nvim',
--   },
--   event = 'VeryLazy',
--   enabled = true,
--   init = function()
--     vim.g.lualine_laststatus = vim.o.laststatus
--     if vim.fn.argc(-1) > 0 then
--       -- set an empty statusline till lualine loads
--       vim.o.statusline = ' '
--     else
--       -- hide the statusline on the starter page
--       vim.o.laststatus = 0
--     end
--   end,
--   -- config = function()
--   --   require("custom.plugins.configs.lualine")
--   -- end
--   opts = {
--     options = {
--       theme = 'tokyonight',
--       component_separators = { right = '', left = '' },
--       section_separators = { right = '', left = '' },
--       globalstatus = true,
--       refresh = {
--         statusline = 100,
--       },
--     },
--     sections = {
--       lualine_a = {
--         { 'fancy_mode', separator = { left = '', right = '' }, right_padding = 2 },
--       },
--       lualine_b = {
--         function()
--           local icon = '󰈚'
--           local path = vim.api.nvim_buf_get_name(stbufnr())
--           local name = (path == '' and 'Empty') or path:match '([^/\\]+)[/\\]*$'
--
--           if name ~= 'Empty' then
--             local devicons_present, devicons = pcall(require, 'nvim-web-devicons')
--
--             if devicons_present then
--               local ft_icon = devicons.get_icon(name)
--               icon = (ft_icon ~= nil and ft_icon) or icon
--             end
--           end
--
--           return { icon, name }
--         end,
--       },
--       lualine_c = {
--         { 'fancy_branch', icon = '' },
--         {
--           'fancy_diff',
--           symbols = {
--             added = ' ',
--             modified = ' ',
--             removed = ' ',
--           }, -- Changes the symbols used by the diff.
--           colored = true,
--         },
--         { 'fancy_searchcount' },
--       },
--       lualine_x = {
--         { 'fancy_macro', fg = '#474853', bg = '#ee6d85', separator = { left = '', right = '' } },
--
--         {
--           'fancy_location',
--           separator = { left = '' },
--         },
--         {
--           'fancy_diagnostics',
--           -- diagnostics_color = {
--           --   error = { fg = '#ee6d85' },
--           -- },
--           symbols = { error = ' ', warn = ' ', info = '󰋼 ', hint = '󰛩 ' },
--         },
--       },
--       lualine_y = {
--         { 'fancy_lsp_servers', separator = { left = '' } },
--
--         -- separator = { left = ''}
--       },
--       lualine_z = {
--         { 'fancy_cwd', fg = '', bg = '#474853', separator = { left = '', right = '' } },
--
--         -- function()
--         --   local cwd = vim.fn.getcwd()
--         --   return '󰉖 ' .. (cwd:match '([^/\\]+)[/\\]*$' or cwd)
--         -- end,
--       },
--     },
--     extensions = {
--       'oil',
--       'neo-tree',
--       'lazy',
--       'overseer',
--       'mason',
--       'man',
--       -- require('custom.plugins.snacks.lualine').lualine_custom,
--       'trouble',
--       {
--         sections = {
--           lualine_a = {
--             function()
--               return ' Lazygit'
--             end,
--           },
--           lualine_b = { 'branch' },
--           lualine_c = {},
--           lualine_x = {},
--           lualine_y = {},
--           lualine_z = {},
--         },
--         filetypes = { 'lazygit' },
--       },
--       require 'custom.plugins.snacks.lualine',
--     },
--   },
-- }
