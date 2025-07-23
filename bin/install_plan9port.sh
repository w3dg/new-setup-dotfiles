cd /usr/local/
sudo git clone https://github.com/9fans/plan9port plan9
cd plan9
sudo chmod +x ./INSTALL

# install xorg-dev package from apt, it'll help
# sudo apt install xorg-dev

sudo ./INSTALL

# add to path
# Plan9Port - Plan 9 from userspace
export PLAN9=/usr/local/plan9
export PATH=$PATH:$PLAN9/bin # add this at the end so that all others take precedence
