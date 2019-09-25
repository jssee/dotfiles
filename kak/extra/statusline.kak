# a nicer statusline
evaluate-commands %sh{
  keyboard='{red+b}%sh{ echo "$kak_opt_langmap_current_lang " | grep -v en }{default}'
  cwd='at {cyan}%sh{ pwd | sed "s|^$HOME|~|" }{default}'
  bufname='in {green}%val{bufname}{default}'
  modified='{yellow+b}%sh{ $kak_modified && echo "[+] " }{default}'
  ft='as {magenta}%sh{ echo "${kak_opt_filetype:-noft}" }{default}'
  cursor='on {cyan}%val{cursor_line}{default}:{cyan}%val{cursor_char_column}{default}'
  readonly='{red+b}%sh{ [ -f "$kak_buffile" ] && [ ! -w "$kak_buffile" ] && echo "[] " }{default}'
  session='{cyan}[%val{session}]{default}'
  echo set global modelinefmt "'{{mode_info}} ${keyboard} ${session} ${cwd} ${bufname} ${readonly}${modified}${ft} ${eol} ${cursor}'"
}
