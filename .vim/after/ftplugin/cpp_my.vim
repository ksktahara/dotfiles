if exists('b:did_ftplugin_cpp_my')
    finish
endif
let b:did_ftplugin_cpp_my = 1

" GNU Global
nnoremap <LocalLeader>f :Gtags -f %<CR>
nnoremap <LocalLeader>g :Gtags -g 
nnoremap <LocalLeader>d :GtagsCursor<CR>

