# !/usr/local/bin/perl -w
# calculate_fasta_median_length.pl
# Geoffrey Hannigan
# Elizabeth Grice Lab
# University of Pennsylvania

# Set use
use strict;
use warnings;

# Set files to scalar variables
my $usage = "Usage: perl $0 <INFILE>";
my $infile = shift or die $usage;
open(my $IN, "<", "$infile") || die "Unable to open $infile: $!";

# Set variable for list of length values
my @lengths = ();
my $seq_length = -1;
my $result = 0;

# Assign lengths of each sequence to the array
while (my $line = <$IN>) {
	# Skip the sequence identifier lines
	if ($line =~ /\>/) {
		if ($seq_length != -1) {
			push @lengths, $seq_length;
		}
		$seq_length = 0;
		next;
	} else {
		# Add  line lengths to array
		chomp $line;
		$seq_length += length $line;
	}
}
if ($seq_length != -1) { # do not forget the last record
	push @lengths, $seq_length;
}

# Sort the length array
my @sorted_lengths = sort {$a <=> $b} @lengths;
# Assign array length to a variable
my $array_length = @sorted_lengths;

# Get the median of the array, depending on whether the link is even or odd
if ($array_length%2) {
	# Odd
	my $result = $sorted_lengths[($array_length/2)];
	printf $result."\t".$infile."\n";
} else {
	# Even
	my $one = $sorted_lengths[($array_length/2)-1];
	my $two = $sorted_lengths[($array_length/2)];
	my $result = ($one + $two) / 2;
	printf $result."\t".$infile."\n";
}

#Close out files
close($IN);
