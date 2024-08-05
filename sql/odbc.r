install.packages("shiny")
install.packages("httr")
install.packages("readr")


library(shiny)

# Define UI
ui <- fluidPage(
  titlePanel("SPARQL Data Viewer"),
  mainPanel(
    tableOutput("sparqlTable")
  )
)

library(RODBC)

# Define server logic for ODBC
server_odbc <- function(input, output) {
  # ODBC DSN
  dsn <- "Demo DB"
  username <- 'demo'
  password <- 'demo'
  
  # Connect to the ODBC DSN
  conn <- odbcConnect(dsn, uid = username, pwd = password)
  
  # SQL query
  query <- "SELECT TOP 10 FintAccountNumber, PrimaryAccountHolderID, Balance FROM Demo.fint.account ORDER BY Balance DESC"
  
  # Execute the query
  data <- sqlQuery(conn, query)
  
  # Close the connection
  close(conn)
  
  # Output the data as a table
  output$sparqlTable <- renderTable({
    data
  })
}

# Choose the appropriate server function based on your connection method
server <- server_odbc

# server <- server_odbc  # for ODBC connection

# Run the application
shinyApp(ui = ui, server = server)