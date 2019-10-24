/**
 *  simple-procfs-kmod-userspace-tool.c -  Simple tool that reads/writes proc file
 *
 */

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

// Code taken from https://github.com/dev-area/proctest
// and modified slightly to use the `simple-procfs-kmod` file
// under the proc filesystem.

#define PROCFS_FILE_PATH "/proc/simple-procfs-kmod"

void main(int argc, char *argv[])
{
	char buf[100];
	int fd = open(PROCFS_FILE_PATH, O_RDWR);
	read(fd, buf, 100);
	puts(buf);

	lseek(fd, 0 , SEEK_SET);
	write(fd, argv[1], 100);
	
	lseek(fd, 0 , SEEK_SET);
	read(fd, buf, 100);
	puts(buf);
}	
