local ok, norg = pcall(require, "neorg")
if not ok then
  return
end
print("NORG!")

norg.setup({
  load = {
    ["core.defaults"] = {}, -- Load all the default modules
    ["core.norg.concealer"] = {}, -- Allows for use of icons
    ["core.integrations.treesitter"] = {},
    ["core.integrations.telescope"] = {},
    ["core.keybinds"] = { config = { default_keynids = true } },
    ["core.norg.completion"] = {
      config = { engine = "nvim-cmp" },
    },
    ["core.norg.dirman"] = { -- Manage your directories with Neorg
      config = {
        workspaces = {
          main = "~/writings/notes/",
        },
      },
    },
  },
})
