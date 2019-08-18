function! trailingwhitespace#vimscript#ClearTrailingWhitespace() abort
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

    "redraw to avoid a multiline echo, which requires pressing enter
    "to exit
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
endfunction
