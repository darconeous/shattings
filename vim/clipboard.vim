
" check for underlying system - needed for clipboard
let uname = substitute(system("uname"),"\n","","g")

if uname == "Darwin"
	nmap <F6> :.w !pbcopy<CR><CR>
	vmap <F6> :w !pbcopy<CR><CR>
	nmap <F7> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
	imap <F7> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
elseif uname == "Linux"
	vmap <F6> :!xclip -f -sel clip<CR>
	map <F7> :-1r !xclip -o -sel clip<CR>
endif

