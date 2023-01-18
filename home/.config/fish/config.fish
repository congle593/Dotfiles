if status is-interactive
    # Commands to run in interactive sessions can go here

    set fish_greeting ""

    set -gx TERM xterm-256color

    # aliases
    alias g git
    alias ls "exa --icons"
    alias lsa "ls -a"
    alias ll "exa -l -g --icons"
    alias lla "ll -a"

    set -gx EDITOR nvim

    set -gx PATH bin $PATH
    set -gx PATH ~/bin $PATH
    set -gx PATH ~/.local/bin $PATH
    set -gx PATH ~/.cargo/bin $PATH

    # Go
    set -g GOPATH $HOME/go
    set -gx PATH $GOPATH/bin $PATH
    set -gx PATH /usr/local/go/bin $PATH

    # Nodejs
    # set -g NODEVERSION v16.16.0
    # set -g DISTRO linux-x64
    # set -gx PATH /usr/local/lib/nodejs/node-$NODEVERSION-$DISTRO/bin $PATH
    set --universal nvm_default_version v18.13.0
    set -gx PATH node_modules/.bin $PATH

end
