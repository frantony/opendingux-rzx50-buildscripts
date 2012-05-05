#!/bin/sh

SRC_DIR=src
SRC_URL_PREFIX=http://prizma.bmstu.ru/rzx50-storage/opendingux-rzx50-20120331/src

PACKAGESRO_DIR=packages-ro
PACKAGESRO_URL_PREFIX=http://prizma.bmstu.ru/rzx50-storage/opendingux-rzx50-20120331/packages-ro

mkdir -p $SRC_DIR
( cd $SRC_DIR; wget -c http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.14.1.tar.bz2 )
( cd $SRC_DIR; wget -c http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.34.tar.bz2 )

for i in \
	alsa-lib-1.0.24.1.tar.bz2 \
	alsa-utils-1.0.22.tar.bz2 \
	arkanoid-1.1.tar.gz \
	atari800-2.2.1-src.tar.gz \
	aumix-2.8.tar.bz2 \
	autoconf-2.65.tar.bz2 \
	automake-1.11.1.tar.bz2 \
	binutils-2.21.1a.tar.bz2 \
	busybox-1.17.4.tar.bz2 \
	color-lines-sdl-55.tar.gz \
	confuse-2.6.tar.gz \
	curl-7.21.2.tar.bz2 \
	czdoom-src.tar.gz \
	dialog-1.1-20100428.tgz \
	dingoo-digger-r8.tar.gz \
	dingoo-tvout-opendingux.tar.gz \
	dingux-commander-2.1-rzx50-20120216.tar.gz \
	dingux-spout.tar.gz \
	dingux-write_1.1.0.tar.gz \
	dmalloc-5.4.3.tgz \
	dosbox_0.74.orig.tar.gz \
	dosfstools-3.0.10.tar.gz \
	e2fsprogs-1.41.12.tar.gz \
	expat-2.0.1.tar.gz \
	fakeroot_1.9.5.tar.gz \
	fceu_0.98.12.orig.tar.gz \
	fceu320_0.3OD.tar.gz \
	file-5.04.tar.gz \
	flac-1.2.1.tar.gz \
	fmtools-2.0.1.tar.gz \
	freetype-2.3.12.tar.bz2 \
	gcc-4.4.6.tar.bz2 \
	gdb-7.1.tar.bz2 \
	genext2fs-1.4.1.tar.gz \
	gettext-0.16.1.tar.gz \
	gmenu2x-local.tar.gz \
	gmp-5.0.1.tar.bz2 \
	gmu-0.8.0BETA1.tar.gz \
	gnuboy.svn.tar.gz \
	gp2xpectrum.tar.gz \
	GPmark004_source.tar.gz \
	greader2x_Dingux.tar.gz \
	heartalien-1.2.2.tar.gz \
	htop-0.9.tar.gz \
	i2c-tools-3.0.2.tar.bz2 \
	joystick_20051019-2.diff.gz \
	joystick_20051019.orig.tar.gz \
	jpegsrc.v6b.tar.gz \
	kexec-tools-2.0.1.tar.bz2 \
	last-mission-0.6.tar.gz \
	libaio-0.3.109.tar.bz2 \
	libao-1.1.0.tar.gz \
	libconfig-1.3.tar.gz \
	libevent-1.4.12-stable.tar.gz \
	libgcrypt-1.4.6.tar.bz2 \
	libgpg-error-1.8.tar.bz2 \
	libiconv-1.12.tar.gz \
	libid3tag-0.15.1b.tar.gz \
	liblockfile_1.08-4.debian.tar.bz2 \
	liblockfile_1.08.orig.tar.gz \
	libmad-0.15.1b.tar.gz \
	libmikmod-3.1.11.tar.gz \
	libogg-1.1.4.tar.gz \
	liboil-0.3.15.tar.gz \
	libpng-1.2.46.tar.bz2 \
	libsndfile-1.0.25.tar.gz \
	libtheora-1.0.tar.bz2 \
	libtool-2.2.10.tar.gz \
	libungif-4.1.4.tar.bz2 \
	libvorbis-1.2.3.tar.gz \
	libxml2-sources-2.7.7.tar.gz \
	lmbench-3.0-a9.tgz \
	lockfile-progs_0.1.15.tar.gz \
	lrzsz-0.12.20.tar.gz \
	lsof_4.81.tar.bz2 \
	lzo-2.03.tar.gz \
	m4-1.4.9.tar.bz2 \
	madplay-0.15.2b.tar.gz \
	memstat_0.8.tar.gz \
	mininit-r194.tar.gz \
	mpfr-3.0.0.tar.xz \
	mpg123-0.66.tar.bz2 \
	nano-2.2.5.tar.gz \
	ncurses-5.7.tar.gz \
	netperf-2.4.5.tar.gz \
	newt-0.51.0.tar.bz2 \
	opendingux-rzx50-buildroot.git.tar.gz \
	opentyrian-hg1000.tar.gz \
	pkg-config-0.23.tar.gz \
	popt-1.15.tar.gz \
	powermanga-0.90.tgz \
	profadeluxe-1.0.tar.gz \
	pwswd-master.tar.gz \
	readline-6.1.tar.gz \
	REminiscence-0.2.1.tar.bz2 \
	rzx50-tools-20120317.tar.gz \
	screen-4.0.2.tar.gz \
	scummvm_1.4.1.orig.tar.bz2 \
	SDL-1.2.15.tar.gz \
	SDL_gfx-2.0.19.tar.gz \
	SDL_image-1.2.6.tar.gz \
	SDL_mixer-1.2.11.tar.gz \
	SDL_net-1.2.7.tar.gz \
	SDL_sound-1.0.3.tar.gz \
	SDL_ttf-2.0.9.tar.gz \
	setserial_2.17-45.2.diff.gz \
	setserial_2.17.orig.tar.gz \
	slang-1.4.5-mini.tar.bz2 \
	snes9x_20110923.tar.gz \
	speex-1.2rc1.tar.gz \
	spout_src.tar.bz2 \
	stella-3.5.5-src.tar.gz \
	strace-4.5.20.tar.bz2 \
	sysfsutils-2.1.0.tar.gz \
	taglib-1.5.tar.gz \
	timidity.tar.gz \
	tremor-16259.tar.gz \
	uClibc-0.9.32.1.tar.xz \
	uClibc-locale-030818.tgz \
	unrealspeccyp.tar.gz \
	viewimage-1.2.1.tar.gz \
	vorton-beta2.tar.gz \
	which-2.20.tar.gz \
	Wolf4SDL-1.7-src.tar.gz \
	zlib-1.2.5.tar.bz2 \
	; do

	( cd $SRC_DIR; wget -c $SRC_URL_PREFIX/$i )
done

mkdir -p $PACKAGESRO_DIR
for i in \
	atari2600_samples.tar.gz \
	atari800_roms.tar.gz \
	czdoom-config.tar.gz \
	czdoom-freedoom.tar.gz \
	dingux-gchess.tar.gz \
	fceu320.tar.gz \
	fceu-conf.tar.gz \
	frontend_start_gmenu2x.tar.gz \
	gameboy_samples.tar.gz \
	giana.tar.gz \
	gmenu2x_Default_skin.tar.gz \
	gmenu2x_default_wallpaper_pawn.tar.gz \
	gmenu2x_rzx50_conf.tar.gz \
	gmenu2x_wallpapers-exl.tar.gz \
	kexec-static.tar.gz \
	nes_samples.tar.gz \
	opendingux-loader.tar.gz \
	opentyrian-data.tar.gz \
	path-between-the-towers.tar.gz \
	pwswd_conf.tar.gz \
	scummvm_conf.tar.gz \
	scummvm_samples.tar.gz \
	snes_samples.tar.gz \
	supertux.tar.gz \
	zxspectrum_samples.tar.gz \
	; do

	( cd $PACKAGESRO_DIR; wget -c $PACKAGESRO_URL_PREFIX/$i )
done

#( cd $SRC_DIR; wget -c http://horms.net/projects/kexec/kexec-tools/kexec-tools-2.0.1.tar.gz )
