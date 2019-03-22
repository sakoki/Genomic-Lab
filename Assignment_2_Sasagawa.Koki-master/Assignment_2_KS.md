_Score:_ 19.25/20
# Template for BLAST, orthologs, and paralogs (Week 2, 20 pts possible)

__Name:__ Koki Sasagawa

__Student ID:__ 99905464

*_Please answer the following questions which are each worth 2 points. Be clear and concise with any written answers. Late assignments will be penalized with a 2pt deduction without prior communication of extenuating circumstances._*

__Q1__.  Write a for loop to pluralize peach, tomato, potato (remember that these end in "es" when plural).  Provide the code below.  (See "for loop" lab)

    set food peach tomato potato

    for food in $food
      echo {$food}es
    end

*GMT* -0.25  for food in $food individual var should not be given the same name as list

__Q2__.  In your own words provide a "translation" of the loop below (from "for loop" lab)

    for file in $myfiles
        cat $file
    end

This is a for loop that looks for "files" in variable "myfiles" and displays the text for each variable file.

__Q3__. Create a table that indicates blastp runtime as a function of
threshold value.  Is there a linear relationship?  Why does does
changing the threshold change the search time?

|	Threshold | Time |
|:---------:|:-----:|
| 10        |0:01.10|
| 11				|0.00.71|
| 12        |0.00.50|
| 13        |0.00.39|
| 14        |0.00.32|
| 15        |0.00.30|

As we increase the threshold value, the time it takes to perform the blastp also decreases. The higher the threshold the stricter the alignment will be and there will be less hits. The lower the the threshold, the less stict the alignment will be and more seeds will be able to extend.

*GMT* -0.5 is the relationship linear? 


__Q4__.  How much faster is blastp than water under default parameters?

blastp under default parameters run BLOSUM62 and a threshold of 10.
water under default parameters run BLOSUM62 with a gapopen penalty of 10 and gapextend penalty of 5.
Running blastp for B0213.10 against D.melanogasters proteome took 1.10 seconds total.
Running water for B0213.10 against D.melanogasters proteome took 196 seconds total.
blastp is significantly faster than water.

__Q5__.  What search parameters (matrix and threshold) would you use to
search two proteomes? Justify your answer.

What parameters I decide to use will ultimately depend on what kind of proteomes I am looking to compare. If I am comparing the proteomes of two closely related species I would want to use a BLOSUM80 matrix with a threshold value of 15 to get a stricter alignment. When comparing two distantly related species I would probably want to use BLOSUM45 matrix and run the blastp using a threshold value of 10. This is because if we make the conditions too strick we may fail to catch sequences that have diverged alot. Something to keep in mind is the time it takes to preforms these alignments. If time is an issue (ex: proteomes are too large) using less strict conditions will not be favorable as it will cause the blastp search to take much longer due to increased alignment hits.

__Q6__.  How long will it take to search two proteomes (given the above)?

Using blastp to align B0213.10 against D.melanogasters proteome took 1.10s. This can be interpreted as the time it took to compare 1 protein to 30307 proteins of D.melanogaster proteome. If we were to align two proteomes of the same size, we would compare each protein to 30307 other proteins. Since there are 30307 proteins in one proteome, we would repeat this process 30307 times. Thus the math is simply multiplying 1.10 x 30307 = 33337.7 seconds. There are 86400 seconds in a day. (33337.7 / 86400) = .385 days, or (24 hours * .385) = **9.26** hours total.

Running a blast on two proteomes using the default threshold of 10 and BLOSUM62

__Q7__.  Using E-value to determine the best match, find a worm gene with a single fly ortholog and record their names and the reciprocal E-Values.  Is there more than one fly "hit" for your worm gene?  If so how do you decide if there is a single orthlog?

Perform a proteome to proteome blast search for D.melanogaster proteome vs C.elegans proteome and vice versa.

In Class Example:  
ZK384.2 vs FBpp0081827 - worm vs fly  
ZK384.2 vs FBpp0081838 - fly vs worm  
NOT orthologs since they are not reciprocal matches  

My Search:  
R13H4.4b vs FBpp0070037 - worm vs fly  
R13H4.4b vs FBpp0070037 - fly vs worm  
Suggested orthologs since they are reciprocal matches.  
e-value: 0  
Looking up on Ensembl:  
FBpp0070037 is Dmel/alpha-Cat, 917 a.a.  
R13H4.4b is hmp-1 Alpha-catenin-like protein, 930 a.a.  

__Q8__.  Discuss what makes orthology difficult to determine by the reciprocal BLAST method.

We can get false reciprocal blast hits. To check the validity of reciprocal blast, it is important to see if there are other hits that returned a very similar high score. The definition of an ortholog are similar genes that arise from a speciation event. If there are multiple hits of high scores, then this suggests that there could have been a gene duplication event that occured after the speciation event. If that is the case these hits will not be orthologs. To find orthologs both proteins must match to eachother in a blast search.

__Q9__.  How many paralogs did you find for T21B10.2a and for B0213.10?  What criteria did you use?

The criteria I used to determine paralogs were e-value, % identity, protein name, and visually looking at the alignment.

For T21B10.2a, I did not find any genes that suggested a paralog. The two proteins that reported the highest bit score and lowest 3-value are T21B10.2c and T21B10.2b. These 2 proteins are isoforms of T21B10.2a which is denoted by alphabetical letters following the protein name (isoforms arise via alternative splicing or post translational modifications). Looking up these proteins on Ensembl, I checked that T21B10.2c was on chromosome 2: 8,930,985 - 8,933,778 forward strand and the T21B10.2b was on chromosome 2: 8,932,106 - 8,933,778 forward strand. The two protein transcript also differed only by 1 exon. The next nearest protein Y17G9B.5 has a low bit score of 29.6 and a high e-value of 3.2 which does not suggest it to be a paralog.

For B0213.10 the paralogs I found are B0213.15a, B0213.15b, and B0213.14. The gene B0213.15a and B0213.15b are 2 isoforms of the gene B0213.15. We can confirm this by looking up where these genes appear in the genome using Ensembl, similar to what we did earlier. All of these proteins have a very low e-value (0, 0, 0) and their % identities were fairly high (72%, 70%, 71%). Looking at the actual alignment, I was able to confirm that the alignment matches were spread out across the entire amino acid sequence. This is important for catching false positives such as cases where a protein could carry a highly conserved region which can give a positive score even if a significant portion of the protein is not matching. It is likely that these proteins are closely related isoforms of eachother.

__Q10__.  Is alignment score sufficient for determining orthology or paralogy? What other sources of information from the BLAST output might be useful?  What other types of analyses would be helpful?

Alignment score alone is not sufficient for determining orthology or paralogy. Other information such as e-value, % identity, and even the protein name will be very useful for determining whether proteins are orthologous or paralogous. E-value tells us how likely an alignment score is possible based off chance alone. The lower the e-value is the more significant our alignment score is. The % identity tells us how similar our protein of interest is against our target protein. Even if the e-value is low and the alignment score is high, if the % identity is very low it suggests the protein is probably not an ortholog or paralog. The protein name will let us know if the protein is a closely related family, an isoform, or identical.

Additionally, an evolutionary tree diagram will allow us to follow evolutionary events and determine whether a gene is orthologous or paralogous by refering to speciation or gene duplication events. To compare the molecular homology, we can perform a deep homology and study the evolutionary relationships between two organism based off their transcriptomes.

To add another layer of analysis, we could perform an experiment to knockout the paralogous or orthologous protein and study the change in phenotype. This will allow us to study any redundancy in function, or if the protein is essential.

Add and commit changes for both this document and your lab notebook to the repository.  Push to GitHub and set an issue to indicate that you are ready for this to be graded.
