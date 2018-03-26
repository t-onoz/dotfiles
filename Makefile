SHELL=/bin/bash
DOTFILES := $(shell pwd)

.PHONY: vim imwheel git all

all: vim imwheel git shell fcitx lang

vim: ${HOME}/.vimrc ${HOME}/.vim/colors ${HOME}/.vim/indent

imwheel: ${HOME}/.imwheelrc ${HOME}/.config/autostart/imwheel.desktop

git:
	git config --global user.name t-onoz
	git config --global user.email 18749921+t-onoz@users.noreply.github.com

shell: ${HOME}/.bashrc ${HOME}/.inputrc

fcitx: ${HOME}/.config/environment.d/40-fcitx.conf
	touch ${HOME}/.xprofile
	sed -i -e '/export[[:space:]]*GTK_IM_MODULE=.*$$/d' \
	    -e '/export[[:space:]]*QT_IM_MODULE=.*$$/d' \
	    -e '/export[[:space:]]*XMODIFIERS=.*$$/d' \
		${HOME}/.xprofile
	echo "export GTK_IM_MODULE=fcitx" >> ${HOME}/.xprofile
	echo "export QT_IM_MODULE=fcitx" >> ${HOME}/.xprofile
	echo "export XMODIFIERS=@im=fcitx" >> ${HOME}/.xprofile

lang:
	touch ${HOME}/.xprofile
	sed -i -e '/export[[:space:]]*LANG=.*$$/d' \
		-e '/export[[:space:]]*LC_COLLATE=.*$$/d' \
		${HOME}/.xprofile
	echo "export LANG=ja_JP.UTF-8" >> ${HOME}/.xprofile
	echo "export LC_COLLATE=en_US.UTF-8" >> ${HOME}/.xprofile

FORCE:
${HOME}/%: $(DOTFILES)/% FORCE
	mkdir -p $(dir $@)
	ln -snf $< $@
