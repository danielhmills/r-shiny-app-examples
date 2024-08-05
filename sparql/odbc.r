install.packages("shiny")
install.packages("RODBC")

library(shiny)

# Define UI
ui <- fluidPage(
  titlePanel("SQL Data Viewer"),
  mainPanel(
    tableOutput("sparqlTable")
  )
)

library(RODBC)

# Define server logic for ODBC
server <- function(input, output) {
  # Add Your ODBC DSN Here
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

# Run the application
shinyApp(ui = ui, server = server)

