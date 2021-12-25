#!/usr/bin/rakudo

# Logger tester for raku, apparently

# Better than log4j

use Log::Async;

logger.send-to($*ERR);

start {
	while True {
		my $r = (^1000000).pick;
		if $r == 5 {
			debug "Got an error";
		}
	}
	
}

while True {
	say "I'm doing stuff!";
	sleep(0.5);
}
