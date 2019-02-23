SHELL=/bin/bash
DOTFILES := $(shell pwd)

.PHONY: vim imwheel git all font

all: vim imwheel git shell lang font

vim: ${HOME}/.vimrc ${HOME}/.vim/colors ${HOME}/.vim/indent

imwheel: ${HOME}/.imwheelrc ${HOME}/.config/autostart/imwheel.desktop

font: ${HOME}/.config/fontconfig/fonts.conf

git:
	git config --global user.name t-onoz
	git config --global user.email 18749921+t-onoz@users.noreply.github.com

shell: ${HOME}/.bashrc ${HOME}/.inputrc

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
