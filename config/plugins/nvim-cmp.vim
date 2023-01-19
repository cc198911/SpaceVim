lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    mapping = {
      ["<A-k>"] = cmp.mapping.select_prev_item(),
      ["<A-j>"] = cmp.mapping.select_next_item(),
      ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<A-,>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    snippet = {
    expand = function(args)
      --require("luasnip").lsp_expand(args.body)
      vim.fn["UltiSnips#Anon"](args.body)
    end
  },
    formatting = {
      format = require("lspkind").cmp_format({
      with_text = true,
      menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "",
          ultisnips = "[UltiSnips]",
          nvim_lua = "[Lua]",
          cmp_tabnine = "[TabNine]",
          look = "[Look]",
          path = "[Path]",
          spell = "[Spell]",
          calc = "[Calc]",
          emoji = "[Emoji]"
        }),
      before = function (entry, vim_item)
        -- Source 显示提示来源
        vim_item.menu = "["..string.upper(entry.source.name).."]"
        return vim_item
      end
      }),
    },
    sources = cmp.config.sources({
      { name = 'path' },
    },
    {
     { name = 'ultisnips' },
      --{name = "luasnip"},
    }, 
    {
      { name = 'buffer' },
    }, {
      { name = 'nvim_lsp' },
    },{
      { name = 'vsnip' },
    }
    )
  })
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- The following example advertise capabilities to `clangd`.
require'lspconfig'.clangd.setup {
  capabilities = capabilities,
}

require'lspconfig'.sumneko_lua.setup ({
  capabilities = capabilities,
  --settings = opts.settings,
})


EOF
