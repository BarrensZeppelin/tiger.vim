" Author: Oskar Haarklou Veileborg https://github.com/BarrensZeppelin
" Description: Tiger linter using our own compiler

call ale#Set('tiger_tigerc_executable', 'tigerc')

function! ale_linters#tiger#tigerc#GetCommand(buffer) abort
  " TODO: Detect if sem phase is available?
  return fnameescape(ale#Var(a:buffer, 'tiger_tigerc_executable'))
        \ . ' -p sem /dev/stdin'
endfunction

function! ale_linters#tiger#tigerc#Handle(buffer, lines) abort
  let l:pattern = [
        \ '\v^Lexing error in file /dev/stdin at position (\d+):(\d+)',
        \ '\v^/dev/stdin:(\d+):(\d+)( - )?(\d+)?:?(\d+)?: (.*)$',
        \]
  let l:output = []

  for l:match in ale#util#GetMatches(a:lines, l:pattern)
    let l:qf = {
          \ 'lnum': str2nr(l:match[1]),
          \ 'col': str2nr(l:match[2]),
          \ 'text': empty(l:match[6])? l:match[0] : l:match[6],
          \}

    if !empty(l:match[3])
      let l:qf['end_lnum'] = str2nr(l:match[4])
      let l:qf['end_col'] = str2nr(l:match[5])
    endif

    call add(l:output, l:qf)
  endfor

  return l:output
endfunction

call ale#linter#Define('tiger', {
\ 'name': 'tigerc',
\ 'executable': {b -> ale#Var(b, 'tiger_tigerc_executable')},
\ 'command': {b -> ale_linters#tiger#tigerc#GetCommand(b)},
\ 'callback': 'ale_linters#tiger#tigerc#Handle',
\ 'output_stream': 'stderr',
\})
