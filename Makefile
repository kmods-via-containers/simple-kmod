obj-m += hello-1.o

ifndef KVER
KVER=$(shell uname -r)
endif

buildprep:
	sudo yum install make gcc kernel-{core,devel,modules}-$(KVER)
all:
	make -C /lib/modules/$(KVER)/build M=$(PWD) modules
clean:
	make -C /lib/modules/$(KVER)/build M=$(PWD) clean
install:
	sudo install -v -m 755 -d /lib/modules/$(KVER)/
	sudo install -v -m 644 hello-1.ko /lib/modules/$(KVER)/hello-1.ko
