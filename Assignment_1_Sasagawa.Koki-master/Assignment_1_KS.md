_Score:_ 18.0/20

Assignment 1
==============

# Template for Unix, git, and Sequence Alignment Assignments (20 pts possible)

__Full Name:__ Koki Sasagawa

## Sequence Alignment

*_Please answer the following questions Be clear and concise with any written answers._*

__1.__ Paste in the markdown table from the lab manual that includes for each genome:

* Size of the file
* Number of chromosomes
* Size of the genome in bp
* Number of protein-coding genes
* Average protein length

|Species|File Size (only genome)|# of Chromosomes (not including mito or chloro)|Genome Size (bp)|# of Protein-coding genes|Ave Protein Length|
|:------|:-------:|:---------:|:---------:|:------------:|:---------:|
|A.thaliana| 116M | 5 | 119667262 | 35386 | 409 |
|C.elegans | 98M | 6 | 100286400 | 26789 | 445 |
|D.melanogaster| 165M | 8 | 168736492 | 30307 | 659 |


*GMT* -1 Number of chromosomes should be 7 or 5, 7 or 5 and 7 or 15 no code provided so can not tell what went wrong no code provided so can not tell what went wrong
*GMT* -0 the number of basepairs is also off this is because wc -l  gives you half of -m in this case because the output prints one new line per match found. This is confusing, so I no points are taken off but next time double check that they are giving the same output


For _ONE_ of the files, provide the code that you used to answer these questions.

__2.__ How do you know that when you use `shuffleseq` the sequences have the same exact composition?

    compseq ce1.fa -word 1 -outfile ce1.comp
    compseq ce1.shuffle.fa -word 1 -outfile ce1.shuffle.comp
    less ce1.comp
    less ce1.shuffle.comp

compseq calculates the unique composition. Using diff will then return any lines that are different.

      diff ce1.comp ce1.shuffle.comp

In this case, shuffleseq re-orders the amino acids but the composition remains unchanged,
so we should not see anything returned by diff.

__3.__ Create a text based "histogram" as described in the lab manual
that shows the distribution of scores when aligning shuffled sequences.
Why is the shape of the curve not quite normal?

    grep Score 1k.water | cut -d " " -f 3 | sort -n | uniq -c

          5 28.0
         22 29.0
         46 30.0
         64 31.0
         80 32.0
         88 33.0
        114 34.0
         91 35.0
        112 36.0
         74 37.0
         74 38.0
         46 39.0
         43 40.0
         27 41.0
         28 42.0
         26 43.0
         16 44.0
         11 45.0
         10 46.0
          6 47.0
          6 48.0
          2 49.0
          3 50.0
          2 51.0
          1 52.0
          3 53.0

This text based histogram was calculated from comparing the c.elegans protein B0213.10
against the A.thaliana proteome. The shape of the curve is not normal as there is a
dip in the middle for score 35, flanked by score 34 at count 114 and score 36 at count 112.
This shape is likely due to chance caused by shuffleseq.

__4.__ What would be the effect of doing 1,000,000 shuffled sequences?

There will be less chance of getting an alignment that scores high due to chance alone.
Significance becomes higher. This will also likely solve our issue with our histogram
not exhibiting a normal distribution.

*GMT* -1 the data is still skewed "sequence composition" but it will be better for testing significance

__5.__ Briefly discuss the relationship of sequence length and score.

The longer the sequence, the higher chance of gaps and mismatch penalties, causing
the score to be lower. The shorter the sequence, the lower chance of gaps and
mismatches, causing the score to be higher. Local alignment is favored over
global alignment when comparing a proteins with large gaps or for comparing
specific sequence or region against a sequence. Global alignment aligns every
letter of the two sequences, thus can be used when comparing sequences of similar
size.

__6.__ Starting with the C. elegans B0213.10 protein, find the best
match in the A. thaliana and D. melanogaster proteomes with `water`.
Record their alignment scores, percent identities, and protein names
here.  (Use a markdown table!)

*GMT* -0 next time include the gene names as the ID such as AT2G23190 they are more unique ids

| Organism | Protein Name | Alignment Score | Percent Identity |
|:--------:|:------------:|:---------------:|:----------------:|
| D.melanogaster | Cyp18a1-PA | 333 | 26.3% |
| A.thaliana | Cytochrome P450| 337 | 28.2% |

A brief overview of what I did:
Run water of text file containing the amino acid sequences of protein B0213.10.fa
against the entire proteome of A.thaliana. Next, enter the grep command to pull the scores
of the alignments into a new text file.

    water B0213.10.fa ~/Data/Species/A.thaliana/protein.fa -gapopen 10 -gapextend 5 outfile B0Ath.water
    grep Score B0Ath.water | sort -nr -k3 > score.txt

Open the text file using `less` and note the highest score value at the top.
Next, open `B0Ath.water` and search for the alignment score by typing `/Score: 337`.
This will highlight the score, and from there the protein code can be found.

__7.__ What is the expected (average) score of each pairwise alignment
at random? (Perform some shuffled alignments to get an idea of what the
random expectation is).

A brief overview of what I did:
To calculate the expected average score of each pairwise alignment at random, generate
shuffled copies of our suspected orthologous protein and perform a water alignment
against B0213.10 on each.

    shuffleseq AT2G23190.1.fa -outseq at.shuffle.fa -shuffle 1000
    water B0213.10.fa at.shuffle.fa -gapopen 10 -gapextend 5 -outfile 1k.water
    grep Score 1k.water | awk '{sum+=$3}' END {print sum/NR}'

The average expected score at random:
Cytochrome p450: **35.95**
cyp18a1-PA: **35.76**

__8.__ Briefly discuss the statistical and biological significance of your results.

*GMT* -0.0 Good answer what about for your results tho comparing your 333 score to the expected score of 35.95

We can use EMBOSS Shuffle Seq to scramble our amino acid sequence. The idea is that
we generate randomly shuffled amino acid sequences of our matched protein, and align
it against our protein of interest to see if the score we obtained in our original
sequence alignment is significant or not significant. Repeat this process numerous
times, and if our original alignment score looks similar to our randomly shuffled
alignment scores then it is not significant. If our matched protein alignment is
significant then the original alignment score should be much higher than the scores
returned from aligning shuffled sequences.
(since amino acid order matters.)
The average expected score at random are significantly smaller than our original
alignment score, suggesting that our matched protein is an ortholog.

__10.__ Approximately how long would it take to compare two proteomes using `water`?

To compare 1 protein (B0213.10) against 35386 proteins (A.thaliana Proteome)
took 89 seconds (The description on how I calculated this is written in my lab
notebook).
Making a rough estimate, lets assume that the two proteomes we are comparing
both contain 35386 proteins. The time it takes to compare 1 protein to 35386
proteins was 89 seconds, so we will repeat this process 35386 times in total.
Thus the total time it takes to compare 2 proteomes will be:
89 s x 35386 = **3149354** seconds total.
There are 86400 seconds in a day, thus it will take roughly
3149354 / 86400 = **36** days
