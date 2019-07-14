if exists('b:did_ftplugin_cpp_my')
    finish
endif
let b:did_ftplugin_cpp_my = 1

" LSP mappings
nnoremap <LocalLeader>d :<C-u>LspDefinition<CR>
nnoremap <LocalLeader>n :<C-u>LspDocumentDiagnostics<CR>

" GNU Global
nnoremap <silent><buffer> <LocalLeader>f :<C-u>Gtags -f %<CR>
nnoremap <buffer> <LocalLeader>g :<C-u>Gtags -g
nnoremap <silent><buffer> <LocalLeader>c :<C-u>GtagsCursor<CR>
