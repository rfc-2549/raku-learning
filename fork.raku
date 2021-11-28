#!/usr/bin/rakudo

# According to the official docs, there is no fork() in Raku, but you
# can use the C function to fork

# Para estar tan colgado hace falta echarle huevos
#    -- Robe Iniesta

use NativeCall;

sub fork( --> int32) is native("c",v6) {*}
sub getpid( --> int32) is native("c",v6) {*}

my $pid = fork();
if (!$pid == 0) {
	say "This is the child " ~ getpid();;

} else {
	say "This is the parent " ~ getpid();
}
