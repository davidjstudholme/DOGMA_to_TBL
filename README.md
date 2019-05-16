# DOGMA_to_TBL
Converting DOGMA annotation into NCBI's feature table format

## The problem that I am trying to solve:
I have annotated a chloroplast genome using [DOGMA](https://dogma.ccbb.utexas.edu/), which generates annotation in a format that looks like this:

```
275     1333    psbA    -
1939    3465    matK    -
4295    4331    trnK-UUU        -
5075    5287    rps16   -
7805    7877    trnQ-UUG        -
8237    8419    psbK    +
8820    8972    psbI    +
9111    9198    trnS-GCU        -
10850   10886   trnG-GCC        +
11024   11095   trnR-UCU        +
```

I want to submit this annotation (along with the nucleotide sequence) to GenBank via
[BankIt at NCBI](https://www.ncbi.nlm.nih.gov/WebSub/). BankIt requires the submission in Feature Table (```.tbl```) format.

So, I need to convert DOGMA's output (see above) into NCBI's Feature Table (```.tbl```) format, which looks like this:

```
>Feature 1
1       168843  REFERENCE
                        PBARC   12345
1333    275     gene
                        gene    PsbA
                        locus_tag       GW17_> genome.tbl00001
3465    1939    gene
                        gene    MatK
                        locus_tag       GW17_> genome.tbl00011
4331    4295    tRNA
                        product tRNA-Lysine
5287    5075    gene
                        gene    Rps16
                        locus_tag       GW17_> genome.tbl00031
7877    7805    tRNA
                        product tRNA-Glutamine
8237    8419    gene
                        gene    PsbK
                        locus_tag       GW17_> genome.tbl00051
8820    8972    gene
                        gene    PsbI
                        locus_tag       GW17_> genome.tbl00061
9198    9111    tRNA
                        product tRNA-Serine
10850   10886   tRNA
                        product tRNA-Glycine
11024   11095   tRNA
                        product tRNA-Arginine
```

So, the output of this script is a Feature Table (```.tbl```).
The required input is DOGMA output plus the chloroplast genome sequence (in fastA format).

Usage:
```
perl dogma_to_feature-table.pl  DOGMA_annotation_text_summary.txt genome.fasta  'GW17_> genome.tbl' > genome.tbl
```

Optionally, we can then convert this Feature Table into Sequin format using [tbl2asn](https://www.ncbi.nlm.nih.gov/genbank/tbl2asn2/), though this is not required
by BankIT:

```
./tbl2asn -t template.sbt -i genome.fasta -Mn -Z discrep -a r10k -l paired_ends -j"[organism=Ensete ventricosum]"
```
This generates a number of files, including ```genome.sqn```.
(Template file was generated here: https://submit.ncbi.nlm.nih.gov/genbank/template/submission/)


## References
* Wyman SK, Jansen RK, Boore JL. Automatic annotation of organellar genomes with DOGMA. Bioinformatics. 2004 Nov 22;20(17):3252-5. Epub 2004 Jun 4. PubMed PMID: 15180927.
