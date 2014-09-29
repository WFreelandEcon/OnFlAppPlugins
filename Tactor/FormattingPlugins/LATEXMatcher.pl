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

sub process_TEX {
	$TMPF = "/tmp/LATEXMatcher$$.tex";
	$TMPO = "/tmp/LATEXMatcher$$.pdf";
	$CODE = <<EOF;
\\documentclass[12pt]{report}
\\title
\\author
\\pagestyle{empty}

\\usepackage{amsmath}
\\usepackage{latexsym}

\\begin{document}
$CODE
\\end{document}
EOF
	write_temp ($TMPF, $CODE);
	system ("pdflatex -interaction=nonstopmode -output-directory /tmp $TMPF && rm $TMPF");
	if (-f "$TMPO") {
		return "$TMPO";
	}
	else {
		return "";
	}
}

sub matches_context {
	$HOME = $ENV{"HOME"};
	$TEXT = trim ($CONTEXT{"CTX_TEXT"});
	
	if ($TEXT =~ m/^(\$\$?.*?\$?\$)$/s || $TEXT =~ m/^(\\\[.*?\$?\\\])$/s) {
		$CODE = $1;
		$CONTEXT{"ACT_DATA_TYPE"} = "NSPDFPboardType";
		$CONTEXT{"ACT_DATA_PATH"} = process_TEX ();
		return 1;
	}
	if ($TEXT =~ m/^(\\[a-z]+\{.*\}.*?\\end(\{.*\}))$/s) {
		$CODE = $1;
		$CONTEXT{"ACT_DATA_TYPE"} = "NSPDFPboardType";
		$CONTEXT{"ACT_DATA_PATH"} = process_TEX ();
		return 1;
	}
	else {
		return 0;
	}
}
