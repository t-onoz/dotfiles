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

fcitx:
	touch ${HOME}/.pam_environment
	sed -i -e '/GTK_IM_MODULE=.*$$/d' \
	    -e '/QT_IM_MODULE=.*$$/d' \
	    -e '/XMODIFIERS=.*$$/d' \
		${HOME}/.pam_environment
	echo "GTK_IM_MODULE=fcitx" >> ${HOME}/.pam_environment
	echo "QT_IM_MODULE=fcitx" >> ${HOME}/.pam_environment
	echo "XMODIFIERS=@im=fcitx" >> ${HOME}/.pam_environment

lang:
	touch ${HOME}/.pam_environment
	sed -i -e '/LANG=.*$$/d' \
		-e '/LC_COLLATE=.*$$/d' \
		${HOME}/.pam_environment
	echo "LANG=ja_JP.UTF-8" >> ${HOME}/.pam_environment
	echo "LC_COLLATE=en_US.UTF-8" >> ${HOME}/.pam_environment

FORCE:
${HOME}/%: $(DOTFILES)/% FORCE
	mkdir -p $(dir $@)
	ln -snf $< $@
