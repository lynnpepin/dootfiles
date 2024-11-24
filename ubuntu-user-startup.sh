# ｡☆✼★━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━★✼☆｡
#✧༺♥༻∞     Ubuntu Server                         ∞༺♥༻✧
#ˑ༄ؘ ۪۪۫۫ ▹       An opinionated quickstart               ◃ ۪۪۫۫ ༄ؘ ˑ
# ｡☆✼★━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━★✼☆｡

# ｡☆✼★━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━★✼☆｡
#ˑ༄ؘ ۪۪۫۫ ▹ Basic config and initial setup   ◃ ۪۪۫۫ ༄ؘ ˑ
# ｡☆✼★━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━★✼☆｡

mkdir .bak
cp ~/.bashrc  ~/.bak/.bashrc.bak

# You might copy these manually using vi
cp files/bashrc ~/.bashrc

#ˑ༄ؘ ۪۪۫۫ ▹ Set up some nice aliases I use
cat <<EOF > ~/.bash_aliases
alias ll='eza -ll'
alias za="eza -la"
alias hgrep='history | grep'
alias bat='batcat'
alias hgrep='history | grep'
alias hrg='history | rg'
alias bat='batcat'

alias py="python3"
alias python="python3"

cht() { curl cht.sh/"$1"; }
EOF

#ˑ༄ؘ ۪۪۫۫ ▹ Install all the things
sudo apt update
sudo apt upgrade

#ˑ༄ؘ ۪۪۫۫ ▹ Secure SSH!
sudo sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/g' /etc/ssh/sshd_config
sudo sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#PasswordAuthentication yes/Password Authentication no/g' /etc/ssh/sshd_config
sudo sed -i 's/#PermitEmptyPasswords yes/PermitEmptyPasswords no/g' /etc/ssh/sshd_config
sudo sed -i 's/X11Forwarding yes/X11Forwarding no/g' /etc/ssh/sshd_config

#ˑ༄ؘ ۪۪۫۫ ▹ Firewall: Block all ports except SSH (22) and web (80, 443)
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw enable


# ｡☆✼★━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━★✼☆｡
#ˑ༄ؘ ۪۪۫۫ ▹ Kick ass with modern Linux tools ◃ ۪۪۫۫ ༄ؘ ˑ
#  The classics:
#    git:  Version control
#    curl:  HTTP swiss army knife
#    build-essential:  gcc and its buddies
#    htop:  Like top, but nicer
#    tmux:  Terminal multiplexer!
# 
#  The classics, improved:
#    neovim:  Better vim
#    ripgrep:  Better grep
#    eza:  Better ls
#    bat:  Better cat
#    fd-find:  Better find
#    duf:  Better du
#    difftastic:  Better dif
#    sd:  Better sed
#    du-dust:  Better du
#    bottom:  Better top
#    (yes, bottom is a rust project, why?)
#  
#  Something new entirely:
#    Rust tooling:  rustup and cargo make it
#    easy to install rust 'crate' packages.
#    broot:  Friendly terminal file manager
#    micro:  Friendly text editor
# ｡☆✼★━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━★✼☆｡

sudo apt install git curl build-essential htop tmux

# Install rust and rusty tools
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

cargo install eza bat fd-find jless sd difftastic du-dust cargo-binstall eza jless broot ripgrep
cargo install --locked bat
cargo install --locked bottom

snap install --classic helix

curl https://getmic.ro | bash
sudo mv micro /usr/local/bin/micro
sudo chown root:root /usr/local/bin/micro

# ｡☆✼★━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━★✼☆｡
#ˑ༄ؘ ۪۪۫۫ ▹ Just a bit more tinkering...     ◃ ۪۪۫۫ ༄ؘ ˑ
# ｡☆✼★━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━★✼☆｡

#ˑ༄ؘ ۪۪۫۫ ▹ Helix config
mkdir -p ~/.config/helix

echo "
[editor]
auto-format = false
auto-pairs = false

[editor.soft-wrap]
enable = true

" -n > ~/.config/helix/config.toml

#ˑ༄ؘ ۪۪۫۫ ▹ Keep 200 weeks of auth.log entries!
sudo python3 -c "
with open('/etc/logrotate.d/rsyslog', 'r') as ff:
    rsyslog = ff.read()

orig = '/var/log/auth.log'
goal = '''/var/log/auth.log
{
        rotate 200
        weekly
        missingok
        notifempty
        compress
        delaycompress
        postrotate
                reload rsyslog >/dev/null 2>&1 || true
        endscript
}'''

with open('/etc/logrotate.d/rsyslog', 'w') as ff:
  ff.write(rsyslog.replace(orig, goal))
"
