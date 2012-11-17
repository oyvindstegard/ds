#!/usr/bin/env perl
use strict;
my $mtime_newest = 0;
my $path_newest = "";
sub traverse {
    my $path = $_[0];
    my @stats = stat($path);
    if (@stats) {
        my $mtime = $stats[9];
        if ($mtime > $mtime_newest) {
            $mtime_newest = $mtime;
            $path_newest = $path;
        }
    }
    if (-d "$path" && !(-l "$path")) {
        my $DH;
        opendir($DH, $path) or return;
        while (defined (my $entry = readdir($DH))) {
            next if ($entry eq "." || $entry eq "..");
            &traverse($path . "/" . $entry);
        }
        closedir($DH);
    }
}

foreach my $path (@ARGV) {
    &traverse($path);
}

print "$mtime_newest\t$path_newest\n";
