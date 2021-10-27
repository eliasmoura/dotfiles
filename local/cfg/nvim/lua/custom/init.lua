P = function(arg)
  print(vim.inspect(arg))
end

vim.custom.nohl = function()
  if vim.api.nvim_eval("v:hlsearch") == 1 then
    vim.cmd([[:nohl]])
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
