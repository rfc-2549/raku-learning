#!/usr/bin/rakudo

my $fh = open "test", :r ;

while my $line = $fh.slurp {
	print $line;
}
