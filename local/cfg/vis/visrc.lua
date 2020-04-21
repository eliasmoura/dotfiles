-- load standard vis module, providing parts of the Lua API
require('vis')
require('plugins/filetype')
require('plugins/complete-filename')
require('plugins/complete-word')
require('plugins/vis-commentary/vis-commentary')
require('plugins/vis-surround/vis-surround')
require('plugins/vis-title/title')
require('plugins/vis-fzf-open/fzf-open')
require('plugins/vis-git-status/vis-git-status')
--require('plugins/vis-goto-file/goto-file')
require('plugins/vis-pairs/pairs')
--require('plugins/parkour/init')
spellcheck = require('plugins/vis-spellcheck/spellcheck')
spellcheck.cmd = "aspell -l %s -a"
spellcheck.list_cmd = "aspell list -l %s -a"
spellcheck.lang = "en_US"


local home = os.getenv('XDG_CONFIG_HOME')
local cfg       = home .. '/vis'
package.path = package.path .. ';' .. cfg .. '/plugins/?'
require('plugins/vis-commentary/vis-commentary')
require('plugins/vis-surround/vis-surround')
require('plugins/vis-git-status/vis-git-status')

vis.events.subscribe(vis.events.INIT, function()
	-- Your global configuration options
	vis:command('set theme base16-gruvbox-dark-hard')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	-- Your per window configuration options e.g.
	vis:command('set number')
	vis:command('set cursorline')
	vis:command('set autoindent')
	vis:command('set tabwidth 2')
	if win.syntax ~= 'makefile' then
    	vis:command('set expandtab')
    else
    	vis:command('set expandtab off')
	end
	vis:command('set show-tabs')
	vis:command('set show-spaces')
	vis:command('set show-newlines')
	vis:command('set show-eof')
end)
