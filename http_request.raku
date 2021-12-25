#!/usr/bin/rakudo

# A perl file which makes a HTTP request and uses parses the JSON

# zef install Curlie
# zef install JsonC

use Curlie;
use JsonC;

my \c = Curlie.new;

my %params = (name => "John",
		    surname => "Doe",
		    "ssn" => 133742069);

my $res = c.post("https://httpbin.org/post",
			  query => %params).res.content;

my %h = from-json($res);

for keys(%h{'args'}).sort -> $key {
	printf("The server returned: %s = %s\n",$key,
		  %h{'args'}{$key});
}

