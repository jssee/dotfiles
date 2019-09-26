define-command buffer-switcher %{
    try %{
        b *buffer-switcher*
    } catch %{
        eval -save-regs '"/' %{
            eval reg dquote %val{buflist}
            reg / "^\Q%val{bufname}\E$"
            edit -scratch *buffer-switcher*
            exec '<a-P>)<a-space>i<ret><esc>'
            exec '%<a-s>'
            exec -draft '<a-k>^\*debug\*$<ret>d'
            exec '<a-k><ret>'
            addhl buffer/ regex "%reg{/}" 0:black,green
            map buffer normal <ret> ': buffer-switcher-switch<ret>'
            map buffer normal <esc> ': db<ret>'
            hook global -once WinDisplay .* %{ try %{ delete-buffer *buffer-switcher* } }
        }
    }
}
define-command -hidden buffer-switcher-switch %{
    exec '<space>;<a-x>H'
    eval %sh{
    }
    eval -save-regs b %{
        reg b %val{selection}
        delete-buffer *buffer-switcher*
        buffer %reg{b}
    }
}

