# XDG_CONFIG_HOME/zsh/.zshrc

# Modules.
autoload -Uz edit-command-line run-help compinit zmv
zmodload zsh/complist
compinit

zle -N edit-command-line
zle -N zle-line-init
zle -N zle-keymap-select

# Shell options.
setopt vi \
       auto_cd \
       glob_dots \
       hist_verify \
       append_history \
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
       hist_reduce_blanks \
       inc_append_history \
       hist_ignore_all_dups \
       interactive_comments

READNULLCMD=$EDITOR
HELPDIR=/usr/share/zsh/$ZSH_VERSION/help
HISTFILE=$XDG_CONFIG_HOME/zsh/.zhistory
HISTSIZE=500000
SAVEHIST=$HISTSIZE

# Style.
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
zstyle ':completion:*' rehash yes
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

local exit_status='%(?..%(148?..%F{red} ❌))'

PROMPT='%n@%m %F{green}$branch%f$exit_status %F{cyan}%~%f
$jobs_count ✏  '

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
  if [ -n "$job_list" ]; then
    jobs_count="[$(jobs | wc -l)] "
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

bindkey -e emacs

bindkey $terminfo[kcbt] reverse-menu-complete

bindkey -M isearch '^M' accept-search

function dt {
  git_dir_path="$HOME/.dotfiles"
  if [ "$GIT_DIR" = "$git_dir_path" ]; then
    printf 'Reverting GIT_DIR to [%s]\n' "$OLD_GIT_DIR"
    export GIT_DIR="$OLD_GIT_DIR"
  else
    export OLD_GIT_DIR="$GIT_DIR"
    printf 'Changing GIT_DIR to [%s]\n' "$git_dir_path"
    export GIT_DIR="$git_dir_path"
  fi
}

function bootstrap_nvim_cfg {
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
}

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

alias ix="curl -F 'f:1=<-' ix.io"
alias sprunge="curl -F 'sprunge=<-' sprunge.us"
alias ptpb="curl -F 'c=@-' https://ptpb.pw"

# XXX force XDG_CONFIG_HOME where possible.
alias weechat='weechat - $XDG_CONFIG_HOME/weechat'
alias tmux="tmux -f ${XDG_CONFIG_HOME:-$HOME/local/cfg}/tmux/tmux.conf"

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
    for d in $HOME/code/*(/); do
        hash -d ${d##*/}=$d
    done
fi

specwave() { ffplay -f lavfi 'amovie='"$1"', asplit[out1][a]; [a]showwaves=mode=p2p:s=1366x768[waves]; [waves] frei0r=filter_name=distort0r:filter_params=0.5|0.01[out0]' }

#duck
duck() {
for i in $(seq 1 80); do ((i % 4)) && printf "%${i}s_o- _o- _o-" "" || printf "%${i}s_o< _o< _o<" ""; ((i % 2)) && printf " _O<\r" "" || printf " _O-\r" ""; sleep 0.5s; done
}

toggle_tpad() { synclient TouchpadOff=$(synclient -l | awk '/TouchpadOff/ { print !$3 }'); }

procswap() { awk '/Name/ { n = $2 }; /VmSwap/ && $2 > 0 { print n, $2, "kB" | "column -t" }' /proc/*/status; }
soneeded() { readelf -d $1 | awk '/NEEDED/ {gsub(/[\[\]]/, "", $5); print $5}' }  

dl-pl() { youtube-dl -i -o '%(playlist)s/%(title)s.%(ext)s' "$1" }
dl-all() { youtube-dl -i -o '%(uploader)s/%(autonumber)s_-_%(title)s.%(ext)s' "$1" }
