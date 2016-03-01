#RM=rm -f
#RMconf=$(RM)/

config: config.d/*
	rm -f config
	rm -f config.d/.*~
	rm -f config.d/*~
	cat config.d/*-* > config
	
desktop: config
	rm -f config.d/desktop.d/.*~
	rm -f config.d/desktop.d/*~
	cat config.d/desktop.d/* >> config
	i3-msg reload

laptop: config
	rm -f config.d/laptop.d/.*~
	rm -f config.d/laptop.d/*~
	cat config.d/laptop.d/* >> config
	i3-msg reload
