#!/usr/bin/raku

sub counter(Int $n) {
	for 1..$n -> $i {
		if $n == 323232 {
			return $i
		}
	}
}

my $promise = start {
	counter(20000000)
};

$promise.then({say .result}); # Will print "True" after finishing.

say "I'm doing other stuff";
say "Blah, blah";
$promise.result; # Waits for the thing to finish

