library(shiny)

counts <- read.csv("GxE_Internode_Counts.csv",row.names=1)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("B. rapa Gene Expression"),
  
  # Get user to select a gene for display
  sidebarLayout(
    sidebarPanel(
      helpText("Choose a gene ID from the list.  The graph displays read counts of each replicate"),
      selectInput("gene","GeneID",choices= as.list(row.names(counts)))
    ),
    
    # Show a plot of the generated plots
    mainPanel(
       plotOutput("GenePlot")
    )
  )
))
