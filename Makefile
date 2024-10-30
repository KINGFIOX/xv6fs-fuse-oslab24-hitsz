MOUNT_POINT = /mnt/xv6fs
PWD = /home/wangfiox/Documents/hitsz-ext2-fuse

all: xv6fs fs.img

xv6fs: ./src ./inc CMakeLists.txt
	cmake -S . -B build -G Ninja
	cmake --build build

fs.img: mkfs/mkfs README.md
	mkfs/mkfs fs.img README.md

mkfs/mkfs: mkfs/mkfs.c
	gcc -Wall -Werror -I. -o mkfs/mkfs mkfs/mkfs.c

run: xv6fs fs.img
	touch xv6fs.log
	$(PWD)/build/bin/xv6fs $(PWD)/xv6fs.log ./fs.img $(MOUNT_POINT)

umount:
	fusermount -u $(MOUNT_POINT)

ls:
	$(PWD)/a.out $(MOUNT_POINT)

gdb:
	make clean
	cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug -G Ninja
	cmake --build build
	make fs.img
	gdb $(PWD)/build/bin/xv6fs -ex "run $(PWD)/xv6fs.log $(PWD)/fs.img $(MOUNT_POINT)"

clean:
	rm -rf ./build 
	rm -rf ./fs.img
	rm -rf ./mkfs/mkfs
	rm -rf ./xv6fs.log
