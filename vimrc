set rtp+=~/.local/lib/python3.9/site-packages/powerline/bindings/vim/
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2
set t_Co=256
