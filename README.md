# DOGMA_to_TBL
Converting DOGMA annotation into NCBI's feature table format

## The problem that I am trying to solve:
I have annotated a chloroplast genome using [DOGMA]{https://dogma.ccbb.utexas.edu/}. This produces annotation in DOGMA's
table format, which looks like this:



I want to submit this annotation
(along with the nucleotide sequence) to GenBank via NCBI. NCBI require the submission in Sequin (.sqn) format. This requires
 conversion of feature table (.tbl) into Sequin (.sqn) format using the tbl2asn tool. 


```275     1333    psbA    -
1939    3465    matK    -
4295    4331    trnK-UUU        -
5075    5287    rps16   -
7805    7877    trnQ-UUG        -
8237    8419    psbK    +
8820    8972    psbI    +
9111    9198    trnS-GCU        -
10850   10886   trnG-GCC        +
11024   11095   trnR-UCU        +
11244   12785   atpA    -
12863   13270   atpF    -
14114   14257   atpF    -
14754   14996   atpH    -
16164   16904   atpI    -
17191   17895   rps2    -
18190   22266   rpoC2   -
22459   24093   rpoC1   -
24791   25231   rpoC1   -
25261   28476   rpoB    -
29515   29595   trnC-GCA        +
30523   30615   petN    +
31972   32073   psbM    -
33140   33213   trnD-GUC        -
33616   33699   trnY-GUA        -
33754   33826   trnE-UUC        -
34597   34668   trnT-GGU        +
34603   34661   trnM-CAU        +
```













## References
* Wyman SK, Jansen RK, Boore JL. Automatic annotation of organellar genomes with DOGMA. Bioinformatics. 2004 Nov 22;20(17):3252-5. Epub 2004 Jun 4. PubMed PMID: 15180927.
