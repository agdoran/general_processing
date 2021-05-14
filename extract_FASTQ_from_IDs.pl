#!/usr/bin/perl -w
use strict;

my %read_ids;

open(IDS, "$ARGV[0]") or die "Error opening the input list of read IDs\n";

while(my $ids = <IDS>){
	chomp $ids;

	# basic error handling of duplicates in the input read ID list - WARNING only
	if(exists $read_ids{$ids}){
		print "Warning! $ids found more than once in the input read ID list\n";

	}else{

		$read_ids{$ids} = $ids;

	}

}

close(IDS);

open(FASTQ, "<$ARGV[1]") or die "Error opening the input FASTQ file\n";

open(OUT, ">$ARGV[2]") or die "Error opening the output file containing reads of interest\n";

while(my $a = <FASTQ>){
	chomp $a;
	my $b = <>;
	my $c = <>;
	my $d = <>;

	chomp $b;
	chomp $c;
	chomp $d;

	my $id = $a;
	$id =~ s/ .*$//;

	if(exists $read_ids{$a}){

		print OUT "$a\n$b\n$c\n$d\n";

	}

}

close(OUT);
close(FASTQ);



