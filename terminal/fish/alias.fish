### Package manager ### 
alias in="sudo dnf install"
alias dein="sudo dnf remove"
alias softup="sudo dnf check-update; sudo dnf upgrade"
alias se="sudo dnf search"
alias aure="sudo dnf autoremove"
alias info="sudo dnf info"

### Quick d/f management ### 
alias la='exa -alg --group-directories-first'
alias ls='exa -a --group-directories-first'
alias ll='exa -lg --group-directories-first'
alias lf='exa -lDg --group-directories-first'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .2="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."
alias .6="cd ../../../../../.."
alias cp="cp -riv"
alias mv="mv -nv"
alias rn="rename -ov"
alias ln="ln -iv"
alias mkdir="mkdir -pv"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias grepf="fgrep --color=auto --file"
alias egrepf="egrep --file"

### Configuration files ###
alias conf-alias="nvim /home/wolfy/.config/fish/alias.fish"
alias conf-fish="nvim /home/wolfy/.config/fish/config.fish"
alias conf-ss="nvim /home/wolfy/.config/starship.toml"
alias conf-nvim-init="nvim /home/wolfy/.config/nvim/lua/custom/init.lua"
alias conf-nvim-chadrc="nvim /home/wolfy/.config/nvim/lua/custom/chadrc.lua"

### Input ##
alias input-en="xinput enable"
alias input-di="xinput disable"
alias input-l="xinput list"

### systemctl ###
alias sys-s="sudo systemctl status"
alias sys-en="sudo systemctl enable"
alias sys-di="sudo systemctl disable"
alias sys-start="sudo systemctl start"
alias sys-stop="sudo systemctl stop"
alias sys-rs="sudo systemctl restart"
alias sys-u="sudo systemctl list-units"
alias sys-kill="sudo systemctl kill"
alias sys-socks="sudo systemctl list-sockets"
alias sys-timers="sudo systemctl list-timers --all"

### Linux Kernel ### 
alias Linux="cd /home/wolfy/Kernel/linux"
alias chkstyle="/home/wolfy/Kernel/linux/scripts/checkpatch.pl"
alias rmmod="sudo rmmod -v"
alias insmod="sudo insmod -v"

### Networking ###
alias ports="netstat -tulnap"
alias ping="ping -c5"
alias prasp="ping -c5 192.168.1.8" # ping pi4 server
alias ip-all="curl ifconfig.me/all"
alias ip-me="curl ifconfig.me/ip"
alias speedtest='speedtest-cli --simple'

### Applications ###
## Manuals ##
alias manual="tldr"
alias cheat="/opt/cheat"

## Editors ##
alias micro="nvim"
alias nano="nvim"

## Python ##
alias py2='python2'
alias py3='python3'
alias python="python3"

## Main ##
alias balena="/opt/balenaEtcher-1.5.115-x64_1a42e1ec3ceadf7206335c3be74923c9.AppImage"
alias binaryninja="/opt/binaryninja/binaryninja"
alias sysmon="glances"
alias battery="acpi"

## Misc ##
alias wget="wget -c"
alias grub2efiup="sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg"

### FZF ###
alias code="nvim (fzf)"
alias photo="eog (fzf)"

### Suckless ###
alias dwmcomp="cd ~/.dwm ;; sudo make -j4 clean install"
alias cddwm="cd ~/.dwm"
alias cdst="cd ~/.st"

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

### Disk ###
alias free="free -mt"
alias df='df -h'
alias dsize="ncdu"

### Fix typos ###
alias ,,=".."
alias ,,,="..."
alias ,,,,="...."
alias pdw="pwd"
alias search="se"
alias l='la'
alias cclear="clear"
alias clea="clear"
alias c="clear"
alias cls="clear"

### Git ###
alias gs="git status"
alias gl="git log"
alias gll="git log | less"
alias ga="git add"
alias gaa="git add ."
alias gcm="git commit -m"
alias gc="git commit -p"
alias gch="git checkout"
alias gcheck="git checkout"
alias gp="git push origin master"
alias grevert="git clean -fd"
alias grev="git clean -fd"
alias gshow="git show --pretty=full"
alias gsh="git show --pretty=full"
alias createpatch="git format-patch"

### Safe file/dir removal ###
alias rr="rm -r"
function rm
    mv -i $argv /tmp/
    echo "$argv -> /tmp"
end

### Quickly restore accidentally removed file/dir ###
function restore
    mv -i /tmp/$argv ./
    echo "'/tmp/"$argv"' restored"
end

### Quick C ###
function compile
    gcc $argv -o bin
    ./bin
end
alias comp="compile"

### Archive extract ###
alias untar="tar -xvf"
function ex
    switch $argv
        case '*.tar.bz2'
            tar xjf $argv
        case '*.tar.gz'
            tar xzf $argv
        case '*.bz2'
            bunzip2 $argv
        case '*.rar'
            rar x $argv
        case '*.gz'
            gunzip $argv
        case '*.tar'
            tar xf $argv
        case '*.tar.xz'
            tar xvf $argv
        case '*.tbz2'
            tar xjf $argv
        case '*.tgz'
            tar xzf $argv
        case '*.zip'
            unzip $argv
        case '*.Z'
            uncompress $argv
        case '*.7z'
            7z x $argv
        case '*'
            echo "Unknown file format."
    end
end

### OS ###
function qemu
    nasm -f bin $argv -o $argv.bin
    qemu-system-x86_64 $argv.bin
end
