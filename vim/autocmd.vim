
"
" Autoload commands
"


"augroup html
  " Remove all html autocommands
 " au!

"  au BufRead *.shtml,*.html,*.htm set tw=80 formatoptions=tcqro2 autoindent

  " Show default HTML file when new.
"  au BufNewFile *.shtml,*.html,*.htm 0r /etc/vim/skeleton.html

  " Add HTML menu
"  au BufEnter *.shtml,*.html,*.htm so /etc/vim/html.vim
"  au BufLeave *.shtml,*.html,*.htm so /etc/vim/unhtml.vim

  " Setup browser to display when writing files
  "au BufWritePost *.shtml,*.html,*.htm !netscape -remote 'openFile(%:p)'
"augroup END


"augroup cprog
  " Remove all cprog autocommands
"  au!

"  au BufRead *.cpp,*.c,*.h set formatoptions=croq sm sw=4 sts=4 cindent comments=sr:/*,mb:*,el:*/,:// | if file_readable("tags.vim") | so tags.vim | endif
"augroup END


"augroup perl
  " Remove all perl autocommands
"  au!

"  au BufReadPre *.pl,*.pm set formatoptions=croq sm sw=4 sts=4 cindent cinkeys='0{,0},!^F,o,O,e' " tags=./tags,tags,~/devel/tags,~/devel/CVS/bin/contrib/tags
  " au BufReadPost */CVS/lib/perl5/netapp/*.pm so ~/devel/CVS/bin/contrib/tags.vim
  " The default syntax highlight syncing scheme is too slow (which makes
  " backwards scrolling very slow), so we reset it to something faster
  " au BufReadPost *.pm,*.pl syntax sync clear | syntax sync lines=30
"augroup END


"augroup python
  " Remove all python autocommands
"  au!

"  au BufReadPre *.py set formatoptions=croq sm sw=4 sts=4 cindent cinkeys='0{,0},!^F,o,O,e'
"augroup END

au BufNewFile,BufRead *.aidl set filetype=java

augroup ruby
	au!
	" Most ruby projects seem to use two-space, no-tab indentation
	autocmd BufRead        *.rb set sts=2 sw=2 ts=8 et
augroup END

augroup adruino
	au!
	" Most ruby projects seem to use two-space, no-tab indentation
	autocmd BufRead        *.ino set sts=2 sw=2 ts=8 et cindent
augroup END

augroup contiki
	au!

	" Contiki uses two-space, no-tab indentation.
	autocmd BufRead,BufNewFile        */contiki*/* set sts=2 sw=2 ts=8 et
augroup END

augroup silabs
	au!

	" silabs uses two-space, no-tab indentation.
	autocmd BufRead,BufNewFile        */silabs*/* set sts=2 sw=2 ts=8 et
augroup END

augroup yml
	au!

	" yml tends to use four-space, no-tab indentation.
	autocmd BufRead,BufNewFile        *.yml set sts=4 sw=4 ts=4 et
augroup END

augroup openthread
	au!

	" Nest Labs tends to use four-space, no-tab indentation.
	autocmd BufRead,BufNewFile        */openthread/* set sts=4 sw=4 ts=4 et
augroup END

augroup marble
	au!

	" Nest Labs tends to use four-space, no-tab indentation.
	autocmd BufRead,BufNewFile        */marble/* set sts=4 sw=4 ts=4 et
augroup END

augroup nestlabs
	au!

	" Nest Labs tends to use four-space, no-tab indentation.
	autocmd BufRead,BufNewFile        */nestlabs/* set sts=4 sw=4 ts=4 et
	autocmd BufRead,BufNewFile        */nest/* set sts=4 sw=4 ts=4 et
augroup END

augroup android
	au!

	autocmd BufRead,BufNewFile        */android/* set sts=4 sw=4 ts=4 et
	autocmd BufRead,BufNewFile        */oc-iot-dev/* set sts=4 sw=4 ts=4 et
	autocmd BufRead,BufNewFile        */oc-mr1-iot-dev/* set sts=4 sw=4 ts=4 et

	" Use two-character tabs for these paths
	autocmd BufRead,BufNewFile        */hardware/interfaces/*.cpp set sts=2 sw=2 ts=2 et
	autocmd BufRead,BufNewFile        */hardware/interfaces/*.h set sts=2 sw=2 ts=2 et
	autocmd BufRead,BufNewFile        */system/peripheralmanager/*.cpp set sts=2 sw=2 ts=2 et
	autocmd BufRead,BufNewFile        */system/peripheralmanager/*.h set sts=2 sw=2 ts=2 et
augroup END

augroup wpantund
	au!

	autocmd BufRead,BufNewFile        */wpantund/* set sts=4 sw=4 ts=4 noet
augroup END

augroup libfreefare
   au!

   autocmd BufRead,BufNewFile        */libfreefare/* set sw=4 ts=8 noet cinoptions=t0(0:0
augroup END

augroup makefiles
	au!

	" Makefiles require tabs!
	autocmd BufRead,BufNewFile        */[Mm]akefile set sts=4 sw=4 ts=4 noet
	autocmd BufRead,BufNewFile        */[Mm]akefile.* set sts=4 sw=4 ts=4 noet
augroup END

"augroup shell
  " Remove all shell autocommands
"  au!

"  au BufRead profile,bashrc,.profile,.bashrc,.bash_*,.kshrc,*.sh,*.ksh,*.bash,*.env,.login,.cshrc,*.csh,*.tcsh,.z*,zsh*,zlog* set formatoptions=croq sm sw=4 sts=4 cindent cinkeys='0{,0},!^F,o,O,e'
"augroup END


" Also, support editing of gzip-compressed files.
" This is also used when loading the compressed helpfiles.
augroup gzip
  " Remove all gzip autocommands
  au!

  " Enable editing of gzipped files
  "	  read:	set binary mode before reading the file
  "		uncompress text in buffer after reading
  "	 write:	compress file after writing
  "	append:	uncompress file, append, compress file
  autocmd BufReadPre,FileReadPre	*.gz set bin
  autocmd BufReadPre,FileReadPre	*.gz let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost	*.gz '[,']!gunzip
  autocmd BufReadPost,FileReadPost	*.gz set nobin
  autocmd BufReadPost,FileReadPost	*.gz let &ch = ch_save|unlet ch_save
  " Old vims use this
  "autocmd BufReadPost,FileReadPost	*.gz execute ":doautocmd BufReadPost " . %:r
  autocmd BufReadPost,FileReadPost	*.gz execute ":doautocmd BufReadPost " . expand("%:r")

  autocmd BufWritePost,FileWritePost	*.gz !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost	*.gz !gzip <afile>:r

  autocmd FileAppendPre			*.gz !gunzip <afile>
  autocmd FileAppendPre			*.gz !mv <afile>:r <afile>
  autocmd FileAppendPost		*.gz !mv <afile> <afile>:r
  autocmd FileAppendPost		*.gz !gzip <afile>:r
augroup END

augroup bzip2
  " Remove all bzip2 autocommands
  au!

  " Enable editing of bzipped files
  "       read: set binary mode before reading the file
  "             uncompress text in buffer after reading
  "      write: compress file after writing
  "     append: uncompress file, append, compress file
  autocmd BufReadPre,FileReadPre        *.bz2 set bin
  autocmd BufReadPre,FileReadPre        *.bz2 let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost      *.bz2 set cmdheight=2|'[,']!bunzip2
  " Old vims use this
  "autocmd BufReadPost,FileReadPost      *.bz2 set cmdheight=1 nobin|execute ":doautocmd BufReadPost " . %:r
  autocmd BufReadPost,FileReadPost      *.bz2 set cmdheight=1 nobin|execute ":doautocmd BufReadPost " . expand("%:r")
  autocmd BufReadPost,FileReadPost      *.bz2 let &ch = ch_save|unlet ch_save

  autocmd BufWritePost,FileWritePost    *.bz2 !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost    *.bz2 !bzip2 <afile>:r

  autocmd FileAppendPre                 *.bz2 !bunzip2 <afile>
  autocmd FileAppendPre                 *.bz2 !mv <afile>:r <afile>
  autocmd FileAppendPost                *.bz2 !mv <afile> <afile>:r
  autocmd FileAppendPost                *.bz2 !bzip2 -9 --repetitive-best <afile>:r
augroup END
