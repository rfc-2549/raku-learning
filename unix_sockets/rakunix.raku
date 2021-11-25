#!/usr/bin/raku

# Raku has a GOOD object oriented interface.

use NativeCall;

constant LIBPATH = "$*CWD/rakunix";

sub create_socket(--> int32) is native(LIBPATH) { * }
sub connect_socket(int32, Str --> int32) is native(LIBPATH) { * }
sub write_to_sock(int32, Str, int32 --> int32) is native(LIBPATH) { * }
sub close_socket(int32 --> int32) is native(LIBPATH) { * }

class Socket {
	has int32 $.sockfd;
	
	method new ($path) {
		my $mfd = create_socket();
		connect_socket($mfd, $path);
		self.bless(sockfd => $mfd);
	}

	method send($str) {
		my $len = $str.chars;
		write_to_sock(self.sockfd, $str, $len);
	}
	method put($str) {
		my $len = $str.chars + 1;
		write_to_sock(self.sockfd, $str ~ "\n", $len);

	}
	method close() {
		close_socket(self.sockfd);
	}

}

my $sock = Socket.new("socket");

$sock.put("Hello!");
$sock.close();

