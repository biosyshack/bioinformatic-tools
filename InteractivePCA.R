library(shiny)

ui <- fluidPage(
  titlePanel("Principal Component Analyis"),
  sidebarLayout(
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
                         "Semicolon" = ";"))
  ),
    mainPanel(
      plotOutput("pca"))
  )
)

server <- function(input, output) {
  output$pca <- renderPlot({
    inFile <- input$file1
      
    if (is.null(inFile))
      return(NULL)
      
    trans = read.csv(inFile$datapath, header = input$header,sep = input$delimiter,dec = '.')
    trans_pca = princomp(as.matrix(trans))
    biplot(trans_pca)
  })
}
    


# Create Shiny app ----
shinyApp(ui = ui, server = server)
