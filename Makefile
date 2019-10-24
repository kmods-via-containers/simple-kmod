obj-m += simple-kmod.o
obj-m += simple-procfs-kmod.o

ifndef KVER
KVER=$(shell uname -r)
endif

ifndef KMODVER
KMODVER=$(shell git describe HEAD 2>/dev/null || git rev-parse --short HEAD)
endif

buildprep:
	sudo yum install -y gcc kernel-{core,devel,modules}-$(KVER)
all:
	make -C /lib/modules/$(KVER)/build M=$(PWD) EXTRA_CFLAGS=-DKMODVER=\\\"$(KMODVER)\\\" modules
clean:
	make -C /lib/modules/$(KVER)/build M=$(PWD) clean
install:
	sudo install -v -m 755 -d /lib/modules/$(KVER)/
	sudo install -v -m 644 simple-kmod.ko        /lib/modules/$(KVER)/simple-kmod.ko
	sudo install -v -m 644 simple-procfs-kmod.ko /lib/modules/$(KVER)/simple-procfs-kmod.ko
	sudo depmod -a
