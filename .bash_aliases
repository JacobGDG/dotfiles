alias gogogo="slack </dev/null &>/dev/null & ; firefox </dev/null &>/dev/null &"
alias vimvim="vim ~/.vim/global/"
alias vimalias="vim ~/.bash_aliases"
alias vimgit="vim ~/.gitconfig"

alias sourcealias="source ~/.bash_aliases"

alias clearcache="echo flush_all | nc localhost 11211"

alias dockerg="docker ps -a | grep"

cpdf() {
  cp "$1" ~/dotfiles/
}
