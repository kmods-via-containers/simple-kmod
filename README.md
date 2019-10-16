# simple-kmod

Simple kmod example taken from [tldp.org](https://www.tldp.org/LDP/lkmpg/2.6/html/x121.html).

To build on Fedora, first install:

```
sudo dnf install kernel-devel make gcc
```

Build using:

```
make all
```

Load module:

```
sudo insmod hello-1.ko
```
