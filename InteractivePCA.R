library(shiny)

pcaCharts <- function(x) {
  x.var <- x$sdev ^ 2
  x.pvar <- x.var/sum(x.var)
  x.pvar
  par(mfrow=c(1,2))
  plot(x.pvar,xlab="Principal component", ylab="Proportion of variance explained", ylim=c(0,1), type='b')
  plot(cumsum(x.pvar),xlab="Principal component", ylab="Cumulative Proportion of variance explained", ylim=c(0,1), type='b')
}

ui <- fluidPage(
  titlePanel("Principal Component Analyis"),p("Interactive Principal Component Analysis of expression matrices (David Lauenstein. Last Update: 24.10.2017)"), 
    sidebarPanel(
      fileInput("file1", "Choose an Expression Matrix",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv")
                ),
    tags$hr(),
    checkboxInput("header", "Header", TRUE),
    checkboxGroupInput("delimiter", "Delimiter:",
                       c("Tab" = "\t",
                         "Comma" = ",",
                         "Semicolon" = ";")),
    textInput('labels',h6('Add Sample Labels (comma separated)'), value='sample1, sample2')
  ),
    mainPanel(h3("Analysis Output",align = "center"),tabsetPanel(
      tabPanel('Dataset Preview', tableOutput('dataset')),
      tabPanel("PCA Charts", fluidRow(plotOutput("pcacharts"),
                                      htmlOutput('pcastats'))),
               tabPanel("PCA Biplot", plotOutput("pcabiplot"))
      )
      )
              

    )

server <- function(input, output) {
  
  
  output$dataset <- renderTable({
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    exprmat = read.csv(inFile$datapath, header = input$header,sep = input$delimiter,dec = '.')
    if (input$header == FALSE){
      colnames(exprmat) = strsplit(input$labels,',')[[1]]
    }
    exprmat[1:20,]
    
  })
  
  
  output$pcastats <- renderUI({
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    exprmat = read.csv(inFile$datapath, header = input$header,sep = input$delimiter,dec = '.')
    exprmat_pca = princomp(as.matrix(exprmat))
    exprmat_pca.var <- exprmat_pca$sdev ^ 2
    exprmat_pca.pvar <- exprmat_pca.var/sum(exprmat_pca.var)
    
    HTML(paste('<b>Proportion of Variance explained:</b>','<br>','<br>',
               'Component 1:', round(exprmat_pca.pvar[1],4)*100,'%','<br>',
               'Component 2: ',round(exprmat_pca.pvar[2],4)*100,'%','<br>',
               'Component 3: ',round(exprmat_pca.pvar[3],4)*100,'%','<br>',
               'Component 4: ',round(exprmat_pca.pvar[4],4)*100,'%','<br>',
                'Component 5: ',round(exprmat_pca.pvar[5],4)*100,'%'))
  })

  output$pcacharts <- renderPlot({
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    exprmat = read.csv(inFile$datapath, header = input$header,sep = input$delimiter,dec = '.')
    exprmat_pca = princomp(as.matrix(exprmat))
    
    pcaCharts(exprmat_pca)
    
  })
  output$pcabiplot <- renderPlot({
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    exprmat = read.csv(inFile$datapath, header = input$header,sep = input$delimiter,dec = '.')
    
    colnames(exprmat) = strsplit(input$labels,',')[[1]]
    
    exprmat_pca = princomp(as.matrix(exprmat))
    
    biplot(exprmat_pca)
    
  })
}
    
# Create Shiny app ----
shinyApp(ui = ui, server = server)
