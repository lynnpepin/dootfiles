# ｡☆✼★━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━★✼☆｡
#✧༺♥༻∞     Ubuntu Server                         ∞༺♥༻✧
#ˑ༄ؘ ۪۪۫۫ ▹       An opinionated quickstart               ◃ ۪۪۫۫ ༄ؘ ˑ
# ｡☆✼★━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━★✼☆｡

# MANUAL STEPS
# 1. Set your username here
USER='lynn'

# 2. Put all your SSH keys in files/authorized_keys

# 3. Run this script as root!

# 4. Then run `ubuntu-user-first-startup.sh`


# ｡☆✼★━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━★✼☆｡
#ˑ༄ؘ ۪۪۫۫ ▹ As root, set up your first user  ◃ ۪۪۫۫ ༄ؘ ˑ
# ｡☆✼★━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━★✼☆｡

#ˑ༄ؘ ۪۪۫۫ ▹ Change your username here! I'm lynn :)
USER='lynn'
useradd -s /bin/bash -m $USER
usermod -aG sudo $USER
mkdir /home/$USER/.ssh

#ˑ༄ؘ ۪۪۫۫ ▹ IMPORTANT! Put your SSH *public key* into 'authorized_keys'!
#ˑ༄ؘ ۪۪۫۫ ▹ You're going to get locked out if you don't...
cp files/authorized_keys /home/$USER/.ssh/authorized_keys 
chown -R  $USER:$USER /home/$USER/.ssh
chmod 700 /home/$USER/.ssh
chmod 600 /home/$USER/.ssh/authorized_keys
passwd $USER

#ˑ༄ؘ ۪۪۫۫ ▹ Reboot then ssh back in!
sudo reboot


# ｡☆✼★━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━★✼☆｡
#ˑ༄ؘ ۪۪۫۫ ▹ Time to SSH back into the server ◃ ۪۪۫۫ ༄ؘ ˑ
#       To ssh back in, do
#       ssh user@ip
# e.g.: ssh lynn@123.45.67.89
# ｡☆✼★━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━★✼☆｡
