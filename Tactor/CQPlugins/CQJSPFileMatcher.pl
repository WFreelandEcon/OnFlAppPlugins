#!/usr/bin/perl

sub basename {
	my ($c) = @_;
	my @a = split ('/', $c);
	return pop (@a);
}

sub baseurl {
	my ($u) = @_;
	if ($u ne "") {
		$u =~ m/^(http:\/\/.*?)\//;
		return $1;
	}
	else {
		return "http://localhost:4502";
	}
}

sub getprefix {
	my $cmd = "curl -s -u admin:admin $BASEURL/var/classes.1.json";
	print ("$cmd\n");
	my $r = `$cmd`;
	
	if ($r =~ /\"([a-z0-9\-]+)\":{/) {
		return "$1/";
	}
	else {
		return "";
	}
}

sub getfile {
	$BASEURL= baseurl ($CONTEXT{'CTX_URL'});
	$BASEPATH="/var/classes/" . getprefix();
	my ($file) = @_;
	my $out = "/tmp/$$-" . basename ($file);
	my $cmd = "curl -s -u admin:admin $BASEURL$BASEPATH$file > $out";
	print ("$cmd\n");
	system ("$cmd");

	$CONTEXT{'ACT_PATH'} = $out;
}

sub matches_context {
	$TEXT = $CONTEXT{'CTX_TEXT'};
	foreach (split ('[\n;]', $TEXT)) {
		$l = $_;
		if ($l =~ m/([a-z][a-zA-Z0-9_\.\$]+)\(([A-Za-z0-9_]+_jsp\.java):(\d+)\)/) {
			$CONTEXT{'ACT_PATH_LINE'} = $3;
			my @cl = split ('\.', "$1"); pop (@cl); pop (@cl);
			my $f = join ('/', @cl) . "/" . $2;
			getfile ($f);
			return 1;
		}
		elsif ($l =~ m/line: (\d+) in the jsp file: (.*?\.jsp)/) {
			$CONTEXT{'ACT_PATH_LINE'} = $1;
			$CONTEXT{'ACT_SEARCH_FILE'} = $2;
			$CONTEXT{'ACT_SEARCH_SCOPE'} = $ENV{'HOME'};			
			return 1;
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
