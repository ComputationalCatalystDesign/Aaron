#!/usr/bin/perl -w
use strict; use warnings;

my $rmsd;

eval {
    use lib $ENV{'AARON'};
    use lib $ENV{'PERL_LIB'};
    
    use Data::Dumper;
    
    use AaronTools::Catalysis;
    
    my $cata = new AaronTools::Catalysis( name => 'catalysis' );
    
    my $original = new AaronTools::Catalysis( name=>'ref');
    
    my $ligand = new AaronTools::Ligand( name => 'SEGPHOS');
    
    $cata->map_ligand($ligand);
    
    $rmsd = $cata->RMSD(ref_geo=>$original);
} or do {
    my $error = $@;

    die "Error found in code: $error\n";
};

unless ($rmsd < 0.2) {
    die "Mapped structure doesn't match with the reference"
}

print "Test past!\n";
