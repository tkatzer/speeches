library(shiny)
library(ggplot2)
library(DT)
# for the diamonds dataset
TabelleTim <- read.csv("~/Dropbox/Speeches/TabelleTim.csv", sep=";")
ui <- fluidPage(
  title = "Examples of DataTables",
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
        'input.dataset === "TabelleTim"',
        checkboxGroupInput("show_vars", "Columns in diamonds to show:",
                           names(TabelleTim), selected = names(TabelleTim))
      )
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel("TabelleTim", DT::dataTableOutput("mytable1"))
      )
    )
  )
)

server <- function(input, output) {
  
  # choose columns to display
  diamonds2 = TabelleTim[sample(nrow(TabelleTim), 1000), ]
  output$mytable1 <- DT::renderDataTable({
    DT::datatable(diamonds2[, input$show_vars, drop = FALSE])
  })
  
  
}

shinyApp(ui, server)