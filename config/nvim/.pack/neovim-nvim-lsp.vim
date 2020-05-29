" Most of the configuration for the built in lsp is handled in /lua/lsp.lua so
" we just need to make sure to 'source' that file at startup...
lua << EOF
require 'lsp'
EOF

