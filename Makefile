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

	@cp theme/$(theme)/dunstrc /home/nick/.config/dunst/dunstrc 2>/dev/null || :
	@cp theme/$(theme)/i3* theme/
	@cp theme/$(theme)/rice theme/rice
	@cp theme/$(theme)/background.jpg theme/background.jpg 2>/dev/null || :
	@cp theme/$(theme)/background.png theme/background.png 2>/dev/null || :
endif
	@wal -t -i '/home/nick/.config/i3/theme/background.png' 2>/dev/null || :
	@wal -t -i '/home/nick/.config/i3/theme/background.jpg' 2>/dev/null || :
	@cat theme/rice >> config
	@./scripts/background_set.sh
	@sudo killall dunst 1>/dev/null || :
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
	@cp theme/$(theme)/dunstrc /home/nick/.config/dunst/dunstrc 2>/dev/null || :
	@cp theme/$(theme)/i3* theme/
	@cp theme/$(theme)/i3* theme/
	@cp theme/$(theme)/rice theme/rice
	@cp theme/$(theme)/background.jpg theme/background.jpg 2>/dev/null || :
	@cp theme/$(theme)/background.png theme/background.png 2>/dev/null || :
endif
	@wal -t -i '/home/nick/.config/i3/theme/background.png' 2>/dev/null || :
	@wal -t -i '/home/nick/.config/i3/theme/background.jpg' 2>/dev/null || :
	@cat theme/rice >> config
	@./scripts/background_set.sh
	@sudo killall dunst 1>/dev/null || :
	@i3-msg "reload" 1>/dev/null || :
	@i3-msg "restart" 1>/dev/null || :
