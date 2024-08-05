install.packages("shiny")
install.packages("RJDBC")

library(shiny)
library(RJDBC)

# Define UI
ui <- fluidPage(
  titlePanel("SQL Data Viewer"),
  mainPanel(
    tableOutput("sparqlTable")
  )
)

# Define server logic for JDBC
server <- function(input, output) {
  # Initialize Java
  .jinit()
  
  # JDBC driver and connection details
  jdbc_driver <- JDBC(driverClass = "virtuoso.jdbc4.Driver", classPath = "/Library/Java/Extensions/virtjdbc4_3.jar")
  jdbc_url <- "jdbc:virtuoso://localhost:1111" # Add your JDBC URL here
  jdbc_user <- "demo"
  jdbc_password <- "demo"
  
  # Connect to the JDBC DSN
  conn <- dbConnect(jdbc_driver, jdbc_url, jdbc_user, jdbc_password)
  
  # SQL query
  query <- "status()"
  
  # Execute the query
  data <- dbGetQuery(conn, query)
  
  # Close the connection
  dbDisconnect(conn)
  
  # Output the data as a table
  output$sparqlTable <- renderTable({
    data
  })
}

# Run the application
shinyApp(ui = ui, server = server)
