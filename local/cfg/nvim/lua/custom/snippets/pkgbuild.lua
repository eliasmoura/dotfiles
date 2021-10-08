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
  sh = {
    s(
      {
        trig = "pkg",
        name = "templ",
        dscr = "Basic template for archlinux PKGBUILD",
        wordTrig = false,
      },
      {
        t({ "# Maintainer: Elias Alves Moura<eliasmoura.alves@gmail.com>", "" }),
        t({ "", [[pkgname=]] }),
        c(1, { f(getdir, {}), i(nil) }),
        t({ "", [[pkgver=]] }),
        i(2, [[1.0]]),
        t({ "", [[pkgrel=1]] }),
        t({ "", [[arch=(']] }),
        i(3, [[i686' 'x86_64]]),
        t([[')]]),
        t({ "", [[url=']] }),
        i(4, "https://www.example.com"),
        t({ [[']] }),
        t({ "", [[desc=']] }),
        i(5),
        t({ [[']] }),
        t({ "", [[license=(']] }),
        i(6),
        t({ [[')]] }),
        t({ "", [[depends=(']] }),
        i(7),
        t({ [[')]] }),
        t({ "", [[makedepends=(']] }),
        i(8),
        t({ [[')]] }),
        t({ "", [[checkdepends=(']] }),
        i(9),
        t({ [[')]] }),
        t({ "", [[optdepends=(']] }),
        i(10),
        t({ [[')]] }),
        t({ "", [[provides=(']] }),
        c(11, { f(copy_git, 1), i(nil) }),
        t({ [[')]] }),
        t({ "", [[conflicts=(']] }),
        c(13, { f(copy_git, 11), i(nil) }),
        t({ [[')]] }),
        t({ "", [[replaces=(']] }),
        c(14, { f(copy_git, 11), i(nil) }),
        t({ [[')]] }),
        t({ "", [[options=(]] }),
        i(15, [[!strip]]),
        t({ [[)]] }),
        t({ "", [[source=(']] }),
        c(17, {
          d(nil, copy_url, 4, "git+"),
          i(nil, [[git+https://github.com/neovim/neovim.git]]),
        }),
        t({ [[')]] }),
        t({ "", [[md5sums=(']] }),
        i(18, [[SKIP]]),
        t({ [[')]], "" }),

        t({ "", [[pkgver() {]] }),
        t({ "", [[\tcd ]] }),
        f(copy_git, 1),
        t({
          "",
          [[\tgit describe --long | sed 's/^v//;s/\([^-]*-g\)/r\1/;s/-/./g']],
        }),
        t({ "", [[}]], "" }),

        t({ "", [[build() {]] }),
        t({ "", [[\tcd ]] }),
        f(copy_git, 1),
        t({ "", "\t" }),
        i(0),
        t({ "", [[}]], "" }),

        t({ "", [[check() {]] }),
        t({ "", [[\tcd ]] }),
        f(copy_git, 1),
        t({ "", [[}]], "" }),

        t({ "", [[package() {]] }),
        t({ "", [[\tcd ]] }),
        f(copy_git, 1),
        t({ "", [[}]], "" }),
        t({ "", [[# vim:set ts=2 sw=2 et:]] }),
      }
    ),
  },
}
