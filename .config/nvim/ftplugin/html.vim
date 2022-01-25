setlocal omnifunc=MyHTMLComplete

function! MyHTMLComplete(findstart, base)
  if search('<?php', 'bnW') > search('<script>', 'bnW')
    return phpcomplete#CompletePHP(a:findstart, a:base)
  else
    return tern#Complete(a:findstart, a:base)
  endif
endfunction
