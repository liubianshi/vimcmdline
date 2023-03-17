" 扩展 jalvesaq/vimcmdline 的语言覆盖范围
" 增加对 Stata 的支持
" 文件以软链接的形式放至 ~/.local/share/nvim/plugged/vimcmdline/ftplugin/
" 参考 https://github.com/jalvesaq/vimcmdline/blob/master/ftplugin/sh_cmdline.vim

" Ensure that plugin/vimcmdline.vim was sourced
if !exists("g:cmdline_job")
    runtime plugin/vimcmdline.vim
endif

function! StataSourceLines(lines)
    call writefile(a:lines, g:cmdline_tmp_dir . "/lines.do")
    call cmdline#SendCmd("do " . g:cmdline_tmp_dir . "/lines.do")
endfunction

function! StataLineSend()
    let line = substitute(getline("."), "[ \t ]\/[\/\*].*$", "", "")
    call cmdline#SendCmd(line)
endfunction

let b:cmdline_nl = "\n"
let b:cmdline_app = "stata-se"
let b:cmdline_quit_cmd = "exit, clear"
let b:cmdline_source_fun = function("StataSourceLines")
let b:cmdline_send = function("StataLineSend")
let b:cmdline_send_empty = 0
let b:cmdline_filetype = "stata"

if !exists("g:cmdline_map_start")
    let g:cmdline_map_start = "<LocalLeaderls>"
endif
exe 'nmap <buffer><silent> ' . g:cmdline_map_start . ' :call VimCmdLineStartApp()<CR>'

call cmdline#StartApp("stata")
