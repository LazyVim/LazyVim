---@diagnostic disable: duplicate-set-field

if lazyvim_docs then
  -- set to `false` to prevent "non-lsp snippets"" from appearing inside completion popups
  -- motivation: less clutter in completion windows and a more direct usage of snippits
  vim.g.lazyvim_mini_snippets_in_cmp = true

  -- NOTE: Blink has an open issue to address mini.snippets integration: #741
  -- For now, blink ignores vim.g.lazyvim_mini_snippets_in_cmp, operating as if it where false.

  -- NOTE: Please also read:
  -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-snippets.md#expand
  -- :h MiniSnippets-session
end

-- Blink: hardcoded to false, see #741:
local snippets_in_cmp = vim.g.lazyvim_mini_snippets_in_cmp == nil or vim.g.lazyvim_mini_snippets_in_cmp

--[[
Example override for your own config:
return {
  {
    "echasnovski/mini.snippets",
    opts = function(_, opts)
      -- By default, for opts.snippets, the extra for mini.snippets only adds gen_loader.from_lang()
      -- This provides a sensible quickstart, integrating with friendly-snippets
      -- and your own language-specific snippets
      --
      -- In order to change opts.snippets, replace the entire table inside your own opts

      local snippets, config_path = require("mini.snippets"), vim.fn.stdpath("config")

      opts.snippets = { -- override opts.snippets provided by extra...
        -- Load custom file with global snippets first (order matters)
        snippets.gen_loader.from_file(config_path .. "/snippets/global.json"),

        -- Load snippets based on current language by reading files from
        -- "snippets/" subdirectories from 'runtimepath' directories.
        snippets.gen_loader.from_lang(), -- this is the default in the extra...
      }
    end,
  },
}
--]]

-- Start with a default snippet_select that also works when the user disables a competion engine
local snippet_select = function(snippets, insert)
  MiniSnippets.default_select(snippets, insert)
end

local snippet_select_for_cmp = function(snippets, insert)
  local cmp = require("cmp")
  if cmp.visible() then
    cmp.close()
  end
  MiniSnippets.default_select(snippets, insert)
end

local snippet_select_for_blink = function(snippets, insert)
  -- Blink's cancel uses vim.schedule!
  require("blink.cmp").cancel()
  -- Schedule, otherwise blink's virtual text is not removed on vim.ui.select
  vim.schedule(function()
    MiniSnippets.default_select(snippets, insert)
  end)
end

local function expand(args)
  ---@diagnostic disable-next-line: undefined-global
  local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
  insert({ body = args.body }) -- insert at cursor
end

local function jump(direction)
  local is_active = MiniSnippets.session.get(false) ~= nil
  if is_active then
    MiniSnippets.session.jump(direction)
    return true
  end
end

return {
  -- disable builtin snippet support:
  { "garymjr/nvim-snippets", optional = true, enabled = false },
  -- disable luasnip:
  { "L3MON4D3/LuaSnip", optional = true, enabled = false },

  -- add mini.snippets
  desc = "mini.snippets(beta), a plugin to manage and expand snippets (alternative for luasnip)",
  {
    "echasnovski/mini.snippets",
    event = "InsertEnter", -- don't depend on other plugins to load...
    dependencies = "rafamadriz/friendly-snippets",
    opts = function()
      local snippets = require("mini.snippets")

      -- Load snippets based on current language by reading files from
      -- "snippets/" subdirectories from 'runtimepath' directories.
      local ret = { snippets = { snippets.gen_loader.from_lang() } }

      LazyVim.cmp.actions.snippet_stop = function() end -- by design, <esc> should not stop the session!
      if snippets_in_cmp then
        -- stylua: ignore
        LazyVim.cmp.actions.snippet_forward = function() return jump("next") end
      else
        LazyVim.cmp.actions.snippet_forward = nil
        -- stylua: ignore
        -- Close completion windows on snippet select to remove virtual text
        -- Needed for fzf-lua and telescope, but not for mini.pick...
        ret.expand = { select = function(...) snippet_select(...) end, }
      end
      return ret
    end,
  },

  -- nvim-cmp integration
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = snippets_in_cmp and { "abeldekat/cmp-mini-snippets" } or nil,
    opts = function(_, opts)
      snippet_select = snippet_select_for_cmp
      -- stylua: ignore
      -- Use mini.snippets to expand snippets from lsp:
      opts.snippet = { expand = function(args) expand(args) end }

      -- Show the snippets provided by mini.snippets in the completion popup:
      if snippets_in_cmp then
        table.insert(opts.sources, { name = "mini_snippets" })
      end
    end,
    -- stylua: ignore
    -- counterpart to <tab> defined in cmp.mappings
    keys = snippets_in_cmp and { { "<s-tab>", function() jump("prev") end, mode = "i" } } or nil,
  },

  -- blink.cmp integration
  {
    "saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      snippets_in_cmp = false
      snippet_select = snippet_select_for_blink

      -- Remove builtin snippets source
      opts.sources.default = vim.tbl_filter(function(source)
        return source ~= "snippets"
      end, opts.sources.default)

      -- Show the snippets provided by mini.snippets in the completion popup:
      if snippets_in_cmp then
        table.insert(opts.sources.default, "mini_snippets")
      end

      -- Note: blink defines the <s-tab> key...
      opts.snippets = {
        -- Use mini.snippets to expand snippets from lsp:
        expand = function(snippet)
          expand({ body = snippet })
        end,
        active = function()
          return MiniSnippets.session.get(false) ~= nil
        end,
        jump = function(direction)
          jump(direction < 0 and "prev" or "next")
        end,
      }
    end,
  },
}
