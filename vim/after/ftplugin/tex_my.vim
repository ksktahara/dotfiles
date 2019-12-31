if exists('b:did_ftplugin_tex_my')
    finish
endif
let b:did_ftplugin_tex_my = 1

setl fileencoding=utf-8
setl tabstop=2 expandtab shiftwidth=2 softtabstop=2

" override TagbarToggle
nnoremap <silent> <Leader>b :<C-u>VimtexTocToggle<CR>

" map for location list
call ToggleQL(1)
