"create function to remove trailing whitespace
function! trailingwhitespace#ClearTrailingWhitespace() abort
    "make sure trying this in a nonmodifiable buffer just prints a message
    "instead of throwing an error
    if &modifiable
        "print 'Working...' message
        echo 'Working...'

        "check if using a unix-based system and if so use sed (way faster than
        "vimscript)
        if has('unix')
            call s:ClearTrailingWhitespaceUnix()
        else
            call s:ClearTrailingWhitespaceVimscript()
        endif
    else
        "state that buffer is nonmodifiable
        echo 'Buffer is nonmodifiable.'
    endif
endfunction

function! s:ClearTrailingWhitespaceUnix() abort
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

function! s:ClearTrailingWhitespaceVimscript() abort
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
