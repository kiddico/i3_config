theme="current"

ifndef VERBOSE
.SILENT:
endif

desktop: 
	@rm -f config
	@rm -f settings.d/.*~
	@rm -f settings.d/*~
	@cat settings.d/*-* > config
	@rm -f settings.d/desktop.d/.*~
	@rm -f settings.d/desktop.d/*~
	@cat settings.d/desktop.d/* >> config
ifeq ($(theme),"current")
	@echo "keeping current theme"
else
	@rm -rf theme/background*
	# Test For, and Copy Dunst Files
	#@test -d ~/.config/dunst || mkdir ~/.config/dunst
	#@cp theme/$(theme)/dunstrc ~/.config/dunst/dunstrc
	
	# i3blocks, i3status, and main rice
# Hopefully I'll change over to blocks soon!
	@cp theme/$(theme)/i3blocks.conf theme/i3blocks.conf
#	@cp theme/$(theme)/i3status.conf theme/i3status.conf
	@cp theme/$(theme)/rice theme/rice
	# move over backgrounds if they're there.
	@cp theme/$(theme)/background.jpg theme/background.jpg 2>/dev/null || :
	@cp theme/$(theme)/background.png theme/background.png 2>/dev/null || :
endif
	@cat theme/rice >> config
	@./scripts/background_set.sh
	#@sudo killall dunst 1>/dev/null || :
	@i3-msg "reload" 1>/dev/null || :
	@i3-msg "restart" 1>/dev/null || :

laptop:
	@rm -f config
	@rm -f settings.d/.*~
	@rm -f settings.d/*~
	@cat settings.d/*-* > config
	@rm -f settings.d/laptop.d/.*~
	@rm -f settings.d/laptop.d/*~
	@cat settings.d/laptop.d/* >> config
ifeq ($(theme),"current")
	@echo "keeping current theme"
else
	@rm -rf theme/background*
	# Test For, and Copy Dunst Files
	#@test -d ~/.config/dunst || mkdir ~/.config/dunst
	#@cp theme/$(theme)/dunstrc ~/.config/dunst/dunstrc
	
	# i3blocks, i3status, and main rice
	#@cp theme/$(theme)/i3status.conf theme/i3status.conf
	@cp theme/$(theme)/i3blocks.conf theme/i3blocks.conf
	@cp theme/$(theme)/rice theme/rice
	# move over backgrounds if they're there.
	@cp theme/$(theme)/background.jpg theme/background.jpg 2>/dev/null || :
	@cp theme/$(theme)/background.png theme/background.png 2>/dev/null || :
endif
	@cat theme/rice >> config
	@./scripts/background_set.sh
	#@sudo killall dunst 1>/dev/null || :
	@i3-msg "reload" 1>/dev/null || :
	@i3-msg "restart" 1>/dev/null || :
