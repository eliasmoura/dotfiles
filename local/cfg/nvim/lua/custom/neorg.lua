local ok, norg = pcall(require, "neorg")
if not ok then
  return
end

norg.setup({
  load = {
    ["core.defaults"] = {}, -- Load all the default modules
    ["core.norg.concealer"] = {}, -- Allows for use of icons
    ["core.integrations.treesitter"] = {},
    ["core.integrations.telescope"] = {}, -- TODO: check how this works
    ["core.integrations.nvim-cmp"] = {}, -- TODO: check how this works
    ["core.norg.journal"] = { config = { workspace = "journal" } },
    ["core.storage"] = {}, -- TODO: check how this works
    ["core.keybinds"] = { config = { default_keynids = true,
  neorg_leader = "<leader>o"} },
    ["core.norg.qol.toc"] = {},
    ["core.norg.completion"] = {
      config = { engine = "nvim-cmp" },
    },
    ["core.export"] = {},
    ["core.export.markdown"] = {
      config = { extensions = "all" ,},
    },
    ["core.norg.dirman"] = { -- Manage your directories with Neorg
      config = {
        workspaces = {
          notes = "~/writings/notes",
          journal = "~/writings/gtd/journal",
          gtd = "~/writings/gtd",
          example_gtd = "~/writings/example_workspaces/gtd",
        },
        index = "index.norg",
      },
    },
    -- ["core.gtd.base"] = {
    --   config = {
    --     workspace = "gtd",
    --     custom_tag_completion = true,
    --   },
    -- },
  },
})
