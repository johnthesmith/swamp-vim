"*******************************************************************************
" Still Swamp nvim config
" 2018-2026
" Licensed under the MIT License
"
" Goals
"   Minimalism  - single init.vim, zero plugins (not a nano, but with clipboard)
"   Portability - ssh, low-resource systems
"   Simplicity  - gui-like editing
"
" Features
"   Insert-first workflow
"   Esc toggles Insert/Normal
"   Ctrl-based shortcuts
"   Smart indentation
"   Filetype-aware comments
"   AI integration
"   Trailing whitespace highlighting
"   Keyboard layout independent for cyr
"
" Installation
"   Install neovim
"   Copy this file to .config/nvim/init.vim



"*******************************************************************************
" ALL COMBINATIONS
" Key    ASCII  Input       Normal      Visual
" ------------------------------------------------------------------------------
" ESC           NormalMode  InputMode   NormalMode
" Alt+1         -           -           ai-cli-replace
" Alt+2         -           -           ai-cli-buffer
" Alt+3         SnglComment -           SnglComment
" Alt+4         Brackets    Brackets    -
" Ctrl+A 1      Select all  Auto inc    Select all
" Ctrl+B 2      -           -           -
" Ctrl+C 3      Copy line   -           Copy lines
" Ctrl+D 4      Del line    -           Del lines
" Ctrl+E 5      Cmd mode    Cmd mode    Cmd mode    Exec command
" Ctrl+F 6      Search      Search      Search
" Ctrl+G 7      Grep        Grep        Grep
" Ctrl+H 8      X           X           X           (RESERVED - Backspace)
" Ctrl+I 9      X           X           X           (RESERVED - Tab)
" Ctrl+J 10     -           -           Justify
" Ctrl+K 11     -           -           -
" Ctrl+L 12     -           -           -
" Ctrl+M 13     X           X           X           (RESERVED - Enter)
" Ctrl+N 14     Next        Next        Next
" Ctrl+O 15     Openfile    Openfile    -
" Ctrl+P 16     Prev        Prev        Prev
" Ctrl+Q 17     Quit        Quit        Quit
" Ctrl+R 18     Redo        Redo        Redo
" Ctrl+S 19     Save        Save        Save
" Ctrl+T 20     Clearsearch Clearsearch Clearsearch
" Ctrl+U 21     -           -           -
" Ctrl+V 22     Paste       Block       Paste
" Ctrl+W 23     -           -           -
" Ctrl+X 24     Cut         Auto dec    Cut
" Ctrl+Y 25     -           -           FilterSelec
" Ctrl+Z 26     Undo        Undo        Undo
" Ctrl+[ 27     X           X           X           (RESERVED - Esc)
" Ctrl+\ 28     X           X           X           (RESERVED - Backslash)
" Ctrl+] 29     X           X           X           (RESERVED - ])
" Ctrl+^ 30     X           X           X           (RESERVED - ^)
" Ctrl+_ 31     X           X           X           (RESERVED - _)



"*******************************************************************************
" Configuration
"*******************************************************************************

" Set insert mode from start
startinsert

" en
language C

set encoding=utf-8
set fileencoding=utf-8

" Status line
set noshowmode
set statusline=[%{mode()}]\ %cx%l\ %f


" Fund case unsensivity
set ignorecase
set smartcase

" Blink cursor mode
set guicursor=a:blinkon1

set termguicolors

" Always show mode in the bottom line
" set showmode
set laststatus=2

" Enable syntax hilight
syntax on

" Mouse disable
set mouse=

" Hilight hang space
autocmd BufEnter * highlight TrailingWhitespace ctermbg=red guibg=red
autocmd BufEnter * call matchadd( 'TrailingWhitespace', '\s\+$' )

" Hilight hang tab
autocmd BufEnter * highlight TabCharacter ctermbg=blue guibg=blue
autocmd BufEnter * call matchadd('TabCharacter', '\t')

" Enable number line
set number
" set relativenumber

" Show 80-char limit boundary (line after column 80)
"        1         2         3         4         5         6         7         8
" 345678901234567890123456789012345678901234567890123456789012345678901234567890
set colorcolumn=81

" use system buffer
set clipboard=unnamedplus

"
set keymodel=startsel,stopsel

" Selection exclude cursor
set selection=exclusive

" wrap long lines
set wrap
set linebreak
set breakindent
set showbreak=#

" Coloscheme
set textwidth=80

set virtualedit=onemore

" disable brackets highlight
set noshowmatch
set matchtime=0
let g:loaded_matchparen = 1



"*******************************************************************************
" Indent settings

filetype indent off
filetype plugin indent off


" Disable smart indent
set nosmartindent
set nocindent
set indentexpr=

" Disable autoformat
set formatoptions=
set wrapmargin=0

" Remove all indent triggers
set indentkeys=
set noautoindent

" Default indent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Yaml indent
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 expandtab



"*******************************************************************************
" Vocab

iabbr teh the
iabbr funciton function
iabbr retrun return



"*******************************************************************************
" Keys

inoremap <silent> <CR> <C-o>:call Enter()<CR>
autocmd FileType netrw inoremap <buffer> <CR> <CR>
autocmd FileType netrw setlocal nomodifiable

"*******************************************************************************
" File

" Esc - trigger switch between Insert and Normal mode
inoremap <Esc> <C-\><C-n>
nnoremap <Esc> i

" Quit
" en
inoremap <C-q> <C-o>:confirm q<CR>
nnoremap <C-q> :confirm q<CR>
vnoremap <C-q> <Esc>:confirm q<CR>
" ru
inoremap <C-й> <C-o>:confirm q<CR>
nnoremap <C-й> :confirm q<CR>
vnoremap <C-й> <Esc>:confirm q<CR>

" Save
" en
nnoremap <C-s> :call SaveFile()<CR>
inoremap <C-s> <C-o>:call SaveFile()<CR>
vnoremap <C-s> <C-o>:call SaveFile()<CR>
" ru
nnoremap <C-ы> :call SaveFile()<CR>
inoremap <C-ы> <C-o>:call SaveFile()<CR>
vnoremap <C-ы> <C-o>:call SaveFile()<CR>

" Open file on Ctrl+O
" en
nnoremap <C-o> :call OpenFile()<CR>
inoremap <C-o> <C-o>:call OpenFile()<CR>
" ru
nnoremap <C-щ> :call OpenFile()<CR>
inoremap <C-щ> <C-o>:call OpenFile()<CR>



"*******************************************************************************
" Format


" Justify
" en
vnoremap <C-j> :<C-u>call Justify()<CR>

" ru
inoremap <C-о> <C-o>:call Justify()<CR>
vnoremap <C-о> :call Justify()<CR>

" Smart tab
inoremap <Tab> <C-o>:call TabForInputMode()<CR>
vnoremap <Tab> :call TabForVisualMode()<CR>

" Smart untab
inoremap <S-Tab> <C-o>:call UntabForInputMode()<CR>
vnoremap <S-Tab> :call UntabForVisualMode()<CR>

" Cmments control
inoremap <M-3> <C-o>:call ToggleComment()<CR>
vnoremap <M-3> :call ToggleComment()<CR>



"*******************************************************************************
" Edit

" Undo
" en
inoremap <C-z> <C-o>u
vnoremap <C-z> u
nnoremap <C-z> u
" ru
inoremap <C-я> <C-o>u
vnoremap <C-я> u
nnoremap <C-я> u



" Redo
" en
inoremap <C-r> <C-o><C-r>
vnoremap <C-r> <Esc><C-r>
nnoremap <C-r> <C-r>
" ru
inoremap <C-к> <C-o><C-r>
vnoremap <C-к> <Esc><C-r>
nnoremap <C-к> <C-r>



" Delete
" en
inoremap <C-d> <C-o>"_dd
vnoremap <C-d> d
" nnoremap <C-d> dd
" ru
inoremap <C-в> <C-o>"_dd
vnoremap <C-в> d
" nnoremap <C-в> dd



" Cut
" en
inoremap <C-x> <C-o>:call CutSmartLine()<CR>
vnoremap <C-x> :<C-u>call CutSmart()<CR>
" ru
inoremap <C-ч> <C-o>:call CutSmartLine()<CR>
vnoremap <C-ч> :<C-u>call CutSmart()<CR>



" Copy
" en
inoremap <C-c> <C-o>:call CopySmartLine()<CR>
vnoremap <C-c> :<C-u>call CopySmart()<CR>
" ru
inoremap <C-c> <C-o>:call CopySmartLine()<CR>
vnoremap <C-с> :<C-u>call CopySmart()<CR>



" Paste
" en
nnoremap <C-v> :<C-u>execute "normal! i" . PasteSmart()<CR>
inoremap <C-v> <C-r>=PasteSmart()<CR>
vnoremap <C-v> "_dP
" ru
nnoremap <C-м> :<C-u>execute "normal! i" . PasteSmart()<CR>
inoremap <C-м> <C-r>=PasteSmart()<CR>
vnoremap <C-м> "_dP



" Select all
" en
inoremap <C-a> <C-o>:call SelectAll()<CR>
vnoremap <C-a> <Esc>:call SelectAll()<CR>
" ru
inoremap <C-ф> <C-o>:call SelectAll()<CR>
vnoremap <C-ф> <Esc>:call SelectAll()<CR>



"*******************************************************************************
" Search control

" Search
" en
nnoremap <C-f> /
inoremap <C-f> <C-o>/
" ru
nnoremap <C-а> /
inoremap <C-а> <C-o>/

" Clear search
" en
nnoremap <C-t> :nohlsearch<CR>
inoremap <C-t> <C-o>:nohlsearch<CR>
" ru
nnoremap <C-е> :nohlsearch<CR>
inoremap <C-е> <C-o>:nohlsearch<CR>

" Ctrl+N - next match
" en
nnoremap <C-n> n
inoremap <C-n> <C-o>n
vnoremap <C-n> <Esc>n
" ru
nnoremap <C-т> n
inoremap <C-т> <C-o>n
vnoremap <C-т> <Esc>n

" Ctrl+P - previous match
" en
nnoremap <C-p> N
inoremap <C-p> <C-o>N
vnoremap <C-p> <Esc>N
" ru
nnoremap <C-з> N
inoremap <C-з> <C-o>N
vnoremap <C-з> <Esc>N


" Barckets jump like nano
nnoremap <M-4> %
inoremap <M-4> <C-o>%

"*******************************************************************************
" Commands

" Command mode
" en
nnoremap <C-e> :
inoremap <C-e> <C-o>:
vnoremap <C-e> <Esc>:
" ru
nnoremap <C-у> :
inoremap <C-у> <C-o>:
vnoremap <C-у> <Esc>:



"*******************************************************************************
" External utilites

" cli-ai
" all
vnoremap <M-1> :<C-u>call Ai("paste")<CR>
nnoremap <M-1> :call Ai("paste")<CR>
inoremap <M-1> <C-o>:call Ai("paste")<CR>

" all
vnoremap <M-2> :<C-u>call Ai("copy")<CR>
nnoremap <M-2> :call Ai("copy")<CR>
inoremap <M-2> <C-o>:call Ai("copy")<CR>


" grep
" en
nnoremap <C-g> :call Grep()<CR>
inoremap <C-g> <C-o>:call Grep()<CR>
" ru
nnoremap <C-п> :call Grep()<CR>
inoremap <C-п> <C-o>:call Grep()<CR>

" en
vnoremap <C-y> :<C-u>call FilterSelection()<CR>
" ru
vnoremap <C-н> :<C-u>call FilterSelection()<CR>



"*******************************************************************************
" Colors
"*******************************************************************************

highlight clear
let g:colors_name = "bw"

" Normal text
hi Normal ctermbg=black ctermfg=255 guibg=#000000 guifg=#eeeeee

" Comments
hi Comment ctermfg=248 guifg=#a8a8a8

" Line number
hi LineNr ctermbg=242 guibg=#7c7c7c ctermfg=black guifg=#000000
hi SignColumn ctermbg=235 guibg=#262626

" Right column
hi ColorColumn ctermbg=236 guibg=#303030

" Structure
hi Statement ctermfg=178 guifg=#d7af5f
hi Keyword ctermfg=178 guifg=#d7af5f
hi Function ctermfg=178 guifg=#d7af5f

" String values
hi String ctermfg=220 guifg=#ffd700

" Datatype
hi Type ctermfg=white guifg=#ffffff gui=bold cterm=bold

" Selection
hi Visual ctermbg=darkgray guibg=#555555

" End of file
hi NonText ctermfg=gray guifg=#808080
hi EndOfBuffer ctermfg=gray guifg=#808080

" Identifer
hi Identifier ctermfg=green guifg=#8cb82a


hi Structure ctermfg=white guifg=#ffffff gui=bold cterm=bold

hi Self ctermfg=white guifg=#ffffff
hi This ctermfg=white guifg=#ffffff

hi Macro ctermfg=red guifg=#ff0000

" Constatns
hi Constant ctermfg=255 guifg=#eeeeee cterm=bold gui=bold

"  Menu
hi Pmenu ctermbg=250 guibg=#bcbcbc ctermfg=black guifg=#000000
hi PmenuSel ctermbg=245 guibg=#8a8a8a ctermfg=white guifg=#ffffff

" Include lines
hi Include ctermfg=white guifg=#ffffff
hi PreProc ctermfg=white guifg=#ffffff

" Todo mark
hi Todo ctermfg=cyan guifg=#00ffff ctermbg=NONE guibg=NONE

" Message
hi Question ctermfg=white guifg=#ffffff
hi MoreMsg ctermfg=white guifg=#ffffff
hi WarningMsg ctermfg=yellow guifg=#ffff00
hi ErrorMsg ctermfg=red ctermbg=black guifg=#ff0000 guibg=#000000

" Current pattern under cursor
hi Search ctermbg=255 ctermfg=black guibg=#d0d0d0 guifg=#000000

" Other patterns
hi IncSearch ctermbg=250 ctermfg=black guibg=#ffffff guifg=#000000



"*******************************************************************************
" Functions
"*******************************************************************************


" ******************************************************************************
" Swamp SDK for vim



" Set curor to line and char position
function! MoveCurTo( line_index, char_col )
    let byte_col = byteidx( getline( a:line_index ), a:char_col - 1 ) + 1
    call cursor( a:line_index, byte_col )
endfunction



" Return current line index
function! GetLineIndex()
   return line( '.' )
endfunction



" Return current char column (not byte)
function! GetCharCol()
    return charcol( '.' )
endfunction



" Return current line content
function! GetLineContent()
   return getline( '.' )
endfunction



" Return selected text and its bounds.
" Warning: call only from Visual mode.function!
function! GetSelection( line )
    silent normal! gv"zy
    let text = getreg('z')

    let start_line = line("'<")
    let start_char = charcol("'<")
    let end_line   = line("'>")
    let end_char   = charcol("'>")

    if a:line
        let start_char = 1
        let end_char = strchars(getline(end_line)) + 1

        let lines = getline(start_line, end_line)
        let text = join( lines, "\n" )
    endif

"     if end_char == 1
"         let end_line -= 1
"     endif

    return [ text, start_line, start_char, end_line, end_char ]
endfunction



" Restore visual selection.
function! SetSelection( start_line, start_char, end_line, end_char )
    let end_line = a:end_line

"     if a:end_char == 1
"         let end_line += 1
"     endif

    call MoveCurTo( a:start_line, a:start_char )
    normal! v
    call MoveCurTo( end_line, a:end_char )
endfunction



" Insert text at line and character position.
function! InsertContent( text, start_line, start_char )
    let before = strcharpart( getline( a:start_line ), 0, a:start_char - 1 )
    let after = strcharpart( getline( a:start_line ), a:start_char - 1 )

    let lines = split( a:text, "\n", 1 )

    let lines[0] = before . lines[0]
    let lines[-1] = lines[-1] . after

    call setline( a:start_line, lines[0] )

    if len( lines ) > 1
        call append( a:start_line, lines[1:] )
    endif
endfunction


" Delete current line
function! DeleteLine()
   normal! dd
endfunction



" Delete text by coordinates.
function! DeleteContent( start_line, start_char, end_line, end_char )
    let before = strcharpart( getline( a:start_line ), 0, a:start_char - 1 )

"     if a:end_char == 1
"         let after = ''
"     else
        let after = strcharpart( getline( a:end_line ), a:end_char - 1 )
"     endif

    call setline( a:start_line, before . after )

    if a:end_line > a:start_line
        silent execute ( a:start_line + 1 ) . ',' . a:end_line . 'delete _'
    endif
endfunction


" Replace content
function! ReplaceContent( text, start_line, start_char, end_line, end_char )
    call DeleteContent( a:start_line, a:start_char, a:end_line, a:end_char )
    call InsertContent( a:text, a:start_line, a:start_char )
endfunction



" Put text to buffer
function SetBuffer( text )
    if has( "clipboard" )
        let @+ = a:text
    else
        let clipfile = expand( "~/.vimclip" )
        call writefile([ a:text ], clipfile )
        call system( "chmod 600 " . clipfile )
    endif
endfunction



" Return justify text
" text - content
" left - left tabulator size
" max_len - max charas in line
function! JustifyText( text, left, max_len )
    " Build lexemes
    let lexemes = split( a:text, ' ' )

    " Define lines
    let lines = []

    let line_length = 0
    let current_line = []

    let i = 0
    let total = len( lexemes )
    while i < total
        let word = lexemes[ i ]
        let word_length = strchars( word )

        if line_length + word_length + 1 <= a:max_len - a:left || line_length == 0
            call add( current_line, word )
            let line_length += word_length + 1
            let i += 1
        else
            call add( lines, current_line )
            let current_line = []
            let line_length = 0
        endif
    endwhile

    if !empty( current_line )
        call add( lines, current_line )
    endif


    let complete_lines = []
    let left_tab = repeat(' ', a:left )
    for line in lines
        call add( complete_lines, left_tab . join( line, ' ' ))
    endfor

    return join( complete_lines, "\n" )
endfunction


"*******************************************************************************

function! SelectAll()
    normal! ggVG
endfunction



"*******************************************************************************
" Tab and line control

" Return tab size and typ char from ext
function! GetTabInfo()
    if &filetype =~ 'yaml\|python'
        return [2, ' ']
    else
        return [4, ' ']
    endif
endfunction



function! CalcTabOffset( pos, tab_size )
    let offset = a:pos % a:tab_size
    if offset == a:tab_size
        return a:tab_size
    else
        return a:tab_size - offset
    endif
endfunction



function! CalcTabOffsetPrev( pos, tab_size )
    let offset = a:pos % a:tab_size
    if offset == 0
        return -a:tab_size
    else
        return -offset
    endif
endfunction



function! FindFirstNonTab( line, tab_char )
    let pos = 0
    while pos < strchars( a:line )
        if strcharpart( a:line, pos, 1 ) != a:tab_char
            return pos
        endif
        let pos += 1
    endwhile
    return -1
endfunction




" Tab indent to next tab boundary for input mode
function! TabForInputMode() range
    " Get tab char
    let[ tab_size, tab_char ] = GetTabInfo()
    let line = GetLineContent()
    let col = GetCharCol() - 1
    " Get string before cursor
    let before = strcharpart( line, 0, col )
    " Get string after cursor
    let after = strcharpart( line, col )
    " Calc offset
    let offset = CalcTabOffset( col, tab_size )
    " Build new line
    let new_line = before . repeat( tab_char, offset ) . after
    " Set line in to text
    call setline( '.', new_line )
    " Move cursor to new tab bosition
    call MoveCurTo( GetLineIndex(), col + offset + 1 )
endfunction



" Untab indent for input mode
function! UntabForInputMode() range
    " Get tab char
    let[ tab_size, tab_char ] = GetTabInfo()
    let line = GetLineContent()
    let col = GetCharCol() - 1
    let line_index = GetLineIndex()
    let first_non_tab = FindFirstNonTab( line, tab_char )

    let indent = (first_non_tab == -1) ? strchars( line ) : first_non_tab

    let offset = CalcTabOffsetPrev( indent, tab_size )

    let new_indent = max([0, indent + offset])
    if first_non_tab == -1
        let new_line = repeat(tab_char, new_indent)
    else
        let new_line = repeat(tab_char, new_indent) . strpart(line, first_non_tab)
    endif
    call setline( line_index, new_line)
endfunction



" Tab: smart indent to next tab boundary.
function! TabForVisualMode() range
    " Get tab char
    let[ tab_size, tab_char ] = GetTabInfo()

    " Get selected lines
    let [ text, start_line, start_col, end_line, end_col ] = GetSelection( 1 )

    let lines = split( text, "\n", 1 )

    "  Loop for each line
    if !empty( lines )
        for i in range( 0, len( lines ) - 1 )
            let line = lines[ i ]
            " Shift nonempty line
            if line != ""
                let lines[ i ] = repeat( tab_char, tab_size ) . line
            endif
        endfor
    endif

    call ReplaceContent( join( lines, "\n" ), start_line, start_col, end_line, end_col )

    " Restore selection
    call SetSelection( start_line, start_col, end_line, end_col )
endfunction




" Shift-Tab: unindent to previous tab boundary.
function! UntabForVisualMode() range
    " Get selected lines
    let [ text, start_line, start_col, end_line, end_col ] = GetSelection( 1 )
    " Get tab char
    let[ tab_size, tab_char ] = GetTabInfo()

    let lines = split( text, "\n", 1 )

    "  Loop for each line
    if !empty( lines )
        for i in range( 0, len( lines ) - 1 )
            let line = lines[ i ]
            let pos = FindFirstNonTab( line, tab_char )
            if pos > tab_size || pos == -1
                let pos = tab_size
            endif
            let lines[ i ] = strcharpart( line, pos, strchars( line ) - pos )
        endfor
    endif

    call ReplaceContent( join( lines, "\n" ), start_line, start_col, end_line, end_col )

    " Restore selection
    call SetSelection( start_line, start_col, end_line, end_col )
endfunction



" Enter control
function! Enter()
    let line = getline('.')
    let pos = charcol('.') - 1

    let before = strcharpart( line, 0, pos )
    let after  = strcharpart( line, pos )

    " Preserve indentation up to cursor.
    let indent = matchstr(before, '^\s*')

    call setline('.', before)
    call append(line('.'), indent . after)

    call cursor(line('.') + 1, strchars(indent) + 1)

    startinsert
endfunction




"*******************************************************************************
" Comments



" Get comment prefix/suffix based on filetype.
" Returns [prefix, suffix] for current filetype.
" Defaults to '# ' for unknown filetypes.
function! GetCommentChars()
    let ext = expand('%:e')
    if ext == 'rs'
        return ['// ', '']
    elseif ext =~ 'c\|cpp\|h\|hpp\|cc\|cxx'
        return ['// ', '']
    elseif ext == 'py'
        return ['# ', '']
    elseif ext == 'lua'
        return ['-- ', '']
    elseif ext == 'vim'
        return ['" ', '']
    elseif ext =~ 'sh\|bash\|zsh\|yaml\|yml\|conf'
        return ['# ', '']
    elseif ext =~ 'html\|htm\|xml\|vue\|svelte\|md\|markdown'
        return ['<!-- ', ' -->']
    else
        return ['// ', '']
    endif
endfunction



" Toggle single-line comments
function! ToggleComment() range
    let [pref, suff] = GetCommentChars()

    let epref = '^' . escape(pref, '/')
    let esuff = escape(suff, '/') . '$'

    let is_commented = getline(a:firstline) =~ epref
                \ && getline(a:firstline) =~ esuff

    if a:firstline != a:lastline
        let start_pos = getpos("'<")
        let end_pos = getpos("'>")

        let last = a:lastline
"         if col("'>") == 1
"             let last -= 1
"         endif

        for i in range(a:firstline, last)
            let line = getline(i)

            if is_commented
                let line = substitute(line, epref, '', '')
                let line = substitute(line, esuff, '', '')
            else
                let line = pref . line . suff
            endif

            call setline(i, line)
        endfor

        call setpos("'<", start_pos)
        call setpos("'>", end_pos)

        normal! gv
    else
        let line = getline('.')

        if is_commented
            let line = substitute(line, epref, '', '')
            let line = substitute(line, esuff, '', '')
        else
            let line = pref . line . suff
        endif

        call setline('.', line)

        if !is_commented && empty(getline('.')[(strchars(pref)):])
            call cursor(line('.'), strchars(pref) + 1)
        endif
    endif
endfunction


"*******************************************************************************
" File



" Save with filename prompt
function! SaveFile()
    if expand( '%' ) == ''
        let filename = input( 'Save as: ', '', 'file' )
        if filename != ''
            execute 'write ' . fnameescape( filename )
        endif
    else
        write
    endif
endfunction



" Work with ai-cli
" https://github.com/johnthesmith/ai-cli
function! Ai(type)
    " Get selected lines
    let [ text, start_line, start_col, end_line, end_col ] = GetSelection( 1 )
    let args = input( "ai " . a:type. "> " )
    let result = system( 'ai --color=false --status=false ' . args, text )
    if a:type == 'copy'
        echo "\n"
        call SetBuffer( result )
        echo result
    elseif a:type == 'paste'
        call ReplaceContent(result, start_line, start_col, end_line, end_col )
    endif
endfunction



" Grep
function! Grep()
    let pattern = input( 'grep: ', expand( '<cword>' ))
    if empty( pattern )
        return
    endif

    if executable( 'git' )
        let root = systemlist( 'git rev-parse --show-toplevel' )[ 0 ]
        if v:shell_error == 0
            execute 'lcd ' . fnameescape(root)
            setlocal grepprg=git\ grep\ -n\ $*
        else
            setlocal grepprg=grep\ -RnH\ $*
        endif
    else
        setlocal grepprg=grep\ -RinH\ $*
    endif

    silent execute 'grep! ' . shellescape( pattern )
    copen
endfunction



" Filter selection
function! FilterSelection()
    call inputsave()
    let cmd = input( '!: ' )
    call inputrestore()

    if empty(cmd)
        return
    endif

    silent execute "'<,'>!" . cmd
endfunction



" Copy
function! CopySmart() range
    normal! gv"zy
    let text = getreg( "z" )
    call SetBuffer( text )
    normal! gv
endfunction



" Copy current line in to buffer
function! CopySmartLine()
    call SetBuffer( GetLineContent())
    echo "Line copied"
endfunction



" Cut
function! CutSmart() range
    call CopySmart()
    normal! gvd
endfunction



" Cut one line in input mode
function! CutSmartLine()
    call CopySmartLine()
    call DeleteLine()
endfunction



" Paste
function! PasteSmart()
    " Try system buffer
    if has( "clipboard" )
        try
            let content = getreg( '+' )
            if !empty( content )
                return content
            endif
        catch
        endtry
    endif

    " Try file
    let clipfile = expand( "~/.vimclip" )
    if filereadable(l:clipfile)
    try
        let lines = readfile( clipfile, "", 1 )
        if !empty( lines )
            return lines[0]
        endif
        catch
        endtry
    endif

    " Use register
    return getreg('"')
endfunction



" Open file
function! OpenFile()
    Ex
    stopinsert
endfunction



" Allign text with start tab size
function! Justify()
    " Get tab length
    let tab = matchstr(getline("'<"), '^\s*')
    " Get selected lines
    let[ text, start_line, start_col, end_line, end_col ] = GetSelection( 0 )

    " Replace enter to  space
    let text = substitute(text, '\n', ' ', 'g')

    " Remove dbl space
    while text =~ '  '
        let text = substitute( text, '  ', ' ', 'g' )
    endwhile

    let result = JustifyText( text, strchars( tab ), 80 )

    call ReplaceContent(result, start_line, start_col, end_line, end_col)
endfunction

