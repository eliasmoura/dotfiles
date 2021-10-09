config.load_autoconfig()


# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'file://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

c.fonts.default_family = "Inconsolatazi4"
c.fonts.default_size = "14pt"
c.fonts.statusbar = "16pt Inconsolatazi4"
c.fonts.prompts = "16pt Inconsolatazi4"
c.fonts.hints = "16pt Inconsolatazi4"
c.fonts.messages.error = "14pt Inconsolatazi4"
c.fonts.messages.warning = "14pt Inconsolatazi4"
c.fonts.messages.info = "14pt Inconsolatazi4"

c.messages.timeout = 1000


c.editor.command = ["/usr/bin/alacritty", "--class", "qute_editor,qute_editor", "-t", "Qutebrowser editor", "-e", "nvim", "-f", "{file}"]
