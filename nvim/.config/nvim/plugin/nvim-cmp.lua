local lspkind = require 'lspkind'
local cmp = require 'cmp'

local press = function(key)
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), "n", true)
end

cmp.setup {
  -- Always preselect first option
  preselect = cmp.PreselectMode.None,
  completion = {
    completeopt = "menu,menuone,noinsert",
  },

  mapping = {
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.confirm({
          select = true,
        }) --, vim.lsp.buf.signature_help)
      elseif vim.fn.complete_info()["selected"] == -1 and vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
        press("<C-R>=UltiSnips#ExpandSnippet()<CR>")
      elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
        press("<ESC>:call UltiSnips#JumpForwards()<CR>")
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
        press("<ESC>:call UltiSnips#JumpBackwards()<CR>")
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'ultisnips' },
    { name = 'cmp_git' },
    { name = 'path' },
    {
      name = 'buffer',
      get_bufnrs = function()
        return vim.api.nvim_list_bufs()
      end
    },
  },
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        ultisnips = "[UltiSnips]",
        buffer = "[Buffer]",
        path = "[Path]",
        gh_issues = "[Issues]",
      },
    }
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
}

-- cmp.setup.cmdline('/', {
--   sources = {
--     { name = 'buffer' }
--   }
-- })

-- -- Use cmdline & path source for ':'.
-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })
