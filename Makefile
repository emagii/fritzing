all:	libs apps

deps:
	sudo apt-get install libqt5serialport5*
	sudo apt-get install libqt5svg5*

source:
	mkdir -p source

tags:
	mkdir -p tags

libs:	tags source \
	tags/.boost \
	tags/.libgit2

apps:	\
	tags/.fritzing-app \
	tags/.fritzing-parts

libgit2/build/Makefile:	libs scripts/Makefile.libgit2
	mkdir -p libgit2/build
	cp scripts/Makefile.libgit2 $@

libgit2.a:	libgit2/build/Makefile
	make -C libgit2/build

source/boost_1_74_0.tar.gz:
	wget -O $@ --progress=bar https://dl.bintray.com/boostorg/release/1.74.0/source/boost_1_74_0.tar.gz

source/libgit2-0.28.5.tar.gz:
	wget -O $@ --progress=bar https://github.com/libgit2/libgit2/releases/download/v0.28.5/libgit2-0.28.5.tar.gz

tags/.fritzing-app:
	git clone https://github.com/fritzing/fritzing-app
	touch $@

tags/.fritzing-parts:
	git clone https://github.com/fritzing/fritzing-parts
	touch $@

tags/.boost:	source/boost_1_74_0.tar.gz
	tar -zxvf $<
	ln -s boost_1_74_0 boost
	touch $@

tags/.libgit2:	source/libgit2-0.28.5.tar.gz
	tar -zxvf $<
	ln -s libgit2-0.28.5 libgit2
	touch $@

clean:
	rm -fr tags
	rm -fr boost*
	rm -fr libgit2*
	rm -fr fritzing-app
	rm -fr fritzing-parts


