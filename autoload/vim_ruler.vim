if !exists("g:colorColumnList")
    let g:colorColumnList = [80, 50, 100]
endif

let s:colorColumnListIndex = len(g:colorColumnList)

function vim_ruler#UpdateIndex()
    let s:colorColumnListIndex = s:colorColumnListIndex + 1
    let s:colorColumnListIndex = s:colorColumnListIndex % (len(g:colorColumnList) + 1)
endfunction

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

