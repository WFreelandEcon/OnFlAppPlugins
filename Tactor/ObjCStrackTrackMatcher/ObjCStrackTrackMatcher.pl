#!/usr/bin/perl

sub find_mfile {
	my ($n) = @_;
	my $fl = "";
	open (IN, "mdfind -name '$n' |");
	while (<IN>) {
		chomp();
		if ($_ =~ /$n/) {
			$fl = $_;
			last;
		}
	}
	close (IN);
	return $fl;
}

sub grep_mfile {
	my ($f, $c) = @_;
	my $l = "";

	$c =~ s/:/:.*/g;

	my $cmd = "grep -n \"^\\\\s*-.*\\\\b$c\" \"$f\"";
	open (IN, "$cmd|");
	while (<IN>) {
		chomp();
		if (m/^(\d+):/) {
			$l = $1;
			last;
		}
	}
	close (IN);
	return $l;
}

sub matches_context {
	$TEXT = $CONTEXT{'CTX_TEXT'};
	foreach (split ('[\n;]', $TEXT)) {
		$l = $_;
		print ("$_\n");
		if ($l =~ m/-\[([A-Za-z0-9_]+) ([A-Za-z0-9_:]+)\]/) {
			$fl = find_mfile("$1.m");
			if ($fl ne "") {
				$l = grep_mfile($fl, $2);
				if ($l ne "") {
					$CONTEXT{'ACT_PATH_LINE'} = $l;
					$CONTEXT{'ACT_PATH'} = $fl;
					return 1
				};
			}
		}

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
