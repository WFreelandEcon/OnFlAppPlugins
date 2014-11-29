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
	$BASEURL= baseurl ($ENV{'CTX_URL'});
	$BASEPATH="/var/classes/" . getprefix();
	my ($file) = @_;
	my $out = "/tmp/$$-" . basename ($file);
	my $cmd = "curl -s -u admin:admin $BASEURL$BASEPATH$file > $out";
	print ("$cmd\n");
	system ("$cmd");

	print ("ACT_PATH=$out\n");
}

sub matches_context {
	foreach (split ('[\n;]', $TEXT)) {
		$l = $_;
		if ($l =~ m/([a-z][a-zA-Z0-9_\.\$]+)\(([A-Za-z0-9_]+_jsp\.java):(\d+)\)/) {
			print ("ACT_PATH_LINE=$3\n");
			my @cl = split ('\.', "$1"); pop (@cl); pop (@cl);
			my $f = join ('/', @cl) . "/" . $2;
			getfile ($f);
			exit 0;
		}
		elsif ($l =~ m/line: (\d+) in the jsp file: (.*?\.jsp)/) {
			print ("ACT_PATH_LINE=$1\n");
			print ("ACT_SEARCH_FILE=$2\n");
			print ("ACT_SEARCH_SCOPE=" . $ENV{'HOME'} . "\n");			
			exit 0;
		}
	}
	exit 1;
}

my $txtin = "";

while (<STDIN>) {
	$txtin .= $_;
}

$TEXT = $txtin;

matches_context ();
