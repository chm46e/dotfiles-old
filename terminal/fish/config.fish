source ~/.config/fish/alias.fish
source /usr/share/autojump/autojump.fish 

# Fish syntax highlighting
set -g fish_color_autosuggestion '555'  'brblack'
set -g fish_color_cancel -r
set -g fish_color_command --bold
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end brmagenta
set -g fish_color_error brred
set -g fish_color_escape 'bryellow'  '--bold'
set -g fish_color_history_current --bold
set -g fish_color_host normal
set -g fish_color_match --background=brblue
set -g fish_color_normal normal
set -g fish_color_operator bryellow
set -g fish_color_param cyan
set -g fish_color_quote yellow
set -g fish_color_redirection brblue
set -g fish_color_search_match 'bryellow'  '--background=brblack'
set -g fish_color_selection 'white'  '--bold'  '--background=brblack'
set -g fish_color_user brgreen
set -g fish_color_valid_path 

cd /home/wolfy
clear

starship init fish | source
set -gx PATH $PATH ~/bin ~/.local/bin

# pfetch
set -gx PF_INFO "ascii title os host kernel uptime memory wm shell"
set -gx PF_SEP ""

function fish_greeting
    echo ""
    pfetch
    #neofetch --disable Packages
end

# misc
set -gx FZF_DEFAULT_OPTS "--height=30% --layout=reverse"


