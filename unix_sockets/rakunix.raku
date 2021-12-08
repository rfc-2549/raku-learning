#!/usr/bin/raku

# Raku has a GOOD object oriented interface.

use NativeCall;

constant LIBPATH = "$*CWD/rakunix";

sub create_socket(--> int32) is native(LIBPATH) { * }
sub connect_socket(int32, Str --> int32) is native(LIBPATH) { * }
sub write_to_sock(int32, Str, int32 --> int32) is native(LIBPATH) { * }
sub close_socket(int32 --> int32) is native(LIBPATH) { * }
our sub cread(int32, buf8 is rw, int32 --> int32) is native('c',v6) is symbol('read') { * }

class Socket {
	has $.sockfd;
	
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
	
	method read() {
		my $c = 1;
		my $buf = buf8.allocate(1);
		my $res;
		while $c > 0 {
			$c = cread(self.sockfd, $buf, 1);
			$res ~= $buf.decode("utf-8");
		}
		return $res;
	}

	method close() {
		close_socket(self.sockfd);
	}
}

my $sock = Socket.new("socket1");
if $sock.sockfd == -1 {
	say "die";
	exit;
}

$sock.put("Hello world!");
print $sock.read();
