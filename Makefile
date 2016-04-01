theme="current"

desktop: 
	rm -f config
	rm -f config.d/.*~
	rm -f config.d/*~
	cat config.d/*-* > config
	rm -f config.d/desktop.d/.*~
	rm -f config.d/desktop.d/*~
	cat config.d/desktop.d/* >> config
ifeq ($(theme),"current")
	@echo "keeping current theme"
else
	cp theme/$(theme)/rice theme/rice
	cp theme/$(theme)/i3status.conf theme/i3status.conf
	cp theme/$(theme)/background.jpg theme/background.jpg
endif
	cat theme/rice >> config
	i3-msg reload

laptop:
	rm -f config
	rm -f config.d/.*~
	rm -f config.d/*~
	cat config.d/*-* > config
	rm -f config.d/laptop.d/.*~
	rm -f config.d/laptop.d/*~
	cat config.d/laptop.d/* >> config
ifeq ($(theme),"current")
	@echo "keeping current theme"
else
	cp theme/$(theme)/rice theme/rice
	cp theme/$(theme)/i3status.conf theme/i3status.conf
	cp theme/$(theme)/background.jpg theme/background.jpg
endif
	cat theme/rice >> config
	i3-msg reload
