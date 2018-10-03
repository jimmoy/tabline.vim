" File:        tabline.vim
" Maintainer:  Matthew Kitt <http://mkitt.net/>
" Description: Configure tabs within Terminal Vim.
" Last Change: 2012-10-21
" License:     This program is free software. It comes without any warranty,
"              to the extent permitted by applicable law. You can redistribute
"              it and/or modify it under the terms of the Do What The Fuck You
"              Want To Public License, Version 2, as published by Sam Hocevar.
"              See http://sam.zoy.org/wtfpl/COPYING for more details.
" Based On:    http://www.offensivethinking.org/data/dotfiles/vimrc
" Updates:     Jim Moy <jim@jimmoy.com> 2018-10-03
"              Tweaks so I'm not looking at a dozen index.js files, etc.
"              Personal preferences.

" Bail quickly if the plugin was loaded, disabled or compatible is set
if (exists("g:loaded_tabline_vim") && g:loaded_tabline_vim) || &cp
  finish
endif
let g:loaded_tabline_vim = 1

function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let buflist = tabpagebuflist(tab)
    let bufnr = buflist[winnr - 1]
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")

    let filename = fnamemodify(bufname, ':t')

    if filename == 'index.js'
      let dispname = fnamemodify(bufname, ':p:h:t') . '/i'
    elseif filename == 'view.js'
      let dispname = fnamemodify(bufname, ':p:h:t') . '/v'
    elseif filename == 'style.js' || filename == 'styles.js'
      let dispname = fnamemodify(bufname, ':p:h:t') . '/s'
    elseif filename == 'component.js' || filename == 'components.js'
      let dispname = fnamemodify(bufname, ':p:h:t') . '/c'
    elseif filename == 'enhancer.js' || filename == 'enhancers.js'
      let dispname = fnamemodify(bufname, ':p:h:t') . '/e'
    elseif filename == 'helper.js' || filename == 'helpers.js'
      let dispname = fnamemodify(bufname, ':p:h:t') . '/h'
    elseif filename == 'query.js' || filename == 'queries.js'
      let dispname = fnamemodify(bufname, ':p:h:t') . '/q'
    else
      let dispname = fnamemodify(bufname, ':t')
    endif

    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tab .' '
    let s .= (bufname != '' ? dispname . ' ' : '[unnamed] ')

    if bufmodified
      let s .= '* '
    endif
  endfor

  let s .= '%#TabLineFill#'
  if (exists("g:tablineclosebutton"))
    let s .= '%=%999XX'
  endif
  return s
endfunction
set tabline=%!Tabline()

