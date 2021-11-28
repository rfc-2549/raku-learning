#!/usr/bin/rakudo


for 1..100 -> $i {
	given $i {
		when $i % 15 == 0 {say "FizzBuzz"}
		when $i % 5  == 0 {say "Buzz"}
		when $i % 3  == 0 {say "Fizz"}
		say $i
	}
}
