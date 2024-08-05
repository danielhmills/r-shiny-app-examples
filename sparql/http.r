# Install required packages
install.packages("shiny")
install.packages("httr")
install.packages("readr")

library(shiny)
library(httr)
library(readr)

# Define UI
ui <- fluidPage(
  titlePanel("SPARQL Data Viewer"),
  mainPanel(
    tableOutput("sparqlTable")
  )
)

# Define server logic
server <- function(input, output) {
  # SPARQL query
  query <- "
    SELECT * FROM <urn:analytics> WHERE {
      ?s ?p ?o.
    }
  "
  
  # SPARQL endpoint URL
  sparql_url <- "http://linkeddata.uriburner.com/sparql/"
  
  # Fetch the data with an HTTP header to accept CSV
  response <- GET(
    url = sparql_url,
    query = list(query = query, format = "text/csv"),
    add_headers(Accept = "text/csv")
  )
  content <- content(response, "text")
  data <- read_csv(content)
  
  # Output the data as a table
  output$sparqlTable <- renderTable({
    data
  })
}

# Run the application
shinyApp(ui = ui, server = server)
