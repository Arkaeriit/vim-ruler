"------------------------------- Cycling rulers -------------------------------"

if !exists("g:colorColumnList")
    let g:colorColumnList = [80, 50, 100]
endif

let s:colorColumnListIndex = len(g:colorColumnList)

" Update the index variable. Should be done before indexing the ruler list
function vim_ruler#UpdateIndex()
    let s:colorColumnListIndex = s:colorColumnListIndex + 1
    let s:colorColumnListIndex = s:colorColumnListIndex % (len(g:colorColumnList) + 1)
endfunction

" Cycle the rulers to the next one
function vim_ruler#ToggleRuler()
    call vim_ruler#UpdateIndex()
    if s:colorColumnListIndex == len(g:colorColumnList)
        set colorcolumn=
        echom "Color column disabled"
    else 
        let l:col = g:colorColumnList[s:colorColumnListIndex]
        let &colorcolumn = l:col
        echom "Color column at ".l:col." column"
    endif
endfunction

"------------------------------ Cutting to rulers -----------------------------"

" Tell if the current line is longer than the given argument
function vim_ruler#IsLineLonguer(len)
    let l:pos = getcurpos()
    let l:pos[2] = a:len + 1
    call setpos(".", l:pos)
    let l:pos = getcurpos()[2]
    return l:pos > a:len
endfunction

" Cut a line in multiple lines that are shorter than the given argument
" Cut line at spaces
function vim_ruler#CutToLen(len)
    while vim_ruler#IsLineLonguer(a:len)
        " Try to go to the last space and replace it with a new line
        let l:pos = getcurpos()
        let l:pos[2] = l:pos[2] + 1
        call setpos(".", l:pos)
        exec "normal F r\n"
        if getcurpos()[2] > 1
            " We did not found a space so we search for a tab
            exec "normal F	r\n"
        endif
        if getcurpos()[2] > 1
            " We did not found a tab either, so we add a new line at the edge
            let l:pos = getcurpos()
            let l:pos[2] = a:len
            call setpos(".", l:pos)
            exec "normal a\n"
        endif
    endwhile
endfunction
    
" Cut to the shortest vertical ruler
function vim_ruler#CutToRuler()
    let l:len = &colorcolumn + 1 - 1
    if l:len == 0
        echom "No ruler, impossible to cut"
    else
        call vim_ruler#CutToLen(l:len)
    endif
endfunction

