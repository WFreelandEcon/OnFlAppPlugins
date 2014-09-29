#!/usr/bin/perl

if (!$__RUNNING_AS_PERL_PLUGIN) {
	$CTX_TEXT = "";
	while (<STDIN>) {
		$CTX_TEXT .= "$_\n";
	}
	match_context ();
	print ("$ACT_FILENAME\n");
}

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

sub process_DOT {
	$TMPF = "/tmp/TextFilterMatcher$$.pdf";
	
	open (O, "| dot -Gmargin=\"0,0\" -Gbgcolor=\"transparent\" -Tpdf -o$TMPF");
	print (O "$CODE\n");
	close (O);
	if (!$?) {
		return $TMPF;
	}
	else {
		return "";
	}
}

sub matches_context {
	$HOME = $ENV{"HOME"};
	$TEXT = trim ($CONTEXT{"CTX_TEXT"});
	
	if ($TEXT =~ /^(di)?graph\s.*{.*}$/s) {
		$CODE = $TEXT;
		
		$CONTEXT{"ACT_DATA_TYPE"} = "PDF";
		$CONTEXT{"ACT_DATA_PATH"} = process_DOT ();
	
		return 1;
	}
	else {
		return 0;
	}
}
