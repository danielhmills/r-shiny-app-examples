# r-shiny-app-exaples

Example templates for creating [Shiny](https://shiny.posit.co) Applications with Virtuoso as a data source.

SQL Query Examples are available in the `sql` Directory

SPARQL Examples are available in the `sparql`

## Note for SPARQL users: 

When using ODBC or JDBC, add "SPARQL" to the beginning of the query to invoke Virtuoso's SPARQL-within-SQL ([1](https://medium.com/virtuoso-blog/spasql-about-8486deecba66), [2](https://docs.openlinksw.com/virtuoso/rdfsparqlinline/)) funtionality.

### Example
`  query <- "SPARQL SELECT * FROM <urn:analytics> WHERE { ?s ?p ?o. }"
`