theme="current"

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
	@cp theme/$(theme)/rice theme/rice
	@cp theme/$(theme)/i3status.conf theme/i3status.conf
	@cp theme/$(theme)/background.jpg theme/background.jpg 2>/dev/null || :
	@cp theme/$(theme)/background.png theme/background.png 2>/dev/null || :
endif
	@cat theme/rice >> config
	@i3-msg reload
	@i3-msg "$(cat /home/nick/.config/i3/config | grep "\-\-bg\-")"

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
	@cp theme/$(theme)/rice theme/rice
	@cp theme/$(theme)/i3status.conf theme/i3status.conf
	@cp theme/$(theme)/background.jpg theme/background.jpg 2>/dev/null || :
	@cp theme/$(theme)/background.png theme/background.png 2>/dev/null || :
endif
	@cat theme/rice >> config
	@i3-msg reload
	@i3-msg "$(cat /home/nick/.config/i3/config | grep "\-\-bg\-")"
