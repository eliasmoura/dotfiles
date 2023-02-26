local M = {}
--- Setup the customization
---@param opts table
M.setup = function(opts)
  opts = opts or {}
  P = function(arg)
    print(vim.inspect(arg))
  end

  vim.custom.nohl = function()
    if vim.api.nvim_eval("v:hlsearch") == 1 then
      vim.cmd([[nohlsearch]])
    else
      vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes("<cr>", true, false, true),
        "n",
        true
      )
    end
  end

  vim.custom.toggleBackground = function()
    if vim.o.background == "light" then
      vim.o.background = "dark"
    else
      vim.o.background = "light"
    end
  end

  if opts.plugmgr then
    require("custom.plugins")
    if opts.bootstrap then
        require("packer").sync()
    end
  end
  require("custom.sets")
  require("custom.autocmd")
  require("custom.mappings")
  -- vim.schedule(function()
  --   require("custom.mappings")
  -- end)
end

return M
