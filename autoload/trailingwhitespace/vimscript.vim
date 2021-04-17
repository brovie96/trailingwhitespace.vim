function! trailingwhitespace#vimscript#ClearTrailingWhitespace() abort
    "get all the lines in the buffer
    let l:buflines = getline(1, '$')

    "set loop variables
    let l:lines = 0 | let l:linenum = -1

    "check stored copy of the buffer for any lines with trailing whitespace
    while match(l:buflines, '\s\+$', l:linenum + 1) > -1
        "add 1 to count of lines that have been changed
        let l:lines += 1

        "get current matching line number and text of the line
        let l:linenum = match(l:buflines, '\s\+$', l:linenum + 1)
        let l:line = l:buflines[l:linenum]

        "remove trailing whitespace
        call setline(l:linenum + 1, substitute(l:line, '\s\+$', '', ''))
    endwhile

    "return the number of lines edited
    return l:lines
endfunction
