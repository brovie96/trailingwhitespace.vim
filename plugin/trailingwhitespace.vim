"set trailing whitespace to highlight in the errormsg color
highlight link TrailingWhitespace ErrorMsg

"autocmd to enable highlighting on window enter
augroup MatchTrailingWhitespace
    autocmd!
    autocmd VimEnter,WinEnter * call matchadd('TrailingWhitespace', '\s\+$')
augroup END
