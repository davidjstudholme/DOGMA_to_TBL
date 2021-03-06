#!/usr/bin/perl -w

use strict;
use warnings;
use Bio::SeqIO;

my $usage = "Usage: $0 <DOGMA output file> <fasta file> <locus-tag prefix>";

my $infile = shift or die "$usage\n";
my $sequence_file = shift or die "$usage\n";
my $locus_tag_prefix = shift or die "$usage\n"; # e.g. 'GW17_c';

my %mapping = %{ get_mapping_of_amino_acid_codes() };

### Get ID of chloroplast sequence
my $inseq = Bio::SeqIO->new('-file' => "<$sequence_file",
			    '-format' => 'fasta' ) ;
my $seq_id;
my $seq_length;

while (my $seq_obj = $inseq->next_seq ) {
  
    my $id = $seq_obj->id ;
    my $seq = $seq_obj->seq ;
    my $desc = $seq_obj->description ;

    die "Multiple sequences in FastA file" if defined $seq_id;
    
    $seq_id = $id;
    $seq_length = length($seq);
}


my $i = 1;


### Print "header"
print ">Feature $seq_id\n";
print "1\t$seq_length\tREFERENCE\n";
print "\t\t\tPBARC\t12345\n";


open (FILE, "<$infile") or die "$!";
while (<FILE>) {
    chomp;
    my @fields = split /\t/;
 
    if (@fields == 4) {
	my ($start, $stop, $name, $strand) = @fields;
	
	if ($strand eq '+') {
	    ### fine
	} elsif ($strand eq '-') {
	    ### Reverse
	    ($start, $stop) = ($stop, $start);
	} else {
	    ### Gone wrong
	    die "strand = '$strand'";
	}


	
	my $feature_type = 'CDS';
	my $product;

	### Is it a tRNA gene?
	if ($name =~ m/^trn/) {
	    $feature_type = 'tRNA';
	    $product = $name;
	}
	### Is it a rRNA gene?                                                                                                        
	elsif ($name =~ /^rrn/) {
            $feature_type = 'rRNA';
	    $product = $name;
	}
	### Otherwise, assume a protein-coding gene
	else {
	    if ($name =~ m/^(.)(.*)/) {
		$product = uc($1).$2;
	    } else {
		die "This should never happen";
	    }
	}

	my $locus_tag = $locus_tag_prefix;
	foreach (1 .. 5-length($i)) {
	    $locus_tag .= '0';
	}
	$locus_tag .= $i;
	$i += 10;
	
	
	if ($feature_type eq 'CDS') {
	    
	    ### A protein-coding gene
	    
	    ### gene
	    print "$start\t$stop\tgene\n";
	    print "\t\t\tgene\t$product\n";
	    print "\t\t\tlocus_tag\t$locus_tag\n";

	    ### mRNA
	    #print "$start\t$stop\tmRNA\n";
	    #print "\t\t\tproduct\t$product\n";
	    #print "\t\t\tprotein_id\tgnl|ncbi|$locus_tag\n";
	    #print "\t\t\ttranscript_id\tgnl|ncbi|$locus_tag\_mrna\n";

	    ### CDS
	    #print "$start\t$stop\tCDS\n";
	    #print "\t\t\tcodon_start\t1\n";
	    #print "\t\t\tproduct\t$product\n";
	    #print "\t\t\tprotein_id\tgnl|ncbi|$locus_tag\n";
	    #print "\t\t\ttranscript_id\tgnl|ncbi|$locus_tag\_mrna\n";
   

	} elsif($feature_type eq 'tRNA') {
	    ### tRNA
	    if ($name =~ m/trn(f{0,1}\w)-(\w{3})/) {
		my $amino_acid = $1;
		my $anticodon = $2;
		$product = "tRNA-$mapping{$amino_acid}";
		die unless defined $mapping{$amino_acid};
		
		print "$start\t$stop\ttRNA\n";
		print "\t\t\tproduct\t$product\n";
	    } else {
		die "Failed to parse tRNA '$name'";
	    }

	    
	} elsif($feature_type eq 'rRNA') {
	    ### rRNA
	    print "$start\t$stop\trRNA\n";
	    print "\t\t\tproduct\t$product\n";
	}
    }
}



sub get_mapping_of_amino_acid_codes {
    my %mapping = (
	G => 'Glycine',
	P => 'Proline',
	A => 'Alanine',
	V => 'Valine',
	L => 'Leucine',
	I => 'Isoleucine',
	M => 'Methionine',
	C => 'Cysteine',
	F => 'Phenylalanine',
	Y => 'Tyrosine',
	W => 'Tryptophan',
	H => 'Histidine',
	K => 'Lysine',
	R => 'Arginine',
	Q => 'Glutamine',
	N => 'Asparagine',
	E => 'Glutamic Acid',
	D => 'Aspartic Acid',
	S => 'Serine',
	T => 'Threonine',
	fM => 'Methionine'
	);
    return \%mapping;
}
