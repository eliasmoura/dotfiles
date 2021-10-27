local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local events = require("luasnip.util.events")

local getdir = function()
  local buf = vim.fn.getbufinfo(vim.fn.bufnr())[1].name
  if buf == nil then
    return ""
  end
  local splits = {}
  for str in string.gmatch(buf, "([%a_-]+)/") do
    table.insert(splits, str)
  end
  local dirname = splits[#splits]
  if dirname ~= nil then
    return dirname
  end
  return ""
end

local copy_git = function(args)
  local str = args[1][1]
  local name = string.gsub(str, "([%a_-]+)-git", "%1")
  return name
end

local copy_url = function(args, _, txt)
  local prefix = txt or "git+"
  return t(prefix .. args[1][1])
end

ls.snippets = {
  go = {
    s({ trig = "err" }, {
      i(1, "val"),
      t({ ", err := " }),
      i(2, "f"),t({"("}),i(0),t({")"}),
    }),
    s({ trig = "eif" }, {
      t({ "", "if err != nil {", "" }),
      i(0),
      t({ "", "}", "" }),
    }),
  },
}
