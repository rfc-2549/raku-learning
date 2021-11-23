#!/usr/bin/rakudo


my $x = 10;

my $mtx = Lock.new;

my $t1 = Thread.new(
    name => "Thread 1",
    code => sub {
	   for $x .. 1000 {
		  $mtx.lock;
		  $x++;
		  $mtx.unlock;
	   }
    }
);

my $t2 = Thread.new(
    name => "Thread 1",
    code => sub {
	   for $x .. 1000 {
		  $mtx.lock;
		  $x--;
		  $mtx.unlock;
	   }

    }
);


$t1.run;
$t2.run;

$t1.join;
$t2.join;
say $x;

