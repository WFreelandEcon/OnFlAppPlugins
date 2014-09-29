#!/usr/bin/perl

sub trim {
    my @out = @_;
    for (@out) {
        s/^\s+//;
        s/\s+$//;
    }
    return wantarray ? @out : $out[0];
}

sub write_tmp {
	$TEXT .= ";" if ($TEXT !~ /;$/);

	my $t = "/tmp/statements" . time() . "-$$.sql";
	open (O, "> $t");
	print (O $TEXT);
	close (O);

	return $t;
}

sub matches_context {
	$HOME = $ENV{"HOME"};
	$TEXT = $CONTEXT{'CTX_TEXT'};
	$TEXT = trim ($TEXT);
	
	if (($TEXT =~ m/^SELECT.*FROM\s/si) || 
		  ($TEXT =~ m/^UPDATE.*SET\s/si) || 
		  ($TEXT =~ m/^DELETE.*FROM\s/si) || 
		  ($TEXT =~ m/^CREATE.*\(.*\).*/si) || 
		  ($TEXT =~ m/^ALTER\s/si) || 
		  ($TEXT =~ m/^INSERT\s.*INTO.*VALUES/si) 
		) {

		$TEXT =~ s/\"\s*\+.*?\+\s*\"/?/g;
		$TEXT =~ s/\"\s*\+[^"]*?//g;
		$TEXT =~ s/[^"]*?\s*\+\"//g;
		$TEXT =~ s/\"//g;

		$CONTEXT{'ACT_PATH'}=write_tmp ();
		$CONTEXT{'ACT_LABEL'}="execute SQL " . substr ($TEXT, 0, 10);
		return 1;
	}

	return 0;
}

if ($ARGV[0] eq "--test") {
	my $txtin = "";
	while (<STDIN>) {
		$txtin .= $_;
	}

	%CONTEXT = ();
	$CONTEXT{'CTX_TEXT'} = $txtin;

	my $rv = matches_context ();
	if ($rv) {
		foreach (keys (%CONTEXT)) {
			print ($_ . "=" . $CONTEXT{$_} . "\n");
		}
	}
}
