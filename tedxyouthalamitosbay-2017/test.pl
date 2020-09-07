#!/bin/perl


use Path::Class;

my @files;
dir('.')->recurse(callback => sub {
    my $file = shift;
    if($file =~ /htm/) {
        push @files, $file->absolute->stringify;
    }
});

for my $file (@files) {
    # ...
}