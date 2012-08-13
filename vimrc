set nu
set tabstop=4
set shiftwidth=4
set cindent
set showtabline=2
set wildmenu "使能Tab补全，注：edit(e) 文件名能补全，open(o) 文件名不能补全
set ic "使得查找时不区分大小写，另：set noic（默认），区分大小写

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936 "解决文件乱码问题。:set fileencoding?能猜出当前文件的编码。

":set fileformat? 显示当前文件格式是unix风格（换行结尾），还是dos风格（回车换行结尾）
":set fileformats?  显示所有设定的文件格式
"注：vim打开dos风格的文件，不会有^M这样的字样。编辑保存后vim会继续保持dos风格。


filetype on

map <F5> :call CompileRunGcc()<CR>
function CompileRunGcc()
	exec "!clear"
	exec "w"
	if &filetype == 'c'
		exec "!gcc -g -O0 % -o %<"
	elseif &filetype == 'cpp'
		exec "!g++ -g -O0 % -o %<"
	endif
	exec "!./%<"
endfunction


