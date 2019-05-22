composition## **Lab1 notebook**

|Species|File Size (only genome)|# of Chromosomes (not including mito or chloro)|Genome Size|# of Protein-coding genes|Ave Protein Length|
|:------|:-------:|:---------:|:---------:|:------------:|:---------:|
|A.thaliana| 116M | 5 | 119667262 | 35386 | 409 |
|C.elegans | 98M | 6 | 100286400 | 26789 | 445 |
|D.melanogaster| 165M | 8 | 168736492 | 30307 | 659 |

Calculating Genome Size:

* **Number of nucleotides:** grep -o -e "A|T|C|G|N" genome.fa | wc -l
* **Number of false positives in FASTA descriptive text:** grep ">" genome.fa | grep -o -E "A|T|C|G|N" | wc -m
* **Number of true nucleotides:** Number of nucleotides - Number of false positives

Calculating Average Protein Size:

* **Count # of proteins:** grep -c ">" protein.fa
(same as grep ">" protein.fa | wc -l)
* **Count # of Amino Acids:** grep -v ">" protein.fa | wc -m
* **Count # of newline characters:** grep -v ">" protein.fa | wc -l
* **Average Protein Size:** (# of Amino Acids - # of newline) / (# of proteins)

### Sequence Alignment Part 3

Making text files containing only the 1st protein:

    grep -v ">" ~/Data/Species/A.thaliana/protein.fa | head -5 > at1.fa
    grep -v ">" ~/Data/Species/C.elegans/protein.fa | head -8 > ce1.fa
    grep -v ">" ~/Data/Species/D.melanogaster/protein.fa | head -14 dm1.fa

Manually counted the lines for the lines of the first protein.
Do a sequence alignment of these first protein sequences:

    water at1.fa ce1.fa -gapopen 10 -gapextend 5 -outfile at_ce.water

### Random Expectation Part 4

Check if they have the same number of letters via compseq:

    compseq ce1.fa -word 1 -outfile ce1.comp
    compseq ce1.shuffle.fa -word 1 -outfile ce1.shuffle.comp
    less ce1.comp
    less ce1.shuffle.comp

They look similar, what is the difference? To answer this question use Unix command diff:

    diff ce1.fa ce1.shuffle.fa

diff reports lines that are different. If nothing is returned, it means the lines were not different. Re-shuffling and preforming an alignment gives us a different result. Lets repeat this 1000 times:

    shuffleseq ce1.fa -outseq ce1.shuffle.fa -shuffle 1000
    water at1.fa ce1.shuffle.fa -gapopen 10 -gapextend 5 -outfile 1k.water

To count the unique scores:

    grep Score 1k.water | cut -d " " -f 3 | sort -n | uniq -c

* -d " " option to tell it that our fields split on spaces
* -f 3 option to tell we want the 3rd column

awk can be used to calculate the average.

    grep Score 1k.water | awk '{sum+=$3} END {print sum/NR}'

**1. Is the shape of the curve normal? Do you expect it to be normal?**
The shape of my curve is not normal as it dips in the middle. Normally we would expect a normal distribution or Gaussian Curve.

**2. Do you expect all protein comparisons to have the same distribution?**
If the original sequences being compared have a high similarity in composition a higher match score is expected and a normal distribution skewed to the right side. If the original sequences have low similarity in composition a lower match score is expected and a normal distribution skewed to the left.

**3. How would protein composition and length affect the scores?**
The protein composition directly affects the scores as we are comparing the amino acids sequences. When the amino acid composition is patterned, such as GC or AT repeats, the longer length will lead to a higher score. If the composition is random, the longer length will lead to a lower score.

**4. How would the scoring matrix and gap penalties affect the scores?**
In a scoring matrix, some are made with closer related sequences while others are made using more distance sequences. This can affect how much substitution or adding gaps is penalized.

**5. How might real sequences be different from random?**
Real sequences are different from random because amino acids ordering is specific to protein structure and function. If the sequence is very common (like a zinc finger binding domain) or homologous to another species it will return a high score. If the sequence is unique to the organism, it will be expected to return a low score due to poor alignment.

### Alignment Significance

**1. How many amino acids can I align per second?**

To compare 1 protein (B0213.10) against 35386 proteins (A.thaliana Proteome) took 89 seconds. (35386 proteins / 89 s) = 398 proteins / s. Since the average protein size was 409 a.a. for A.thaliana, the number of amino acids aligned per second can be calculated simply by (398 protein / s x 409 a.a. / protein) = **162782 a.a. / s**. Another way to calculate this is by dividing the total number of amino acids by total seconds (14482855 a.a. / 89 s) = **162729 a.a. / s**. The slight difference between the two values is due to rounding error.

I obtained the time it took to compare B0213.10 against the A.thaliana proteome by writing this script:

    #!/bin/bash
    START=$(date +%s)
    water B0213.10.fa ~/Data/Species/A.thaliana/protein.fa -gapopen 10 -gapextend -5 -outfile B0Ath.water
    END=$(date +%s)
    RUNTIME=$(($END - $START))
    echo RUNTIME

**2. How many amino acids do I need to align to do this experiment?**

Protein B0213.10 consists of 509 amino acids. This can be calculated simply by typing:

    less B0213.10.fa | wc -m

The 509 a.a. must be aligned against 14482855 a.a. in the A.thaliana proteome

**3. How long would it take to compare two proteomes?**

It will take a very long amount of time. To compare 1 protein (B0213.10) against 35386 proteins (A.thaliana Proteome)took 89 seconds. Making a rough estimate, lets assume that the two proteomes we are comparing both contain 35386 proteins. The time it takes to compare 1 protein to 35386 proteins was 89 seconds, so we will repeat this process 35386 times in total. Thus the total time it takes to compare 2 proteomes will be: 89 s x 35386 = **3149354** seconds total. There are 86400 seconds in a day, thus it will take roughly 3149354 / 86400 = **36** days to compare two proteomes the size of 35386 proteins.

### Other Notes

Find the protein B0213.10 by opening the C.elegan protein.fa file. Then search for the protein by typing /B0213.10.

Find the protein amino acid length by typing to the command-line:

    cat B0213.10.fa | wc -m

Type the following to perform a water alignment and pull the scores:

    water B0213.10.fa ~/Data/Species/A.thaliana/protein.fa -gapopen 10 -gapextend 5 outfile B0Ath.water
    grep Score B0Ath.water | sort -nr -k3 > score.txt

Ortholog: AT2G23190.1
Create txt file containing just the amino acid sequence.

If the Ortholog is significant then the alignment score should be much higher than the score returned by comparing it with the shuffled orthologous sequence. (since amino acid order matters.) Type:

    shuffleseq AT2G23190.1.fa -outseq at.shuffle.fa -shuffle 1000

Then perform a sequence alignment of our protein of interest with these shuffled sequences

    water B0213.10.fa at.shuffle.fa -gapopen 10 -gapextend 5 -outfile 1k.water

Next, we want to calculate the average score of all the scores returned by this sequence alignment.

text base z score

    grep Score 1k.water | cut -d " " -f 3 | sort -n | uniq -c

calculate the average

    grep Score 1k.water | awk '{sum+=$3}' END {print sum/NR}'

The averaged scores of comparing our protein of interest with the randomly shuffled ortholog sequences was 35.954

The original sequence alignment score of our protein of interest with the predicted ortholog was 337, which is significantly higher than the average score of 35.954.
It makes sense the score of alignment is very high because it is a family of cytochrome p450 proteins which are liver enzymes involved with metabolism.
