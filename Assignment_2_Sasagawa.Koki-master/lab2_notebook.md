4/13/2017

**Create variables by typing:** set variable1 variable2 variable3 ... variableN

**for loops have 3 parts:**
1. A _for_ statement telling us what we want to loop
2. The commands to repeat
3. end to indicate the end of the loop

EX:

    for fruit in $fruits
      echo "$fruit"s
    end

we can use {} brackets to distinguish between the variable and text

    for fruit in $fruits
      echo {$fruit}s
    end

**Exercise One: Write a for loop to pluralize peach, tomato, potato**

    set food peach tomato potato

    for food in $food
      echo {$food}es
    end

    echo "this" > file1.txt // Here we are printing the text "this" and
                            // directing the output into txt file file1.txt

    set myfile (ls) //the (ls) tells ish to run the ls command and place the
                    //results into the variable myfiles.

**Exercise two: In your own words provide a "translation" of the above loop**

    for file in (ls)
      cat $file
    end

This is a for loop that looks for "files" in ls, then displays the text for each variable file

**Exercise three: Modify the above loop to produce the following output**

    for file in (ls)
      echo file $file contains:
      cat $file
    end

To print escape characters, you need to remember it is a special text.
Preceed it with \

**Optional challenge**

    for file in (ls)
      echo file \"{$file}\" contains:
      echo \"(cat #file)\"
    end

**Exercise 4:**

Pseudo loop:
Make a variable named scoringMatrix with EBLOSUM45, EBLOSUM62, EBLOSUM80
I want to call this in the 1st for loop to add to the very end of my water command
Next I want to have a 2nd for loop to change the gap extension penalty values from 3 to 9
To make 21 distinct files I will use the first 2 loops to name my new file.

    set scoringMatrix EBLOSUM45 EBLOSUM62 EBLOSUM80
    set gextend 3 4 5 6 7 8 9

    for sMatrix in $scoringMatrix
	    for x in $gextend
	      water ~//Lab1/B0213.10.fa ~//Lab1/at1.fa -gapopen 10 -gapextend $x -outfile {$sMatrix}{$x} -datafile $sMatrix
	    end
    end

BLAST for paralogs and orthologs

Ortholog is defined as the best reciprocal match between proteomes. After finding the best match, that protein must also match back to that same protein in a reverse test.

Calculated in lab1 we found out that performing a water on two proteomes would take too long. blastp will allow us to perform this much faster.

Format the BLAST database by typing:

    formatdb --help

Make an alias to FASTA proteome and format it as a BLAST database.

    ln -s ~/Data/Species/D.melanogaster/protein.fa ./flypep
    formatdb -i flypep -p T

blastp expects a very specific format and will produce error messages if there is any difference. Silence those messages via

    formatdb -i wormpep -p T 2> /dev/null

This means to send the error messages into /dev/null which is the black hole.

Make an alias to protein B0213.10 by creating an alias to a file called p450.

    ln -s ~/Lab1/B0213.10.fa ./p450

Run a blast on our protein against the D.melanogaster proteome

    time blastp -db flypep -query p450 > default.blast

E-value given by blast report is the expectancy value of getting that score by chance alone. Thus the lower the e-value, the more significant the blast alignment score.

The speed of our blast depends on the parameters set on blast. The default word size search is 3 and a threshold of 11. Lets try out different threshold from 10 to 15.

    set thresholdVal 10 11 12 13 14 15
    for T in $thresholdVal
      echo "Starting blastp with threshold $T"
      time blastp -db flypep -query p450 -threshold $T > {$T}.blast
    end

|	Threshold | Time |
|:---------:|:-----:|
| 10        |0:01.10|
| 11		|0.00.71|
| 12        |0.00.50|
| 13        |0.00.39|
| 14        |0.00.32|
| 15        |0.00.30|

The smaller the threshold, the longer time it takes due to more hits that blastp will bring back. Threshold basically designates the amount of amino acids that must match in a row to continue extending an alignment

Change the output format by typing in:

    -outfmt 7

This makes the file format parseable. Changes the output format to be tab-delimited fields with a little header information that tells you what each column is.

Type the following to only get the single best alignment

    -culling_limit 1

Make wormpep database by creating an alias to C.elegans proteome file

    ln -s ~/Data/Species/C.elegans/protein.fa ./wormpep

Search one protein against the other:

    blastp -query wormpep -db flypep -outfmt 6 -culling_limit 1 > wormvsfly.blast

PART2: PARALOGS

Create text file of protein T21B10.2a. Preform a blastp search of T21B10.2a against its own proteome to find paralogs.

    blastp -db wormpep -query T21B10.2a > T21B10.2a.blastp

The paralog candidates are:

|Paralog|bit score|E-value|%identity|
|:-----:|:-------:|:-----:|:-------:|
|T21B10.2c|891|0|100|
|T21B10.2b|419|2e-144|95|

These two proteins however, are not paralogs because they are isoforms of eachother. Isoforms arise from alternative splicing or post translational modifications. The small e-values and very high % identity would then makes sense as the 2 proteins arise from the same gene. Checking on Ensembl, I was able to verify that the two proteins did locate in the same region of the genome.

    blast -db wormpep -query B0213.10 > B0213.10.blastp

We selected paralog candidates by observing 4 criteria of each protein.
* E-value
* % identity
* Visual evaluation of alignment
* protein name

|paralog|bit score|e-value|%identity|
|:-----:|:-------:|:-----:|:-------:|
|B0213.15a|786|0|72%|
|B0213.15b|775|0|70%|
|B0213.14 |755|0|71%|

If the protein has a low e-value, you know the alignment score was significant. We then observed the % identity to see how much similarity our candidate protein has in relation with our aligned protein. An additional evaluation was preformed by visually observing the amino acid alignment. This is to validate the % identity and check that alignment matches were spread-out over the entire amnio acid sequence.

BLOSSUM 80
BLOSSUM 62
BLOSSUM 45

we would want to use BLOSSUM 80 for comparing very closely related sequences as we want matches to score high and mismatches to be heavily penalized. When comparing distant proteins together we don't want to use BLOSSUM 80 as mismatches would be penalized too heavily the scores we get would be scewed to be negative. Instead, we would want to use BLOSSUM 45 so that we can get a better result on seeing which proteins are closely related. For example, BLOSSUM 80 will be useful for comparing related sequences, as BLOSSUM 45 would be more better suited for comparing distant proteins.
