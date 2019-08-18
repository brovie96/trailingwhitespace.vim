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
            call trailingwhitespace#unix#ClearTrailingWhitespace()
        else
            call trailingwhitespace#vimscript#ClearTrailingWhitespace()
        endif
    else
        "state that buffer is nonmodifiable
        echo 'Buffer is nonmodifiable.'
    endif
endfunction
