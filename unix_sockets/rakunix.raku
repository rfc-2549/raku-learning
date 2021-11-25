#!/usr/bin/rakudo

use NativeCall;

constant LIBPATH = "$*CWD/rakunix";
sub create_socket(--> int32) is native(LIBPATH) { * }
sub connect_socket(int32, Str --> int32) is native(LIBPATH) { * }
sub write_to_sock(int32, Str, int32 --> int32) is native(LIBPATH) { * }

my int32 $sockfd = create_socket();
connect_socket($sockfd, "socket");

my Str $string = "Hello from Raku!\n";
my Int $len = $string.chars;

write_to_sock($sockfd, $string, $len); 
