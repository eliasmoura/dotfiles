# XDG_CONFIG_HOME/zsh/.zshrc

# Modules.
autoload -Uz edit-command-line run-help compinit zmv
zmodload zsh/complist
compinit

zle -N edit-command-line
zle -N zle-line-init
zle -N zle-keymap-select

# Shell options.
setopt auto_cd \
       glob_dots \
       hist_verify \
       hist_append \
       prompt_subst \
       share_history \
       extended_glob \
       rm_star_silent \
       hist_fcntl_lock \
       print_exit_value \
       complete_aliases \
       numeric_glob_sort \
       hist_save_no_dups \
       hist_ignore_space \
       hist_ignore_space \
       hist_reduce_blanks \
       inc_append_history \
       hist_ignore_all_dups \
       interactive_comments

READNULLCMD=$EDITOR
HELPDIR=/usr/share/zsh/$ZSH_VERSION/help
HISTFILE=$XDG_CONFIG_HOME/zsh/.zhistory
HISTSIZE=25000
SAVEHIST=$HISTSIZE

# Style.
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' rehash yes
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

PROMPT='%m %n %F{green}${branch}%f ${jobs_count} %F{cyan}%~%f
-> '

function zle-line-init zle-keymap-select {
  zle reset-prompt
}

# Functions.
# All I want is the git branch for now, vcs_info is way overkill to do this.
function get_git_branch {
    if [[ -d .git ]]; then
        read -r branch < .git/HEAD
        branch="${branch##*/}"
    else
        branch=""
    fi
}

function list_jobs {
  job_list=$(jobs)
  j=$(printf "%s\n" "$job_list" | wc -l)
  if [[ "$j" -ne 0 ]]
  then
    jobs_count="[$j]"
  else
    jobs_count=""
  fi
}

# Print basic prompt to the window title.
function precmd {
    print -Pn "\e];%n %~\a"
    get_git_branch
    list_jobs
}

# Print the current running command's name to the window title.
function preexec {
    if [[ $TERM == xterm-* ]]; then
        local cmd=${1[(wr)^(*=*|sudo|exec|ssh|-*)]}
        print -Pn "\e];$cmd:q\a"
    fi
}

bindkey -e emacs
#

bindkey $terminfo[kcbt] reverse-menu-complete

# bindkey -M emacs '^R' history-incremental-pattern-search-backward
# bindkey               history-incremental-pattern-search-backward
bindkey -M emacs  ' '  magic-space
# bindkey -M emacs  '^P' up-line-or-search
# bindkey           '^P' up-line-or-search
# bindkey -M emacs  '^P' down-line-or-search
# bindkey           '^P' down-line-or-search

bindkey -M isearch '^M' accept-search

# Quick and easy note taking (I should make this into a seperate script).
function n {
    $EDITOR "${@[@]/#/"$HOME/writings/notes/"}"
}
compdef "_files -W $HOME/writings/notes -/" n

function nrm {
    rm -v "${@[@]/#/"$HOME/writings/notes/"}"
}
compdef "_files -W $HOME/writings/notes -/" nrm

function nmv {
    mv -v "${@[@]/#/"$HOME/writings/notes/"}"
}
compdef "_files -W $HOME/writings/notes -/" nmv

# Aliases.
alias -g ...='../..'
alias -g ....='../../..'
alias rr='rm -rvI'
alias rm='rm -vI'
alias cp='cp -vi'
alias cr='cr -vir'
alias mv='mv -vi'
alias ln='ln -vi'
alias mkdir='mkdir -vp'
alias grep='grep --color=auto'

alias e='emacsclient -t'

alias chmod='chmod -c --preserve-root'
alias chown='chown -c --preserve-root'
alias chgrp='chgrp -c --preserve-root'

alias ls='ls --color=auto --show-control-chars --group-directories-first -AhXF'
alias ll='ls --color=auto --show-control-chars --group-directories-first -AlhXF'
alias lsblk='lsblk -oNAME,SIZE,FSAVAIL,OWNER,GROUP,MODE,FSTYPE,LABEL,MOUNTPOINT,UUID'

alias dmesg=dmesg -exL
alias weechat='weechat - $XDG_CONFIG_HOME/weechat'
alias tmux="tmux -f ${XDG_CONFIG_HOME:-$HOME/local/cfg}/tmux/tmux.conf"
alias mutt="mutt -F ${XDG_CONFIG_HOME:-$HOME/local/cfg}/mutt/muttrc"
# alias news="newsbeuter -u ${XDG_CONFIG_HOME:-$HOME/local/cfg}/newsbeuter/urls -C ${XDG_CONFIG_HOME:-$HOME/local/cfg}/newsbeuter/confg -c ${XDG_CACHE_HOME:-$HOME/tmp}/newsbeuter/"

# alias ;q='exit'

alias ix="curl -F 'f:1=<-' ix.io"
alias sprunge="curl -F 'sprunge=<-' sprunge.us"
alias ptpb="curl -F 'c=@-' https://ptpb.pw"
alias xc='xclip -o | i'

# XXX force XDG_CONFIG_HOME where possible.
alias aria2c="aria2c --dht-file-path $XDG_CACHE_HOME/aria2/dht.dat"
alias gdb="gdb -nh -x $XDG_CONFIG_HOME/gdb/init"

# Bash-like help.
# unalias run-help
alias help='run-help'

function gl {
    branch="${1:-master}"
    printf 'Fetching commits…\n'
    git fetch "$(git config remote.origin.url)" "$branch" 2> /dev/null
    if [ $(git rev-list HEAD...FETCH_HEAD --count "$branch") -gt 0 ]; then
        git log --pretty=format:'%C(auto)%h %C(blue)%an %C(green bold)(%cr) %C(reset)%s' -- HEAD...FETCH_HEAD
    else
        printf 'Nothing new :(\n'
    fi
}

# Directory hashes.
if [[ -d $HOME/dev ]]; then
    for d in $HOME/dev/*(/); do
        hash -d ${d##*/}=$d
    done
fi

specwave() { ffplay -f lavfi 'amovie='"$1"', asplit[out1][a]; [a]showwaves=mode=p2p:s=1366x768[waves]; [waves] frei0r=filter_name=distort0r:filter_params=0.5|0.01[out0]' }

#duck
duck() {
for i in $(seq 1 80); do ((i % 4)) && printf "%${i}s_o- _o- _o-" "" || printf "%${i}s_o< _o< _o<" ""; ((i % 2)) && printf " _O<\r" "" || printf " _O-\r" ""; sleep 0.5s; done
}

yts_video() { mpv --ytdl-format=18 --keep-open --pause ytdl://ytsearch1:"$1" }
yts_audio() { mpv --ytdl-format=140 --keep-open ytdl://ytsearch1:"$1" }
ytpl_audio() { mpv --ytdl-format=140 --keep-open --playlist="$1"}

toggle_tpad() { synclient TouchpadOff=$(synclient -l | awk '/TouchpadOff/ { print !$3 }'); }

procswap() { awk '/Name/ { n = $2 }; /VmSwap/ && $2 > 0 { print n, $2, "kB" | "column -t" }' /proc/*/status; }
soneeded() { readelf -d $1 | awk '/NEEDED/ {gsub(/[\[\]]/, "", $5); print $5}' }  


dl-pl() { youtube-dl -i -o '%(playlist)s/%(title)s.%(ext)s' "$1" }
dl-all() { youtube-dl -i -o '%(uploader)s/%(autonumber)s_-_%(title)s.%(ext)s' "$1" }
