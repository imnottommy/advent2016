use strict;
use warnings;

use Digest::MD5 qw(md5_hex);

my $salt = "cuanljph";

my $t = 0;
my %cache;

my @keys;
while (scalar @keys < 64) {
	my $hash = the_hash($salt . $t);
	if (is_key($hash, $salt, $t)) {
		print "found key at $t\n";
		push @keys, $t;
	}

	$t++;
}

sub is_key {
	(my $hash, my $salt, my $i) = @_;

	my $repeat = find3($hash);

	if (not defined $repeat) {
		return 0;
	}
	for (my $j = $i +1; $j < ($i + 998); $j++) {
		my $hash2 = the_hash($salt . $j);
		if (defined find5($hash2, $repeat)) {
			return 1
		}
	}

	return 0;
}

sub the_hash {
	(my $text) = @_;

	if (not defined $cache{$text}) {
		$cache{$text} = stretch(md5_hex($text));
	}
	
	return $cache{$text};
}

sub stretch {
	(my $hash) = @_;

	for (my $i = 0; $i < 2016; $i++) {
		$hash = md5_hex($hash);
	}

	return $hash;
}

sub find3 {
	(my $hash) = @_;

	if ($hash =~ /(\w)\1\1/) {
		return $1
	}

	return undef
}
sub find5 {
	(my $hash, my $repeat) = @_;

	if ($hash =~ /($repeat){5}/) {
		return $1
	}

	return undef
}
