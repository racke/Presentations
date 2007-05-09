#! /usr/bin/perl

use strict;
use warnings;

use IO::Socket::SSL;
use Mail::IMAPClient;
use PWSConfig;

my ($cref, $conn, $imap);

$cref = PWSConfig::setup_vars (required => 'server,user,password,folder');

unless ($conn = new IO::Socket::SSL("$cref->{server}:imaps")) {
	die "$0: imaps connection to $cref->{server} failed: $!\n";
}
							
$imap = new Mail::IMAPClient (Socket => $conn,
							  User => $cref->{user},
							  Password => $cref->{password});

# set state manually to "Connected"
$imap->{State} = 1;
$imap->login();

unless ($imap->login()) {
	die "Error: " . $imap->LastError() . "\n";
}

# get namespaces
my @refs = $imap->namespaces();

		
my @folders = $imap->folders();
my $count;

for (sort(@folders)) {
	print "$_ is a folder with ", $imap->message_count($_) || 0, " messages.\n";
}

my $msg = <<EOF;
From: racke\@linuxia.de
To: racke\@xxx.exp
Subject: Hello world

Hello everyone.
EOF

my $uid = $imap->append('INBOX', $msg);

if ($uid) {
	print "Appended message with uid $uid\n";
} else {
	warn "Append failed: $@\n";
}
