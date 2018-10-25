call plug#begin('~/.config/plug')

Plug 'HerringtonDarkholme/yats.vim', {'for': 'typescript'}
Plug 'SirVer/ultisnips'
Plug 'ap/vim-buftabline'
Plug 'cocopon/vaffle.vim'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'maralla/completor-typescript'
Plug 'maralla/completor.vim', { 'do': 'make js' }
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
Plug 'mxw/vim-jsx', {'for': 'javascript.jsx'}
Plug 'nightsense/stellarized'
Plug 'othree/yajs.vim', {'for': 'javascript'}
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

call plug#end()

so ~/dotfiles/vim/general.vim
so ~/dotfiles/vim/mappings.vim
so ~/dotfiles/vim/plugins.vim
so ~/dotfiles/vim/colorscheme.vim

