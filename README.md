# DOGMA_to_TBL
Converting DOGMA annotation into NCBI's feature table format

## The problem that I am trying to solve:
I have annotated a chloroplast genome using [DOGMA](https://dogma.ccbb.utexas.edu/). This produces annotation in DOGMA's
table format, which looks like this:

```
275     1333    psbA    -
1939    3465    matK    -
```

I want to submit this annotation (along with the nucleotide sequence) to GenBank via NCBI.
NCBI require the submission in Sequin (.sqn) format.
This requires conversion of Feature Table (.tbl) into Sequin (.sqn) format using the
[tbl2asn tool](https://www.ncbi.nlm.nih.gov/genbank/tbl2asn2/).

So, I need to convert DOGMA's output (see above) into NCBI's Feature Table (.tbl) format, which looks like this:

```
>Feature 1
1       168843  REFERENCE
                        PBARC   12345
1333    275     gene
                        gene    PsbA
                        locus_tag       GW17_c00001
1333    275     mRNA
                        product PsbA
                        protein_id      gnl|ncbi|GW17_c00001
                        transcript_id   gnl|ncbi|GW17_c00001_mrna
1333    275     CDS
                        codon_start     1
                        product PsbA
                        protein_id      gnl|ncbi|GW17_c00001
                        transcript_id   gnl|ncbi|GW17_c00001_mrna
3465    1939    gene
                        gene    MatK
                        locus_tag       GW17_c00011
3465    1939    mRNA
                        product MatK
                        protein_id      gnl|ncbi|GW17_c00011
                        transcript_id   gnl|ncbi|GW17_c00011_mrna
```

So, the output of this script is a Feature Table (.tbl).
The required input is DOGMA output plus the chloroplast genome sequence (in fastA format).

Usage:
```
perl dogma_to_feature-table.pl  DOGMA_annotation_text_summary.txt genome.fasta > genome.tbl
```

Subsequently, I can then convert this Feature Table into Sequin format:

```
./tbl2asn -t template.sbt -i genome.fasta -Mn -Z discrep -a r10k -l paired_ends -j"[organism=Ensete ventricosum]"
```
This generates a number of files, including ```genome.sqn```.
(Template file was generated here: https://submit.ncbi.nlm.nih.gov/genbank/template/submission/)



## References
* Wyman SK, Jansen RK, Boore JL. Automatic annotation of organellar genomes with DOGMA. Bioinformatics. 2004 Nov 22;20(17):3252-5. Epub 2004 Jun 4. PubMed PMID: 15180927.
