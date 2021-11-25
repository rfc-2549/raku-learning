#!/usr/bin/raku

# Raku has a GOOD object oriented interface.

use NativeCall;

constant LIBPATH = "$*CWD/rakunix";

sub create_socket(--> int32) is native(LIBPATH) { * }
sub connect_socket(int32, Str --> int32) is native(LIBPATH) { * }
sub write_to_sock(int32, Str, int32 --> int32) is native(LIBPATH) { * }
sub read_from_sock(int32, buf8) is native(LIBPATH) { * }
sub close_socket(int32 --> int32) is native(LIBPATH) { * }

class Socket {
	has int32 $.sockfd;
	
	method new ($path) {
		my $mfd = create_socket();
		$mfd = -1 if connect_socket($mfd, $path); 
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
	method read($buf) {
		read_from_sock(self.sockfd, $buf);
	}
	method close() {
		close_socket(self.sockfd);
	}

}

my $sock = Socket.new("socket");
my $buf = buf8;

if $sock.sockfd == -1 {
	say "Error creating socket, dying!";
	exit;
}

$sock.put("Hello!");
$sock.read($buf);

print $buf.decode("utf-8");

$sock.close;
