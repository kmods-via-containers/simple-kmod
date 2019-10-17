obj-m += simple-kmod.o

ifndef KVER
KVER=$(shell uname -r)
endif

buildprep:
	sudo yum install -y make gcc kernel-{core,devel,modules}-$(KVER)
all:
	make -C /lib/modules/$(KVER)/build M=$(PWD) modules
clean:
	make -C /lib/modules/$(KVER)/build M=$(PWD) clean
install:
	sudo install -v -m 755 -d /lib/modules/$(KVER)/
	sudo install -v -m 644 simple-kmod.ko /lib/modules/$(KVER)/simple-kmod.ko
