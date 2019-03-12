"create function to remove trailing whitespace
function! trailingwhitespace#ClearTrailingWhitespace() abort
    "make sure trying this in a nonmodifiable buffer just prints a message
    "instead of throwing an error
    if &modifiable
        "print 'Working...' message
        echo 'Working...'

        "set loop variables
        let l:lines = 0 | let l:linenum = 1

        "loop through each line
        for l:line in getline(1, '$')
            "only operate on a line if it has trailing whitespace
            if match(l:line, '\s\+$') > -1
                "add 1 to count of lines that have been changed
                let l:lines += 1

                "remove trailing whitespace
                call setline(l:linenum, substitute(l:line, '\s\+$', '', ''))
            endif

            "add one to line number so the correct line is swapped
            let l:linenum += 1
        endfor

        "redraw to avoid a multiline echo, which requires pressing enter to
        "exit
        redraw

        if l:lines > 0
            "mirror the message printed by :substitute
            if l:lines == 1
                echomsg 'One substitution on one line'
            else
                echomsg printf('%d substitutions on %d lines', l:lines, l:lines)
            endif
        else
            "state that no lines were changed
            echo 'No substitutions made'
        endif
    else
        "state that buffer is nonmodifiable
        echo 'Buffer is nonmodifiable.'
    endif
endfunction
