#! /usr/bin/perl

use strict;
use warnings;

use Cwd;

use ClamAV::Client;

# initiate ClamAV object
my $scanner = new ClamAV::Client;

unless (defined $scanner && $scanner->ping()) {
	die "$0: connection to ClamAV daemon failed\n";
}

my $dir = cwd();

# scan files from commandline
for (@ARGV) {
	if (-f) {
		my ($file, $result) = $scanner->scan_path("$dir/$_");

		if ($result) {
			print "$0: file $_ INFECTED: $result\n";
		} else {
			print "$0: file $_ OK\n";
		}
	}
}
