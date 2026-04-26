set fish_greeting
set fish_prompt_pwd_dir_length 0
set -gx QML2_IMPORT_PATH "$HOME/.local/lib/qt6/qml"
set -gx MANPAGER "nvim +Man!"

alias vim 'nvim'
alias ll 'exa -l -g --icons'
alias lla 'll -a'
alias llt 'll --tree'
alias update 'flatpak update -y && yay -Syu --noconfirm'

fish_config theme choose "Rosé Pine"

function fish_prompt -d "Write out the prompt"
    printf ' %s%s%s > ' \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

pyenv init - | source
