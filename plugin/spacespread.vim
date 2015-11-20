fun! SpaceSpread(normal,positive)
	let cur_pos = getpos('.')
    " if getline('.')[cur_pos[2]-1] == '(' && getline('.')[cur_pos[2]] == ')'
        " echo 'got it!!!'
        " normal a
    " endif
    if a:normal
        normal h
    endif
    if a:positive

        normal f)i
        normal %a
        call setpos('.',cur_pos)
        if !a:normal
            normal l
        endif
        normal l
    else

        normal f)h
        if getline('.')[col('.')-1] == ' '
            normal x
            normal %l
            " echo col('.')
            if getline('.')[col('.')-1] == ' '
                normal x
            endif
        else
            call setpos('.',cur_pos)
            if !a:normal
                normal l
            endif
            return
        endif
        call setpos('.',cur_pos)
        if a:normal && !a:positive
            normal h
        endif
    endif
endfun

if has('unix')
	set <M-l>=l
	set <M-h>=h
endif

nmap <silent><M-.> :call SpaceSpread(1,1)<cr>
nmap <silent><M-,> :call SpaceSpread(1,0)<cr>

imap <silent><M-.> <ESC>:call SpaceSpread(0,1)<cr><Left>i
imap <silent><M-,> <ESC>:call SpaceSpread(0,0)<cr><Left>i
" (  <esc>hi(  hi))
" (      h)
" " " " " " " " " " " " " " " " " " " (h (woei>)(        ())(UUUUUUU))
" " " " " " " " " " " " ((woei>)(              ()      )(UUUUUUU))
" " " " " " " " " " " " (           (woei>)(        ())(UUUUUUU) )
" " " " " " " " " " " " ((woei>)(        ())(  UUUUUUU  ))
" " " " " " " " " " " " ( (woei>)(        ())(UUUUUUU) )
" " " " " " " " " " " " ( (woei>)(        () )(UUUUUUU) )
" " " " " " " " " " " " ( (woei>)(        ())(UUUUUUU) )
" " " " " " " " " " " " " ( (          ()                       woei>                                 )(        ())(UUUUUUU) )
" ie + owie +  (woei>oei+)
" ()()   ( weoi>oiew+)     (
" ( oewi>woei+)
" ()                               ()
" ()
" (
" (  `l:)        (UUUUUUUUUU)
" ( ()
" ()( (,f(                                ),) )
" ()fun(weofijweoi+)

let s:SurroundMap = {
			\')'    : {'open': '(','close':')'},
			\']'    : {'open': '[','close':']'},
			\'>'    : {'open': '<','close':'>'},
			\'"'    : {'open': '"','close':'"'},
			\"'"    : {'open': "'",'close':"'"} }

fun! InSpace(opt)
    let stoodwhere = getline('.')[col('.')-1]
    " let stoodwhere1 = getline('.')[col('.')-2] . '[-2]'
    " let stoodwhere2 = getline('.')[col('.')-1] . '[-1]'
    " let stoodwhere3 = getline('.')[col('.')]   . '[0]'
    " let stoodwhere4 = getline('.')[col('.')+1] . '[+1]'
    " echo a:opt . stoodwhere1 . stoodwhere2 . stoodwhere3 . stoodwhere4
    "elseif stoodwhere == '"'
    "    let l:choice = 3
    "elseif stoodwhere == '>'
    "    let l:choice = 4
    "elseif stoodwhere == "'"
    "    let l:choice = 5
    "0endif
    "let l:open  = s:SurroundMap[l:choice][0]
    "let l:close = s:SurroundMap[l:choice][1]
    "let acol = match(getline('.'),l:open)
    "let bcol = match(getline('.'),l:close)

    let acol = match(getline('.'),'(')
    let bcol = match(getline('.'),')')
    let ccol = col('.')-1
    let l_margin = abs(ccol - acol)
    let r_margin = abs(bcol - ccol) + 1
    let condition2 = (l_margin == r_margin)

    let a = getline('.')[col('.')-2]
    let b = getline('.')[col('.')-1]
    let condition1 = (a == '(' && b == ')')
    " let condition1 = (a == l:open && b == l:close)

    if a:opt == 'spread'
      if condition2
      " if condition2 || condition1
          return "\<space>\<space>\<Left>"
      else
          return "\<space>"
      endif
    elseif a:opt == 'shrink'
      if condition2
          return "\<Right>\<C-h>\<C-h>"
      else
          return "\<C-h>"
      endif
    endif
endfun
"imap <space> <C-R>=InSpace('spread')<CR>
imap <C-h> <C-R>=InSpace('shrink')<CR>

