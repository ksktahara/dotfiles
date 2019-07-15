if exists('b:did_ftplugin_markdown_my')
    finish
endif
let b:did_ftplugin_markdown_my = 1

setl fileencoding=utf-8
setl tabstop=8 expandtab shiftwidth=4 softtabstop=4
setl smartindent

nnoremap <silent><buffer> <LocalLeader>t :<C-u>TableFormat<CR>
nnoremap <silent><buffer> <LocalLeader>e :<C-u>PrevimOpen<CR>

" Convert to html by pandoc <LocalLeader>E
function! s:PandocHTML()
    " lcd %:h
    !pandoc -o %:r.html %
endfunction
" command! -buffer Exec call <SID>PandocHTML()
nnoremap <silent><buffer> <LocalLeader>E :call <SID>PandocHTML()<CR>

