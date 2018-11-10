#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(RMySQL)
# Define UI for application that draws a histogram


# options(mysql = list(
#   "host" = "162.243.186.67",
#   "port" = 3306,
#   "user" = "ben",
#   "password" = "Charlene81"
# ))
# 
# databaseName <- "rstudio"
# table <- "potluck"

ui <-  fluidPage(
  mainPanel("Enter SQL Data",
            headerPanel("SQL Connection:"),
            # sidebarPanel(
            #   fileInput("file", label = h3("File input",multiple = FALSE,accept = NULL,width=NULL),
            #             accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv','.xlsx')),
            #   textInput("database",label = "Enter Database Name Here:",value = ""),
            #   textInput("host",label = "Enter hostname/url here:",value = ""),
            #   textInput("user",label = "Enter user name here:",value = ""),
            #   passwordInput("password",label = "Password",value = ""),
            #   textInput( "texting",label = "Enter SQL Query Here:",placeholder = "SELECT * FROM boston;"),
            #   actionButton("connecter",label = "Connect"),
            #   actionButton("disconnec",label = "Disconnect"),
            #   textInput("dbname",label = "Enter Table Name",value = ""),
            #   actionButton("write",label = "Write Table"),
            #   textInput("queryname",label = "Enter file name here:"),
            #   radioButtons("filetype",label = "File Extension Type",choices = c(".txt",".csv",".xls"),selected = ".csv"),
            #   downloadButton("downloadtwo", label="Download SQL Data", class = "butt")
            #   #actionButton("list", label="Connection List", class = "butt")
            # ),
            tabsetPanel(
              tabPanel(title = "SQL DBC",
                       fileInput("file", label = h3("File input",multiple = FALSE,accept = NULL,width=NULL),
                                 accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv','.xlsx')),
                       textInput("database",label = "Enter Database Name Here:",value = ""),
                       textInput("host",label = "Enter hostname/url here:",value = ""),
                       textInput("user",label = "Enter user name here:",value = ""),
                       passwordInput("password",label = "Password",value = ""),
                       textInput( "texting",label = "Enter SQL Query Here:",placeholder = "SELECT * FROM boston;"),
                       actionButton("connecter",label = "Connect"),
                       actionButton("disconnec",label = "Disconnect"),
                       textInput("dbname",label = "Enter Table Name",value = ""),
                       actionButton("write",label = "Write Table"),
                       textInput("queryname",label = "Enter file name here:"),
                       radioButtons("filetype",label = "File Extension Type",choices = c(".txt",".csv",".xls"),selected = ".csv"),
                       downloadButton("downloadtwo", label="Download SQL Data", class = "butt")
                       #actionButton("list", label="Connection List", class = "butt")
              ),
              tabPanel(title = "Input Data",
                       div(
                         id = "form",
                         textInput("table",label = "Table",value = "INSERT INTO table () VALUES ()"),
                         # textInput("id","ID",value = "5"),
                         # textInput("name", "Name",value = "Harold"),
                         # textInput("food","Food",value = "Chicken"),
                         # textInput("confirmed","Confirmed",value = "N"),
                         # dateInput("signup","Sign up Date",format = "yyyy-mm-dd"),
                         # dbSendStatement(conn = mydb,statement = 
                         # "INSERT INTO potluck (id, name, food, confirmed, signup_date) VALUES ('4', 'Kevin', 'Apple Pie', 'Y','2012-4-11');")
                         # 
                         # checkboxInput("used_shiny", "I've built a Shiny app in R before", FALSE),
                         # sliderInput("r_num_years", "Number of years using R", 0, 25, 2, ticks = FALSE),
                         # selectInput("os_type", "Operating system used most frequently",
                         #             c("",  "Windows", "Mac", "Linux")),
                         actionButton("submit", "Submit", class = "btn-primary")
                       )
              ),
              tabPanel(title = "SQL Query",
                       textInput(inputId = "text2",label = "SQL Query",placeholder = "SELECT * FROM table"),
                       actionButton("submit2", "Submit", class = "btn-primary")
                       ),
              tabPanel(title = "SQL Create Table",
                       textInput(inputId = "text3",label = "Create Table",value = "CREATE TABLE new"),
                       actionButton("submit3", "Submit", class = "btn-primary")
                       ),
              tabPanel("SQL Output",tableOutput("tbl")),
              tabPanel("SQL Tables",tableOutput("table"))
              
            )))

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  options(mysql = list(
    "host" = "162.243.186.67",
    "port" = 3306,
    "user" = "ben",
    "password" = "Charlene81"
  ))
  
  databaseName <- "rstudio"
  #tableser <- "potluck"
  
  observeEvent(input$submit,{
    # Connect to the database
    db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host, 
                    port = options()$mysql$port, user = options()$mysql$user, 
                    password = options()$mysql$password)
    # Construct the update query by looping over the data fields
    # query <- sprintf(
    #   "INSERT INTO %s (%s) VALUES ('%s')",
    #   table, 
    #   paste(names(data), collapse = ", "),
    #   paste(data, collapse = "', '")
    # )
    # Submit the update query and disconnect
    query <- paste(input$text,";")
    dbGetQuery(db, query)
    dbDisconnect(db)
  })
  
  observeEvent(input$submit2,{
    # Connect to the database
    db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host, 
                    port = options()$mysql$port, user = options()$mysql$user, 
                    password = options()$mysql$password)
    # Construct the update query by looping over the data fields
    # query <- sprintf(
    #   "INSERT INTO %s (%s) VALUES ('%s')",
    #   table, 
    #   paste(names(data), collapse = ", "),
    #   paste(data, collapse = "', '")
    # )
    # Submit the update query and disconnect
    query <- paste(input$text2,";")
    dbGetQuery(db, query)
    dbDisconnect(db)
  })
  
  observeEvent(input$submit3,{
    # Connect to the database
    db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host, 
                    port = options()$mysql$port, user = options()$mysql$user, 
                    password = options()$mysql$password)
    # Construct the update query by looping over the data fields
    # query <- sprintf(
    #   "INSERT INTO %s (%s) VALUES ('%s')",
    #   table, 
    #   paste(names(data), collapse = ", "),
    #   paste(data, collapse = "', '")
    # )
    # Submit the update query and disconnect
    query <- paste(input$text3,";")
    dbGetQuery(db, query)
    dbDisconnect(db)
  })
  
  tbl<- reactive({
    db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host, 
                    port = options()$mysql$port, user = options()$mysql$user, 
                    password = options()$mysql$password)
    query <- (paste0(input$texting,";"))
    dbGetQuery(db, query)
    
  })
  
  output$tbl<-renderTable(tbl())
  
  tables<- reactive({
    db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host, 
                    port = options()$mysql$port, user = options()$mysql$user, 
                    password = options()$mysql$password)
    query <- (paste0(input$texting,";"))
    dbListTables(db)
    
  })
  
  output$table <- renderTable(tables())
}

# Run the application 
shinyApp(ui = ui, server = server)

