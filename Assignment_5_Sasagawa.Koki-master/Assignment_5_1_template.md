_Score:_ 12.25/14
# Assignment_5_1.md

Student Name: Koki Sasagawa  
Student ID: 999054646

Notes: **Trimmomatic**, is a program that filters reads based on quality scores and other criteria. 

Insert answers to Illumina exercises 1 - 7 here.  Submit this .md by git.

**Exercise 1:**

__a__ What is the read length? (can you do this without manually counting?)

```
head -2 GH.lane67.fastq | tail -1 | grep -o -E "A|T|C|G|N" | wc -l
```
> The read length is 100

__b__ What is the machine name?

> HWI-ST611_0203

__c__ How may reads are in this file? (show how you figured this out)

```
grep -c "@" GH.lane67.fastq
```
> There are 1,000,000 reads in the file. 

__d__ Are the quality scores Phred+33 or Phred+64? (how did you figure this out?

> It is Phred+64 as the scores are indicated mostly using alphabetical ASCII symbols. 

**Exercise 2:** Compare your fast1 results to the examples of good sequence and bad sequence on the fastqc website. Comment on any FastQC items that have an "X" by them in the report. What might have caused these issues? (hint: think about barcodes)

> Our perbase sequence quality falls off towards the end. This could be caused by errors introduced by polymerase. 

> Our perbase sequence content is skewed due to the high occurance of T on position 6 in the early part of our sequence. (first 10bp repeats) Perhaps this region contains an adapter that is attached to the beginning of all of our illumina reads.  

> Our kmer content is skewed to show a high occurrence of repeats in the beginning of our reads. The kmer is a 7 nucleotide sequence read, which is localizing starting mostly from the position 2 nucleotide. Kmer is a subsequence derived from a read obtained through DNA sequencing. The fastqc is showing us the kmers with positionally biased enrichment. These repeatedly appearing sequences are probably due to adapters added to the beginning of illumina reads such as a barcode.

**Exercise 3:** Take a look at the trimmomatic web page and user manual and figure out how to modify the command below to clip after the average read quality across 4 bases drops to 20 or less. AND only retain reads where the trimmed length is 50bp or more.

Results of trim:

> TrimmomaticSE: Started with arguments:
-phred64 GH.lane67.fastq GH.lane67.trimmed.fastq SLIDINGWINDOW:1:4 MINLEN:50 AVGQUAL:20
Automatically using 2 threads

Input Reads: 1000000 Surviving: 981395 (98.14%) Dropped: 18605 (1.86%)
TrimmomaticSE: Completed successfully

__a__ What trimmomatic command did you use?

```
trimmomatic SE -phred64 GH.lane67.fastq GH.lane67.trimmed.fastq SLIDINGWINDOW:1:4 MINLEN:50 AVGQUAL:20 
```

*GMT* -0.25 should have been  SLIDINGWINDOW:4:20


__b__ How many reads were removed by trimming?

> 18605 (1.86%) of the reads were removed in the trimming process. 

*GMT* -0.5 should have been around ~4%


__c__ Trimmomatic has the option to remove Illumina adapters. Why did we not do that here?

> trimming out the illumina adapters will also remove our barode. 

__d__ rerun FastQC on the trimmed sequences. Which issues did the trimming fix?
(If you want a good challenge you can try to figure out how many reads were trimmed…)

> The trim dropped the reads with scores below 20, thus passing our per base sequence quality. (The score is dictated by the fluorescence of the sequencing by synthesis. The error could be due to polymerase being error prone, or the machine is experiencing problems)

fast1 files contain reads from many different samples, indexed with a 5' barcode on each read. We need to split the reads according to the barcode and then remove the barcode from the 5' end.

**Excercise 4:** Look at the README for auto_barcode and figure out how to run it to split your samples. Specify that the split fastq files are placed in the directory split_fq. Use the perl (.pl) version of the script

__a__ what command did you use?

```
barcode_split_trim.pl \
  --id demo \
  --barcode barcode_key_GH.txt \
  --list \
  --outdir split_fq \
  GH.lane67.trimmed.fastq
```  

__b__ what percentage of reads did not match a barcode? What are possible explanations?

> 5.7% of the reads did not match. There might be a barcode that was not accounted for in the list or it could have been due to ligation errors. 

**Exercise 5:** use a fish for loop run tophat on all of the fastq files.

```
for file in (ls split_fq/)
    tophat --phred64-quals -p 2 ../Brapa_reference/BrapaV1.5_chrom_only split_fq/{$file}
end
```

IMPORTANT By default tophat will write to directory “tophat_out”. If you run it multiple times it will overwrite the contents of this directory each time. Therefore be sure to have your for loop write to a new directory for each fastq file!

IMPORTANT 2 This will probably take about an hour to run. You can leave your instance on but do not need to stay in lab while it runs.

**Exercise 6:** Take a look at the align_summary.txt file.
__a__ What percentage of reads mapped to the reference? b. Give 2 reasons why reads might not map to the reference.

> 81.1% of the reads mapped to the reference.

*GMT* -0.5 which genome was this for IMB211 or R500?

> 18.9% of the reads didn't map with the reference genome. This could be due to human or other sources of contamination. Another reason could be due to error in PCR which could amplify reads with errors. 

**Exercise 7:**  
__a__ Can you distinguish likely SNPs from sequencing/alignment errors? How?

> The likely SNPs appear across all reads. One's that arise from sequencing errors are not shared among other reads. 


__b__ Go to A01:15,660,359-15,665,048 (you can cut and paste this into the viewer and press “Go”. For each of the the three genes in this region: does the annotation (in blue) appear to be correct or incorrect? If incorrect, describe what is wrong

> The annotation in blue appear to be correct as the reads are aligning to the annotated region. However, there are reads that align outside the annotated region. Perhaps these are isoforms (exons) the reference annotated genome did not contain, or annotation errors in the reference genome. 

*GMT* -0.5 which genes were better than others in annotation? 

**My Notes**  
Patterns that are seen often in my data. The barcodes are kind of like kmers (5 bp code used to link read to a sequence library). When generating libraries, PCR replication could be the cause of certain kmers being very highly present.

Illumina tends to have increased low quality reads towards the end. 

Why aren't adapters committed in the trimming? 
the barcode (unique identifier of reads to sequence library) is sometimes included as part of the "adapter". 

Why are some reads not match barcodes? 
low quality reads at those regions.
issues when adding the adaptors. 

bowtie 2 vs bowtie 1
consistency is a big reason. (what did the other researcher use?)
