#include <stdio.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>
#include <string.h>

int
create_socket()
{
	int sockfd = socket(PF_UNIX, SOCK_STREAM, 0);
	if(sockfd == -1) {
		fprintf(stderr,"rakunix: error creating socket\n");
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
		fprintf(stderr,"rakunix: error connecting to socket\n");
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
close_socket(int sockfd)
{
	close(sockfd);
	return 0;
}
