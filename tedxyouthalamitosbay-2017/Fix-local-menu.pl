#!/usr/bin/perl 
use strict;

print "Hello, World!\n";


# fix("index.html");
# exit(0);

dir_listing('.');

my @paths;
sub dir_listing {
    my ($root) = @_;
    $root .= '/' unless $root =~ /\/$/;
    for my $f (glob "$root*"){
        push @paths, $f;
        dir_listing($f) if -d $f;
    }
    return @paths;
}

for my $rec (@paths) {
    if ($rec =~ /\.html$/) {
        # print "$rec\n";
        fix($rec);
    }
}


sub fix {
    my $filename = shift;

    print "Parse $filename\n";
    
    open (FH, '<', $filename) or die "Unable to open file, $!";

    my $html = '';
    while (my $line = <FH>) {
      # chomp $row;
      $html .= $line;
    }

    close FH;


    my $from = q{http:\/\/tedxyouth\.wpengine\.com\/contact};
    my $to   = q{../contact/index.html};
    $html =~ s/$from/$to/;

    my $from = q{http:\/\/tedxyouth\.wpengine\.com\/#eventinformation};
    my $to   = q{../event/index.html};
    $html =~ s/$from/$to/;


    # $filename = "index-1.html";
    open(FH, '>', $filename) or die $!;

    print FH $html;

    close FH;
}
