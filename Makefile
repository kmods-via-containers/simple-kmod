obj-m += simple-kmod.o
obj-m += simple-procfs-kmod.o

ifndef KVER
KVER=$(shell uname -r)
endif

ifndef KMODVER
KMODVER=$(shell git describe HEAD 2>/dev/null || git rev-parse --short HEAD)
endif

buildprep:
	# elfutils-libelf-devel is needed on EL8 systems
	sudo yum install -y gcc kernel-{core,devel,modules}-$(KVER) elfutils-libelf-devel
all:
	make -C /lib/modules/$(KVER)/build M=$(PWD) EXTRA_CFLAGS=-DKMODVER=\\\"$(KMODVER)\\\" modules
	gcc -o spkut ./simple-procfs-kmod-userspace-tool.c
clean:
	make -C /lib/modules/$(KVER)/build M=$(PWD) clean
	rm -f spkut
install:
	sudo install -v -m 755 spkut /bin/
	sudo install -v -m 755 -d /lib/modules/$(KVER)/
	sudo install -v -m 644 simple-kmod.ko        /lib/modules/$(KVER)/simple-kmod.ko
	sudo install -v -m 644 simple-procfs-kmod.ko /lib/modules/$(KVER)/simple-procfs-kmod.ko
	sudo depmod -a
