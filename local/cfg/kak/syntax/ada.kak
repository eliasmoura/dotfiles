# http://ada-lang.org
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*[.](adb|ads) %{
    set buffer filetype ada
}

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter -group / regions -default code ada       \
    double_string '"' .*?"                   '' \
    single_string "'" .*?'                   '' \
    comment       -- $                       '' \
    literal       '%[iqrswxIQRSWX]\(' \)     \( \
    literal       '%[iqrswxIQRSWX]\{' \}     \{ \
    literal       '%[iqrswxIQRSWX]\[' \]     \[ \
    literal       '%[iqrswxIQRSWX]<'   >      < \
    division '[\w\)\]](/|(\h+/\h+))' '\w' '' # Help Kakoune to better detect /…/ literals

# Regular expression flags are: i → ignore case, m → multi-lines, o → only interpolate #{} blocks once, x → extended mode (ignore white spaces)
# Literals are: i → array of symbols, q → string, r → regular expression, s → symbol, w → array of words, x → capture shell result

add-highlighter -group /ada/double_string fill string
add-highlighter -group /ada/double_string regions regions interpolation \Q#{ \} \{
add-highlighter -group /ada/double_string/regions/interpolation fill meta

add-highlighter -group /ada/single_string fill string

add-highlighter -group /ada/comment fill comment

add-highlighter -group /ada/literal fill meta

add-highlighter -group /ada/code regex \b([A-Za-z]\w*\s*:(?=[^:]))|([$@][A-Za-z]\w*)|((?<=[^:]):(([A-Za-z]\w*[=?!]?)|(\[\]=?)))|([A-Z]\w*|^|\h)\K::(?=[A-Z]) 0:variable

%sh{
    # Grammar
    # Keywords are collected searching for keywords at
    # https://github.com/ada/ada/blob/trunk/parse.y
    keywords="abort|else|new|return|abs|elsif|not|reverse|abstract|end|null"
    keywords="${keywords}|accept|entry|select|access|exception|of|separate"
    keywords="${keywords}|aliased|exit|or|subtype|all|others|synchronize"
    keywords="${keywords}|and|for|out|array|function|overriding|tagged|at"
    keywords="${keywords}|task|generic|package|terminate|begin|goto|pragma"
    keywords="${keywords}|the|body|private|type|if|procedure|case|in|then"
    keywords="${keywords}|protected|unti|constant|interface|use|is|raise"
    keywords="${keywords}|declare|range|when|delay|limited|record|whil|delta"
    keywords="${keywords}|loop|rem|with|digits|renames|do|mod|requeue|xor"

    attributes="attr_reader|attr_writer|attr_accessor"
    values="false|true"
    meta="program|use|unit|type|var|const|implementation|private|public|protected"
    # Add the language's grammar to the static completion list
    printf %s\\n "hook global WinSetOption filetype=ada %{
        set window static_words '${keywords}:${attributes}:${values}:${meta}'
    }" | sed 's,|,:,g'

    # Highlight keywords
    printf %s "
        add-highlighter -group /ada/code regex \b(?i)(${keywords})\b 0:keyword
        add-highlighter -group /ada/code regex \b(?i)(${attributes})\b 0:attribute
        add-highlighter -group /ada/code regex \b(?i)(${values})\b 0:value
        add-highlighter -group /ada/code regex \b(?i)(${meta})\b 0:meta
    "
}

# Commands
# ‾‾‾‾‾‾‾‾

def ada-alternative-file -docstring 'Jump to the alternate file (implementation ↔ test)' %{ %sh{
    case $kak_buffile in
        *spec/*_spec.rb)
            altfile=$(eval echo $(echo $kak_buffile | sed s+spec/+'*'/+';'s/_spec//))
            [ ! -f $altfile ] && echo "echo -markup '{Error}implementation file not found'" && exit
        ;;
        *.rb)
            path=$kak_buffile
            dirs=$(while [ $path ]; do echo $path; path=${path%/*}; done | tail -n +2)
            for dir in $dirs; do
                altdir=$dir/spec
                if [ -d $altdir ]; then
                    altfile=$altdir/$(realpath $kak_buffile --relative-to $dir | sed s+[^/]'*'/++';'s/.rb$/_spec.rb/)
                    break
                fi
            done
            [ ! -d $altdir ] && echo "echo -markup '{Error}spec/ not found'" && exit
        ;;
        *)
            echo "echo -markup '{Error}alternative file not found'" && exit
        ;;
    esac
    echo "edit $altfile"
}}

def -hidden ada-filter-around-selections %{
    eval -no-hooks -draft -itersel %{
        exec <a-x>
        # remove trailing white spaces
        try %{ exec -draft s \h + $ <ret> d }
    }
}

def -hidden ada-indent-on-char %{
    eval -no-hooks -draft -itersel %{
        # align middle and end structures to start
        try %{ exec -draft <a-x> <a-k> ^ \h * (else) $ <ret> <a-\;> <a-?> ^ \h * (if)                                                       <ret> s \A | \Z <ret> \' <a-&> }
        try %{ exec -draft <a-x> <a-k> ^ \h * (when)       $ <ret> <a-\;> <a-?> ^ \h * (case)                                                     <ret> s \A | \Z <ret> \' <a-&> }
        try %{ exec -draft <a-x> <a-k> ^ \h * (end)        $ <ret> <a-\;> <a-?> ^ \h * (begin|case|class|do|for|if|unless|until|while|try) <ret> s \A | \Z <ret> \' <a-&> }
    }
}

def -hidden ada-indent-on-new-line %{
    eval -no-hooks -draft -itersel %{
        # preserve previous line indent
        try %{ exec -draft K <a-&> }
        # filter previous line
        try %{ exec -draft k : ada-filter-around-selections <ret> }
        # indent after start structure
        try %{ exec -draft k <a-x> <a-k> ^ \h * (begin|case|class|do|else|for|if|unless|until|when|while) \b <ret> j <a-gt> }
    }
}

def -hidden ada-insert-on-new-line %{
    eval -no-hooks -draft -itersel %{
        # copy _#_ comment prefix and following white spaces
        try %{ exec -draft k <a-x> s ^ \h * \K \# \h * <ret> y gh j P }
        # wisely add end structure
        eval -save-regs x %{
            try %{ exec -draft k <a-x> s ^ \h + <ret> \" x y } catch %{ reg x '' }
            try %{ exec -draft k <a-x> <a-k> ^ <c-r> x (begin|case|class|def|do|for|if|module|unless|until|while) <ret> j <a-a> i X <a-\;> K <a-K> ^ <c-r> x (begin|case|class|def|do|for|if|module|unless|until|while) . * \n <c-r> x end $ <ret> j x y p j a end <esc> <a-lt> }
        }
    }
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook -group ada-highlight global WinSetOption filetype=ada %{ add-highlighter ref ada }

hook global WinSetOption filetype=ada %{
    hook window InsertChar .* -group ada-indent ada-indent-on-char
    hook window InsertChar \n -group ada-insert ada-insert-on-new-line
    hook window InsertChar \n -group ada-indent ada-indent-on-new-line

    alias window alt ada-alternative-file
}

hook -group ada-highlight global WinSetOption filetype=(?!ada).* %{ remove-highlighter ada }

hook global WinSetOption filetype=(?!ada).* %{
    remove-hooks window ada-indent
    remove-hooks window ada-insert

    unalias window alt ada-alternative-file
}
