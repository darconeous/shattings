
" check for underlying system - needed for clipboard
let uname = substitute(system("uname"),"\n","","g")

" Converts binary plists as XML plists.
if uname == "Darwin"
augroup plist
  
  autocmd BufReadPre,FileReadPre        *.plist set bin
  autocmd BufReadPre,FileReadPre        *.plist let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost      *.plist set cmdheight=2|'[,']!plutil -convert xml1 -o - -

" TODO: Check plist formatting is correct before saving!


"  autocmd BufReadPost,FileReadPost      *.plist set cmdheight=1 nobin|execute ":doautocmd BufReadPost " . expand("%:r")
"  autocmd BufReadPost,FileReadPost      *.plist let &ch = ch_save|unlet ch_save

"  autocmd BufWritePost,FileWritePost    *.plist !mv <afile> <afile>:r
"  autocmd BufWritePost,FileWritePost    *.plist !bzip2 <afile>:r

"  autocmd FileAppendPre                 *.bz2 !bunzip2 <afile>
"  autocmd FileAppendPre                 *.bz2 !mv <afile>:r <afile>
"  autocmd FileAppendPost                *.bz2 !mv <afile> <afile>:r
"  autocmd FileAppendPost                *.bz2 !bzip2 -9 --repetitive-best <afile>:r

augroup END
endif


