function! trailingwhitespace#unix#ClearTrailingWhitespace() abort
    "use sed and wc to get number of lines conforming to pattern
    let l:lines = system('sed -n "/\s\+$/p" | wc -l', getline(1, '$'))

    if l:lines > 0
        "hold on to cursor position (also gets preferred column, so
        "nothing changes)
        let l:startpos = getcurpos()

        "get the top line of the window
        let l:topline = line('w0')

        "use sed to replace lines
        silent %!sed "s/\s\+$//"

        "move topline to top of screen
        "(if you're looking at this outside of Vim, this is using a literal ^E
        "character [looks like 'normal! ^E' when viewed in Vim])
        execute l:topline
        while line('w0') < l:topline
            normal! 
        endwhile

        "return cursor to starting position
        call setpos('.', l:startpos)
    endif

    "redraw to avoid a multiline echo, which requires pressing
    "enter to exit
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
