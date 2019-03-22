
library(shiny)
library(ggplot2)
library(reshape2)

counts <- as.matrix(read.csv("GxE_Internode_Counts.csv",row.names=1))

#Set NA to 0
counts[is.na(counts)] <- 0
    
#Create a new dataframe
sample.description <- data.frame(
  sample=colnames(counts),
  
  #This next line searches for IMB211 or R500 in the colnames of counts and returns anything that matches
  #In this way we can extract the genotype info.
  gt=regmatches(colnames(counts),regexpr("R500|IMB211",colnames(counts))),
  
  #Same method to get the treatment
  trt=regmatches(colnames(counts),regexpr("NDP|DP",colnames(counts))),
  
  #Same method to get the replicant 
  rep=regmatches(colnames(counts),regexpr("REP1|REP2|REP3", colnames(counts)))
)

shinyServer(function(input, output) {
  
  output$GenePlot <- renderPlot({
    
    #Make object containing RNAseq reads for gene of interest
    tmp.data.frame <- data.frame(counts[input$gene,])

    colnames(tmp.data.frame) <- "RNAseq_reads"
    
    #merge sample.description with dataframe 
    tmp.data.frame <- merge(tmp.data.frame, sample.description, by.x="row.names", by.y="sample")
    
    #Plot the graph
    p1 <- ggplot(tmp.data.frame, aes(x=rep, y=RNAseq_reads, fill=trt)) + geom_bar(stat = "identity")
    p1 + facet_grid(gt ~ trt) + ylab("RNAseq Read Counts") + xlab("") + ggtitle(input$gene)
  })
})