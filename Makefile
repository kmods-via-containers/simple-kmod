obj-m += hello-1.o

ifndef KVER
KVER=$(shell uname -r)
endif

all:
	make -C /lib/modules/$(KVER)/build M=$(PWD) modules
clean:
	make -C /lib/modules/$(KVER)/build M=$(PWD) clean
