local ok, lualine = pcall(require, "lualine")
if not ok then
  vim.notify("fail")
  return
end
lualine.setup({
  options = {
    icons_enabled = true,
    theme = "tokyonight",
    component_separators = { "", "" },
    section_separators = { "", "" },
    disabled_filetypes = {},
    globalstatus = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { "filename" },
    lualine_x = {
      {
        function() end,
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
        color = function()
          local s = require("dap.progress").status()
          if s == "Running" or s == "" then
            return "Normal"
          else
            if s:match([[[Ss]topped]]) ~= nil then
              return "ErrorMsg"
            else
              return "WarnMsg"
            end
          end
        end,
      },
      {
        function()
          local tsl = require("nvim-treesitter")
          return tsl.statusline({
            indicator_size = 50,
            type_patterns = { "class", "function", "method", "heading", "use" },
            transform_fn = function(line)
              return line:gsub("%s*[%[%(%{]*%s*$", " → "):gsub(" → $", "")
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
