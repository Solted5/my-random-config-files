set fish_greeting
set -gx EDITOR "nvim"
set -gx VISUAL "nvim"

### "nvim" as manpager
set -x MANPAGER "nvim +Man!"

alias vim='nvim'
alias sudo='doas'
alias startmcserver='cd /home/salt/games/new-server/ && sh start.sh'

starship init fish | source
