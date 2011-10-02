:let filelist = glob("~/.vim/conf/*.vim")
:let splitted = split(filelist, "\n")
:for $file in splitted
  if filereadable($file)
    source $file
  else
    echo "[ERROR] filereadable(" . $file . ")"
  endif
:endfor
