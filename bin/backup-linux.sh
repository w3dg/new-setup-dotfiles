BACKUP=backup-$(hostname)-$(date --iso-8601).tar.gz

tar -cvpzf $BACKUP \
	--exclude=$BACKUP \
	--exclude=.cache \
	--exclude=.debug \
	--exclude=.local \
	--exclude=.recently-used \
	--exclude=.thumbnails \
	--exclude=.pyenv \
	--exclude=.Trash \
	--exclude=.npm \
	--exclude=.poetry \
	--exclude=.kube \
	--exclude=.fastlane \
	--exclude=.mix \
	--exclude=.pyenv \
	--exclude=.gem \
	--exclude=.vscode \
	--exclude=.cocoapods \
	--exclude=Downloads \
	--exclude=Library \
	--exclude=Movies \
	--exclude=Music \
	--exclude=nltk_data \
	--exclude=Pictures \
	--exclude=pkg \
	--exclude=Applications \
	--exclude=.auto-cpufreq \
	--exclude=.bash \
	--exclude=.cargo \
	--exclude=.cert \
	--exclude=.codeium \
	--exclude=.degit \
	--exclude=.docker \
	--exclude=.dotnet \
	--exclude=.fzf \
	--exclude=.gnome \
	--exclude=.ipython \
	--exclude=.java \
	--exclude=.jupyter \
	--exclude=.MathWorks \
	--exclude=.matlab \
	--exclude=.MATLABConnector \
	--exclude=.npm \
	--exclude=.oh-my-zsh \
	--exclude=.pki \
	--exclude=.rustup \
	--exclude=.texlive* \
	--exclude=.themes \
	--exclude=.tldr \
	--exclude=.var \
	--exclude=.vscode \
	--exclude=.zoom \
	--exclude=.zsh \
	--exclude=.yarn \
	.

while true; do
    read -r -p "Do you wish to encrypt with GPG (y/n): " answer
    case $answer in
        [Yy]* ) gpg --symmetric --cipher-algo AES256 $BACKUP; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer Y or N.";;
    esac
done

# To get back from backup

# $ EXTRACTED=backup-test-2025-01-19T00-34-31.tar.gz
# $ gpg --output $EXTRACTED --decrypt $EXTRACTED.gpg
# $ tar xvf $EXTRACTED
