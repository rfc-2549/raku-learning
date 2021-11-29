#!/usr/bin/rakudo

# This program uses the NCurses module and Threads to do something
# very simple, but, eh, using NCurses and threads.

# zef install NCurses

use NCurses;

my Lock $mtx = Lock.new;

my Thread $t1 = Thread.new(
	name => "Thread 1",
	code => sub {
		for 1..1000 -> $i {
			$mtx.lock;
			mvprintw(0,0, sprintf("%i",$i));
			nc_refresh;
			$mtx.unlock;
		}
	}
);

my Thread $t2 = Thread.new(
	name => "Thread 2",
	code => sub {
		for 1..10000 -> $i {
			$mtx.lock;
			mvprintw(1,0, sprintf("%i",$i));
			nc_refresh;
			$mtx.unlock;
		}
	}
);

my $win = initscr();

$t1.run();
$t2.run();

$t1.join();
$t2.join();

getch();

LEAVE {
    delwin($win) if $win;
    endwin;
}
