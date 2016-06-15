" Preserve already-long lines
setlocal formatoptions+=l

" Do not auto-wrap text using textwidth
setlocal formatoptions-=t

" one <Tab> equals n <Space>s
setlocal tabstop=4

" treat one <Tab> as n <Space>s when editing
setlocal softtabstop=4

" each level of indentation increases by n
setlocal shiftwidth=4

" use real tabs, not spaces
setlocal noexpandtab

" do not wrap display
setlocal nowrap

" save by copying the file and overwriting the original
setlocal backupcopy=yes
