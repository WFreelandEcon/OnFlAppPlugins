#!/usr/bin/perl

################################################################
## looks for HTML fragment and generates RTF data file out of it
## e.g. <b>bold text</b>
## 
## ACT_DATA_TYPE is set to RTF
## ACT_DATA_FILE is temporary file containing the actual RTF
##
##	NOTE: if you want to modify this script, copy it to your home directory first
##	~/Library/Application Support/Tactor/PlugIns/
##	Otherwise it may get overwriten next time you update Tactor
################################################################

sub trim {
	my @out = @_;
	for (@out) {
		s/^\s+//;
		s/\s+$//;
	}
	return wantarray ? @out : $out[0];
}

sub write_temp {
	my ($file, $text) = @_;
	open (O, "> $file");
	print (O $text);
	close (O);
}

sub process_HTML_RTF {
	$TMPF = "/tmp/TextFilterMatcher$$" . time() . ".rtf";
	$CODE = "<HTML><HEAD><TITLE></TITLE></HEAD><BODY>$TEXT\n</BODY></HTML>\n";

	open (O, "| textutil -convert rtf -stdout -stdin -font Helvetica -fontsize 10 -format html > $TMPF");
	print (O $CODE);
	close (O);
	
	if (!$?) {
		return $TMPF;
	}
	else {
		return "";
	}
}

sub process_HTML {
	$TMPF = "/tmp/TextFilterMatcher$$.html";
	$CODE = "<HTML><HEAD><TITLE></TITLE></HEAD><BODY>$CODE\n</BODY></HTML>\n";

	open (O, "> $TMPF");
	print (O $CODE);
	close (O);

	return $TMPF;
}

sub matches_context {
	$HOME = $ENV{"HOME"};
	$TEXT = trim ($CONTEXT{"CTX_TEXT"});
	
	if ($TEXT =~ /^<[a-zA-Z0-9]+.*<\/[a-zA-Z0-9]+>$/s) {
		$CONTEXT{"ACT_DATA_TYPE"} = "RTF";
		$CONTEXT{"ACT_DATA_PATH"} = process_HTML_RTF ();
		return 1;
	}
	else {
		return 0;
	}
}

#################################################################
## for testing purposes
#################################################################

if ($ARGV[0] eq "--test") {
	my $text = "";
	while (<STDIN>) {
		$text .= "$_";
	}
	
	$CONTEXT{'CTX_TEXT'} = $text;
	
	if (matches_context ()) {
		print ($CONTEXT{'ACT_DATA_TYPE'} . "\n");
		print ($CONTEXT{'ACT_DATA_PATH'} . "\n");
	}
}
