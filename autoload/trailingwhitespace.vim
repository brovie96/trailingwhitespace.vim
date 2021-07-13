"create function to remove trailing whitespace
function! trailingwhitespace#ClearTrailingWhitespace() abort
    "make sure trying this in a nonmodifiable buffer just prints a message
    "instead of throwing an error
    if &modifiable
        "print 'Working...' message
        echo 'Working...'

        "init variable to hold number of lines edited
        let l:lines = 0

        "check if using a unix-based system and if so use sed (substantially
        "faster than vimscript on files with very large numbers of lines
        "having trailing whitespace)
        if has('unix')
            let l:lines = trailingwhitespace#unix#ClearTrailingWhitespace()
        else
            let l:lines = trailingwhitespace#vimscript#ClearTrailingWhitespace()
        endif

        "redraw to avoid a multiline echo, which requires pressing enter to
        "exit
        redraw

        "mirror the message printed by :substitute
        "or say if no substitutions were made
        if l:lines == 0
            echo 'No substitutions made'
        elseif l:lines == 1
            echomsg 'One substitution on one line'
        else
            echomsg printf('%d substitutions on %d lines', l:lines, l:lines)
        endif
    else
        "state that buffer is nonmodifiable
        echo 'Buffer is nonmodifiable.'
    endif
endfunction
