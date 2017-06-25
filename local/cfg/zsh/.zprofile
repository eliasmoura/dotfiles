# XDG_CONFIG_HOME/zsh/.zprofile

export XDG_CACHE_HOME=$HOME/local/tmp
export XDG_CONFIG_HOME=$HOME/local/cfg
export XDG_DATA_HOME=$HOME/local/share
export LOCAL=$HOME/local

export PATH=$HOME/local/bin:$PATH
export MANPATH=$MANPATH:$LOCAL/share/man

export ABDUCO_SOCKET_DIR=$XDG_RUNTIME_DIR/abduco
export TMPDIR=$XDG_RUNTIME_DIR
export PASSWORD_STORE_DIR=$HOME/local/share/pass
export SLRNHOME=$XDG_CONFIG_HOME/slrn

# https://github.com/mozilla/rr/issues/1455#issuecomment-89714904
export _RR_TRACE_DIR=$XDG_DATA_HOME/rr

export CARGO_HOME=$XDG_DATA_HOME/cargo
export SBCL_HOME=$XDG_CONFIG_HOME/sbcl
export GNUPGHOME=$XDG_CONFIG_HOME/gnupg
export INPUTRC=$XDG_CONFIG_HOME/inputrc
export RLWRAP_HOME=$XDG_DATA_HOME/rlwrap
export LYNX_CFG_PATH=$XDG_CONFIG_HOME/lynx
export TIGRC_USER=$XDG_CONFIG_HOME/tig/tigrc

export WEECHAT_HOME=$XDG_CONFIG_HOME/weechat
export PERL_CPANM_HOME=$XDG_CACHE_HOME/cpanm
export GIMP2_DIRECTORY=$XDG_CONFIG_HOME/gimp
export ELINKS_CONFDIR=$XDG_CONFIG_HOME/elinks
export CABAL_CONFIG=$XDG_DATA_HOME/cabal/config
export HTTPIE_CONFIG_DIR=$XDG_CONFIG_HOME/httpie
export XCOMPOSEFILE=$XDG_CONFIG_HOME/x11/xcompose
export GUILE_HISTORY=$XDG_CONFIG_HOME/guile/history
export VIMPERATOR_RUNTIME=$XDG_CONFIG_HOME/vimperator
export NOTMUCH_CONFIG=$XDG_CONFIG_HOME/notmuch/notmuchrc
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/settings.ini
export TERMINFO_DIRS=$XDG_DATA_HOME/terminfo:/usr/share/terminfo
export UNCRUSTIFY_CONFIG=$XDG_CONFIG_HOME/uncrustify/uncrustify.cfg
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"


export LESSHISTFILE=$XDG_CACHE_HOME/less/history
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Chicken libraries/eggs.
export CHICKEN_REPOSITORY=$LOCAL/lib/chicken
export CHICKEN_INCLUDE_PATH=$LOCAL/lib/chicken

# Perl libraries.
export PERL5LIB=$LOCAL/lib/perl5
export PERL_MM_OPT=INSTALL_BASE=$LOCAL
export PERL_MB_OPT="--install_base $LOCAL"
export PERLBREW_ROOT=$LOCAL/share/perlbrew
export GOPATH=$LOCAL/share/go

# Xorg and XKB.
export GTK_IM_MODULE=xim
export XKB_DEFAULT_LAYOUT=br
export XKB_DEFAULT_OPTIONS=compose:caps
#export XAUTHORITY=$XDG_RUNTIME_DIR/x11/xauthority

export EDITOR=nvim
export VISUAL=pinfo
export SUDO_EDITOR="nvim -Z"

export LESS=-RX

export WWW_HOME=archlinux.org
export PAGER=less

export BROWSER=plumber
export TERMINAL=termite

# LS_COLORS (or a valid TERM, which I don't have) is now required for `ls` to
# use colour.
#source <(dircolors $XDG_CONFIG_HOME/terminal-colors.d/ls.enable)

# Disable Mono and Gecko installation and .desktop creation.
export WINEDLLOVERRIDES=winemenubuilder.exe,mscoree,mshtml=d
export WINEPREFIX=$XDG_DATA_HOME/wine/default
export WINEARCH=win32
export WINEDEBUG=-all

#export GALLIUM_HUD="cpu0+cpu1+cpu2+cpu3;fps"

export SDL_AUDIODRIVER=pulse


# Java BS
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd -XX:-UsePerfData"
export NPM_CONFIG_USERCONFIG={$XDG_CONFIG_HOME:-$HOME/local/cfg}/npm/npmrc