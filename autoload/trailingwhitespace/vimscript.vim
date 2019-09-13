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

    "return the number of lines edited
    return l:lines
endfunction
