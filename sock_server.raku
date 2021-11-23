#!/usr/bin/rakudo

# For some reason, you have to press return before getting a line sent
# by this, at least in socat.

my $listen = IO::Socket::INET.new(
    :listen,
    :localhost<127.0.0.1>,
    :localport<3333>
);

my $conn;

my $reader_sock = Thread.new(
    code => sub {
	   loop {
		  while my $buf = $conn.get {
			 say $buf;
		  }
	   }

    },
    name => "Reader thread"
);
my $writer_sock = Thread.new(
    code => sub {
	   loop {
		  my $input = get;
		  $conn.print($input ~ "\n");
	   }
    },
    name => "Writer thread"
);

$conn = $listen.accept;
$writer_sock.run;
$reader_sock.run;
$reader_sock.join;
$writer_sock.join;

