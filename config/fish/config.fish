set fish_greeting

alias vim 'nvim'
alias ll 'exa -l -g --icons'
alias lla 'll -a'

fish_config theme choose "Rosé Pine"

function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf ' %s%s%s > ' \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end
