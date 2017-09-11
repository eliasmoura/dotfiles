# http://pascal-lang.org
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*[.](pas|lpr) %{
    set buffer filetype pascal
}

# Linter
#

set lintcmd fpc

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter -group / regions -default code pascal       \
    double_string '"' .*?"                   '' \
    single_string "'" .*?'                   '' \
    comment       // $                       '' \
    comment       \{ \}                      '' \
    comment       \(\* \*\)                  '' \
    literal       '%[iqrswxIQRSWX]\(' \)     \( \
    literal       '%[iqrswxIQRSWX]\{' \}     \{ \
    literal       '%[iqrswxIQRSWX]\[' \]     \[ \
    literal       '%[iqrswxIQRSWX]<'   >      < \
    division '[\w\)\]](/|(\h+/\h+))' '\w' '' # Help Kakoune to better detect /…/ literals

# Regular expression flags are: i → ignore case, m → multi-lines, o → only interpolate #{} blocks once, x → extended mode (ignore white spaces)
# Literals are: i → array of symbols, q → string, r → regular expression, s → symbol, w → array of words, x → capture shell result

add-highlighter -group /pascal/double_string fill comment
add-highlighter -group /pascal/double_string regions regions interpolation \Q#{ \} \{
add-highlighter -group /pascal/double_string/regions/interpolation fill meta

add-highlighter -group /pascal/single_string fill string

add-highlighter -group /pascal/comment fill comment

add-highlighter -group /pascal/literal fill meta

add-highlighter -group /pascal/code regex \b([A-Za-z]\w*\s*:(?=[^:]))|([$@][A-Za-z]\w*)|((?<=[^:]):(([A-Za-z]\w*[=?!]?)|(\[\]=?)))|([A-Z]\w*|^|\h)\K::(?=[A-Z]) 0:variable

%sh{
    # Grammar
    # Keywords are collected searching for keywords at
    # https://github.com/pascal/pascal/blob/trunk/parse.y
    keywords="absolute|abstract|add|and|AnsiChar|AnsiString|Application|array"
    keywords="${keywords}|as|asm|assembler|at|automated|begin|Boolean|Byte"
    keywords="${keywords}|ByteBool|Cardinal|case|cdecl|Char|class|Comp"
    keywords="${keywords}|const|constructor|contains|Currency|default"
    keywords="${keywords}|deprecated|destructor|dispid|dispinterface|div"
    keywords="${keywords}|do|Double|downto|dynamic|else|end|except|Exception"
    keywords="${keywords}|export|exports|Extended|external|false|far|file|final"
    keywords="${keywords}|finalization|finally|for|forward|function|goto|if"
    keywords="${keywords}|implementation|implements|in|index|inherited"
    keywords="${keywords}|initialization|inline|Int64|Integer|interface|is"
    keywords="${keywords}|label|library|LongInt|local|LongBool|LongWord|message"
    keywords="${keywords}|mod|name|near|nil|null|nodefault|not|of|on|or|out"
    keywords="${keywords}|overload|override|package|packed|PAnsiChar|pascal"
    keywords="${keywords}|PByteArray|PChar|PCurrency|PDouble|PExtended"
    keywords="${keywords}|PInteger|platform|POleVariant|private|procedure"
    keywords="${keywords}|program|property|protected|PSingle|PShortString"
    keywords="${keywords}|PString|PTextBuff|public|published|PVariant|PVarRec"
    keywords="${keywords}|PWideChar|PWideString|PWordArray|raise|read|readonly"
    keywords="${keywords}|Real|Real48|record|register|reintroduce|remove|repeat"
    keywords="${keywords}|requires|resident|resourcestring|safecall|Self|set|shl"
    keywords="${keywords}|Single|ShortInt|ShortString|shr|SmallInt|static|stdcall"
    keywords="${keywords}|stored|strict|private|strict|protected|string|then"
    keywords="${keywords}|threadvar|to|true|try|type|uint64|unit|unsafe"
    keywords="${keywords}|until|uses|var|varargs|Variant|virtual|while"
    keywords="${keywords}|WideChar|WideString|with|Word|WordBool|write|writeonly|xor"

    attributes="attr_reader|attr_writer|attr_accessor"
    values="false|true|nil"
    meta="program|uses|unit|type|var|const|implementation|private|public|protected|\;|end\."
    # Add the language's grammar to the static completion list
    printf %s\\n "hook global WinSetOption filetype=pascal %{
        set window static_words '${keywords}:${attributes}:${values}:${meta}'
    }" | sed 's,|,:,g'

    # Highlight keywords
    printf %s "
        add-highlighter -group /pascal/code regex \b(?i)(${keywords})\b 0:keyword
        add-highlighter -group /pascal/code regex \b(?i)(${attributes})\b 0:attribute
        add-highlighter -group /pascal/code regex \b(?i)(${values})\b 0:value
        add-highlighter -group /pascal/code regex \b(?i)(${meta})\b 0:meta
    "
}

# Commands
# ‾‾‾‾‾‾‾‾

def pascal-alternative-file -docstring 'Jump to the alternate file (implementation ↔ test)' %{ %sh{
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

def -hidden pascal-filter-around-selections %{
    eval -no-hooks -draft -itersel %{
        exec <a-x>
        # remove trailing white spaces
        try %{ exec -draft s \h + $ <ret> d }
    }
}

def -hidden pascal-indent-on-char %{
    eval -no-hooks -draft -itersel %{
        # align middle and end structures to start
        try %{ exec -draft <a-x> <a-k> ^ \h * (else) $ <ret> <a-\;> <a-?> ^ \h * (if)                                                       <ret> s \A | \Z <ret> \' <a-&> }
        try %{ exec -draft <a-x> <a-k> ^ \h * (when)       $ <ret> <a-\;> <a-?> ^ \h * (case)                                                     <ret> s \A | \Z <ret> \' <a-&> }
        try %{ exec -draft <a-x> <a-k> ^ \h * (end)        $ <ret> <a-\;> <a-?> ^ \h * (begin|case|class|do|for|if|unless|until|while|try) <ret> s \A | \Z <ret> \' <a-&> }
    }
}

def -hidden pascal-indent-on-new-line %{
    eval -no-hooks -draft -itersel %{
        # preserve previous line indent
        try %{ exec -draft K <a-&> }
        # filter previous line
        try %{ exec -draft k : pascal-filter-around-selections <ret> }
        # indent after start structure
        try %{ exec -draft k <a-x> <a-k> ^ \h * (begin|case|class|do|else|for|if|unless|until|when|while) \b <ret> j <a-gt> }
    }
}

def -hidden pascal-insert-on-new-line %{
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

hook -group pascal-highlight global WinSetOption filetype=pascal %{ add-highlighter ref pascal }

hook global WinSetOption filetype=pascal %{
    hook window InsertChar .* -group pascal-indent pascal-indent-on-char
    hook window InsertChar \n -group pascal-insert pascal-insert-on-new-line
    hook window InsertChar \n -group pascal-indent pascal-indent-on-new-line

    alias window alt pascal-alternative-file
}

hook -group pascal-highlight global WinSetOption filetype=(?!pascal).* %{ remove-highlighter pascal }

hook global WinSetOption filetype=(?!pascal).* %{
    remove-hooks window pascal-indent
    remove-hooks window pascal-insert

    unalias window alt pascal-alternative-file
}
