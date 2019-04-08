#!/usr/bin/perl

# To be called within a part directory

use strict;
my $part = shift;

opendir(my $dh, ".");
for my $pattern (readdir $dh) {
  next unless -d $pattern;
  next if -e "$pattern/index.yml";
  opendir(my $pdh, "$pattern");
  my @res = grep { /.yml$/ } readdir $pdh;
  closedir $pdh;
  next unless @res;
  my $patternLong = $pattern;
  $patternLong =~ s/([A-Z])/ $1/g;
  $patternLong =~ s/^\s*//;
  my $index = <<EOT;
pattern: $patternLong
category: $part
base: $part/$pattern
examples:
EOT
  for my $r (@res) {
    $index .= <<EOT;
- description:
  path: $r
EOT
   }
   print $pattern,"\n";
   open (my $f,">$pattern/index.yml");
   print $f $index;
   close $f
 }

closedir $dh
