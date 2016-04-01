theme="current"

desktop: 
	rm -f config
	rm -f settings/.*~
	rm -f settings/*~
	cat settings/*-* > config
	rm -f settings/desktop.d/.*~
	rm -f settings/desktop.d/*~
	cat settings/desktop.d/* >> config
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
	rm -f settings/.*~
	rm -f settings/*~
	cat settings/*-* > config
	rm -f settings/laptop.d/.*~
	rm -f settings/laptop.d/*~
	cat settings/laptop.d/* >> config
ifeq ($(theme),"current")
	@echo "keeping current theme"
else
	cp theme/$(theme)/rice theme/rice
	cp theme/$(theme)/i3status.conf theme/i3status.conf
	cp theme/$(theme)/background.jpg theme/background.jpg
endif
	cat theme/rice >> config
	i3-msg reload
