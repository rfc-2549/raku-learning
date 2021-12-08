#include <stdio.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>

int
create_socket()
{
	int sockfd = socket(PF_UNIX, SOCK_STREAM, 0);
	if(sockfd == -1) {
		fprintf(stderr,"rakunix: error creating socket: %s\n",strerror(errno));
		return -1;
	} else {
		return sockfd;
	}
}

int
connect_socket(int sockfd, const char *path)
{
	struct sockaddr_un addr;
	addr.sun_family = AF_UNIX;
	strcpy(addr.sun_path,path);
	int return_value = connect(sockfd, (struct sockaddr*)&addr, sizeof(addr));
	if(return_value == -1) {
		fprintf(stderr,"rakunix: error connecting to socket: %s\n",strerror(errno));
		return -1;
	} else {
		return 0;
	}
}

int
write_to_sock(int sockfd, const char *s, int len)
{
	int return_value = send(sockfd, s, len, 0);
	if(return_value < 0) {
		fprintf(stderr,"rakunix: Error sending message\n");
		return -1;
	} else {
		return return_value;
	}
}

int
read_from_sock(int sockfd, char *xt_buf)
{
	int c;
	int i = 0;
     char buf[8192];
	while((c = read(sockfd, buf, 1)) > 0) {
		strncpy(xt_buf, buf, c);
		i++;
	}
	return i;
}

int
close_socket(int sockfd)
{
	close(sockfd);
	return 0;
}
