_Score:_ 19.5/20
# Metagenomics Assignment 9

__Student Name:__ Sasagawa Koki  
__Student ID:__ 999054646  

Insert answers to exercises here.  Submit this .md by git.

**Exercise 1:**
Using information in the RiceMappingFile.txt and RiceSeqs.fna answer the following questions. Are the number of sequences for each sample approximately the same or are there any outliers? If so, which samples do they belong to? Could a different number of sequences per sample affect future analysis? Explain your reasoning.

> Looking at the sequence results there are some notable outliers comapred to the average of ~1000 sequences. Barcode AGCAGTCGCGATGT contains only 289 sequences while the barcode ACGGTGAGTGTCGT contains 4880 sequences. These barcodes belong to samples IE1 ( cultivar: IR50 | root inside) the other sample is IM2 (cultivar: IR50 | 1mm soil). Different number of sequences per sample can skew the data. We want to have higher number of sequences for each sample to increase the confidence. 

**Exercise 2:**
From the OTU summary, look at how many OTUs correspond to each sample ("counts/sample detail"). Do technical replicates agree with one another? At this stage, what conclusions can you draw about the number of OTUs in these samples?  

> Notes: Operational taxonomical units (OTUs) are defined as a cluster of 16S rRNA reads with 97% sequence similarity. 
 
> Not all technical replicates agree with one another. Perhaps this variance is caused by machine errors, or inconsistency in the scientist carrying out the study. Professor Maloof suggested that these could be biological replicates, which in this case the variance could be explained by difference in biological samples. The experimenter could have taken a sample from a different place which could vary in composition of microbes.

**Exercise 3:**
Although, the resolution of the y-axis makes it difficult to read each OTU, it is still a valuable preliminary visualization. What types of information can you gain from this heat map? Are there any trends present at this stage with respect to the various samples?  

> The OTU table is visualized as a heat map where each row corresponds to an OTU and each column corresponds to a sample. The OTUs in the middle all have high abundance while the OTU's near the top and bottom rows have more variance.  


*GMT* -0.5 the bright color is high abundance and the dark color low abundance. Abundance was in log10 format not Z score.


**Exercise 4:**  
__a.__ When comparing by treatment, which groups are the predominant phyla in the different samples? (Remember phyla is designated by "_p".) Are there any predominant groups unique to particular sample treatments?  

> The predominant phyla is proteobacteria with the highest abundance across all treatments. In root surface the unique predominant phyla is Bacteroidetes at 5.7% (vs 4.1% in root inside and 3.0% in 1mm soil). For the root inside, the dominant phyla is Spirochaetes at 2.2% (vs 1.0% in root surface and 0.3% in 1mm soil). In 1mm soil, the dominant phyla is Gemmatimonadetes at 7.1% abundance (vs 0.5% in root surface and 0.1% in root inside). 

__b.__ When comparing by cultivar, are the predominant phyla consistent with those observed in Part A? Are there any predominant phyla unique to a specific cultivar? What does this indicate to you about the effect of the genotype and/or the effect of the treatment?  

> Comparing by cultivar, the predominant phyla was once again proteobacteria. However, I was not able to identify any one phyla that seems to be uniquely associated with a particular cultivar. The results indicate that the genotype of each cultivar has minimal effects on microbial community, but the effects of treatment can significantly affect the microbial community composition.  

**Exercise 5:**  
Is there an alpha diversity metric that estimates the completeness of our sample diversity differently than the other metrics? If so, which one is it? Does this metric estimate a higher or lower sample diversity compared to the other metrics?

> Notes: Alpha diversity tells us about the richness of species diversity within our sample. Rarefaction provides a method of comparison between different communities, whereby each community is “rarefied” back to an equal number of sampled specimens.
 
> Out of the 4 different alpha diversity metrics, Shannon has the most distinct looking graphical representation of sample diversity. Compared to other metrics, this metric estimates a lower sample diversity because the graph shows a plateauing region, indicating maximum diversity.

*GMT* -0 this would indicate higher diversity since it reaches the max quicker

**Exercise 6:**  
__a.__ With Sample ID as the category, have we sequenced the full diversity possible for each sample? How do you know? Please indicate which metric(s) you used for your answer.  

> Taking the consensus of the alpha diveristy metrics, we have yet to sequence the full diversity as (Chao1, faith's phylogenetic diversity, OTU count) 3/4 of the graphs still have an upward postive trend of increasing phylogenetic diversity with respect to sequences per sample. 

__b.__ For Cultivar and Treatment, have we sequenced the full diversity of the various sites for all samples? How do you know?  

> For cultivar we have not sequenced the full diversity as there is still an upward trend for the 4 diversity metrics. For treatment, the root surface treatment seems to be plateauing across the 4 different diversity matrix, suggesting we may be close to sequencing the full diversity for that specific treatment.

__c.__ Which treatment had higher phylogenetic diversity? Which cultivar had higher phylogenetic diversity?  

> The 1mm soil treatment had the highest phylogenetic diversity while there is no outstanding cultivar that had the highest phylogenetic diversity. 

**Exercise 7:**  
__a.__ Open the weighted and unweighted PCoA plots by double clicking the index.html in their respective folders. How does adjusting the PCoA plots for taxa abundance (weighted) affect the clustering and principal coordinates?  

> Looking at the unweighted PCoA plot the clustering is not very clear. The weighted PCoA plots takes in account the relative abundance of each taxa within the communities and clusters the sample diversity by treatment.

__b.__ What are the significant correlations of particular samples? Does cultivar or treatment appear to have more of an influence on the clustering?  
*Hint:* you can add labels to the plot to help visualize both characteristics at once.  

> With sample ID we are not able to visualize any meaningful clustering. Clustering by cultivar is also not very informative, which is expected as it agrees with my earlier observation that cultivars do not show very distinct differences in microbial diversity. The particular samples show significant correlation with respect to treatment which has a significant influence on clustering. 

**Exercise 8:**  
Which sites cluster together? Which sites are different? How would you explain this pattern of diversity?  

> Looking at the weighted phylogenetic tree I see 3 large distinct clusters of samples that had the same treatment B (IB1, MB1, NLB2, NLB1, MB2, IB2), another clustered by treatment M (NEM1, IM1, NLM1, NLM2, MM1, NEM2, IM2), and a third clustered by treatment E (ME2. ME1, IE1, NLE1, IE2, NLE2). The exception includes the MM2 that seems to be separated from the rest, and another large clustering of cultivar Nipponbare Early (NEB1, NEB2, NEE2, and NEE1). This result makes sense as we observed previously that treatment type had the most influence on the microbe composition.  

**Exercise 9:**
Discuss some of the potential physiologies of the predominant groups of microbes correlated with the various rice microbiome samples. This information can be taken from the displays in Exercise 3.  
*Hint* Use [MicrobeWiki](http://microbewiki.kenyon.edu/index.php/MicrobeWiki) or other online sites to learn more about these microbes.  
> Overall | Proteobacteria are gram-negative bacteria that possesses an outer membrane (OM), a peptidoglycan layer, periplasm. It contains two kinds of lipids on the outer membrane, lipopolysaccharide (LPS) and phospholipids as well as some unique proteins. The outer membrane contains Porins that are non-specific pores/channels that allows passage of small hydrophilic molecules. Nitrifying bacteria fall under proteobacteria, which are widespread in soil and aquatic environments and play an integral role in the nitrogen cycle. It makes sense that this group of bacteria is most prevalent in the samples. 
 
> Root Surface | Bacteroidetes are gram-negative, nonsporeforming, anaerobic or aerobic, rod-shaped bacteria that are widely distributed in the environment, including in soil, sediments, sea water, and guts of animals.  
 
> Root inside | Spirochaetes are long, slender bacteria usually only a fraction of a micron in diameter but 5 to 250 microns long. Tightly coiled in structure, their appearance resembles that of a spring. Members of this group also have axial filaments that run along the outside of the protoplasm, but inside an outer sheath. They are gram-negative-like in that they possess inner and outer membranes separated by a peptidoglycan containing periplasmic space. 
 
> 1mm Soil | Gemmatimonadetes are a phylum of bacteria created for the species Gemmatimonas aurantiaca. Makes 2% of the soil bacterial communities and is identified as one of the top nine phyla found in soils. It is gram-negative, rod shaped, non-sporulating and grows by both aerobic and anaerobic respiration. It also uses a flagella for movement. 





