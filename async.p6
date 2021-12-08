#!/usr/bin/raku

sub counter(Int $n) {
	for 0..$n -> $i {
		if $i == 21474834 {
			return "There";
		}
	}
}

my $promise = start {
	counter(21474834);
};

$promise.then({say .result}); # Will print "There" after finishing. 

say "I'm doing other stuff";
say "Blah, blah";
sleep(1000); # Simulate stuff-doing
