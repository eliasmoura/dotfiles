local ok, lualine = pcall(require, "lualine")
if not ok then
  return
end
lualine.setup({
  options = {
    icons_enabled = true,
    theme = "tokyonight",
    component_separators = { "", "" },
    section_separators = { "", "" },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { "filename" },
    lualine_x = {
      {
        function()
          s = require("lsp-status").status()
          -- vim.notify(string.match(s, [[]]) .. "sa")
          -- lualine.custom_tokyonight.normal.c.bg = "#112233"
          if
            not s
            or string.match(s, [[]]) ~= nil
            or string.match(s, [[Setting up workspace]]) ~= nil
          then
            return ""
          end
          return s
        end,
      },
      {
        function()
          local s = require("dap.progress").status()
          if s ~= "" then
            -- vim.custom.dap.dapui_toggle()
            vim.custom.dap.set_cmaps()
            return "DEBUG: " .. s
          else
            vim.custom.dap.set_dmaps()
            return ""
          end
        end,
        color = "ErrorMsg",
      },
      {
        function()
          local tsl = require("nvim-treesitter")
          return tsl.statusline({
            indicator_size = 50,
            type_patterns = { "class", "function", "method", "heading" },
            transform_fn = function(line)
              return line:gsub("%s*[%[%(%{]*%s*$", "")
            end,
            separator = "",
          }) or ""
        end,
      },
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
