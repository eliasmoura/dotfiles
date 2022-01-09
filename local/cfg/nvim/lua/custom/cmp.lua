local ok1, luasnip = pcall(require, "luasnip")
local ok2, cmp = pcall(require, "cmp")

if not ok1 or not ok2 then
  return
end

function feedkey(key)
  vim.api.nvim_replace_termcodes(key, true, true, true)
end

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<c-i>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ["<c-n>"] = cmp.mapping(function()
      if cmp and cmp.visible() then
        cmp.select_next_item()
      elseif luasnip and luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        cmp.complete()
      end
    end, {
      "i",
      "s",
    }),
    ["<c-p>"] = cmp.mapping(function()
      if cmp and cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip and luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        cmp.complete()
      end
    end, {
      "i",
      "s",
    }),
  },
  sources = {
    { name = "nvim_lsp", priority = 10 },
    { name = "nvim_lua", priority = 6 },
    { name = "luasnip", priority = 3 },
    { name = "buffer", priority = 4 },
    { name = "path", priority = 2 },
    { name = "neorg" },
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})
