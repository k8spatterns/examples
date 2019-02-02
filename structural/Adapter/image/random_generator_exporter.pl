#!/usr/bin/perl
my $log_file = $ENV{'LOG_FILE'};

use base qw(Net::Server::HTTP);
use Text::CSV qw(csv);
use strict;
# Startup HTTP server
__PACKAGE__->run(port  => 9889);

# Run request loog
sub process_http_request {
  my $self = shift;
  print "Content-type: text/plain\n\n";
  print &extract_metrics();
}

sub extract_metrics {
  my $data = csv(in => $log_file);

  my $total_nanos = 0;
  my $count = 0;
  while (my $row = shift @$data) {
    # 3rd column is the time in nano
    $total_nanos += $row->[2];
    $count++;
  }
  my $total_seconds = $total_nanos / (1000 * 1000 * 1000);
  return <<EOT;
random_generator_count $count
random_generator_seconds_total $total_seconds
EOT
}
