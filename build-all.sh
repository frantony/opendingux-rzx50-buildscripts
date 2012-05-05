#!/bin/sh

CONFIGS="rzx50-20120331"

for i in $CONFIGS;
do
	./build.sh --config build-configs/$i \
		--build-toolchain \
		--clean-out-dir \
		--build-rootfs \

	if [ "$?" != "0" ]; then
		exit 1
	fi

	# quick & dirty
	rm -rf packages/

	./build.sh --config build-configs/$i \
		--build-linux \
		--build-packages \

	if [ "$?" != "0" ]; then
		exit 1
	fi

	# quick & dirty
	cp -av packages-ro/* packages/

	./build.sh --config build-configs/$i \
		--make-od-archive
	if [ "$?" != "0" ]; then
		exit 1
	fi
done
