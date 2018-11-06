call plug#begin('~/.config/plug')

" Display
Plug 'ap/vim-buftabline'
Plug 'cocopon/vaffle.vim'
Plug 'itchyny/lightline.vim'

" Motion
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'terryma/vim-multiple-cursors'

" Lang
Plug 'HerringtonDarkholme/yats.vim', {'for': ['typescript', 'typescript.tsx']}
Plug 'mattn/emmet-vim'
Plug 'ElmCast/elm-vim', {'for': 'elm'}
Plug 'mxw/vim-jsx', {'for': 'javascript.jsx'}
Plug 'othree/yajs.vim', {'for': 'javascript'}
Plug 'w0rp/ale'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript','typescript.tsx', 'css', 'json', 'graphql', 'markdown', 'vue'] }

" Completion
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'maralla/completor-typescript'
Plug 'maralla/completor.vim', { 'do': 'make js' }

" Coloschemes
Plug 'nightsense/stellarized'

" Other
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

call plug#end()

so ~/dotfiles/vim/general.vim
so ~/dotfiles/vim/mappings.vim
so ~/dotfiles/vim/plugins.vim
so ~/dotfiles/vim/colorscheme.vim

