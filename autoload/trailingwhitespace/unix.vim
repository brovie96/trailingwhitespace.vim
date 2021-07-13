function! trailingwhitespace#unix#ClearTrailingWhitespace() abort
    "use sed and wc to get number of lines conforming to pattern
    let l:lines = system('sed -n "/\s\+$/p" | wc -l', getline(1, '$'))

    if l:lines > 0
        "hold on to cursor position (also gets preferred column, so nothing
        "changes)
        let l:startpos = getcurpos()

        "get the top line of the window
        let l:topline = line('w0')

        "use sed to replace lines
        silent %!sed "s/\s\+$//"

        "move topline to top of screen
        let l:diff = l:topline - line('w0')

        if l:diff > 0
            execute 'normal!' l:diff . "\<C-E>"
        endif

        "return cursor to starting position
        call setpos('.', l:startpos)
    endif

    "return the number of lines edited
    return l:lines
endfunction
