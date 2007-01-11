package PWSConfig;

sub setup_vars {
	my (%parms) = @_;
	my (%required, %missing, %vars);
	
	if (exists $parms{required} && $parms{required} =~ /\S/) {
		my @reqs = split(/,/, $parms{required});
		
		for (@reqs) {
			$required{$_} = 1;
		}
	}

	# read from commandline
	my ($var, $val);
	
	for (@ARGV) {
		($var, $val) = split(/=/, $_, 2);
		$vars{$var} = $val;
	}
	
	# check for required variables
	for (keys %required) {
		unless (exists $vars{$_} && $vars{$_} =~ /\S/) {
			$missing{$_} = 1;
		}
	}

	if (keys %missing) {
		die "$0: required variables missing: " . join(',', sort keys %missing) . "\n";
	}

	return \%vars;
}

1;
