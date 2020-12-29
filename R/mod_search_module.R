#' search_module UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_search_module_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidPage(
      titlePanel('strain info'),
      sidebarLayout(
        sidebarPanel(
          textInput('id', 'id of strains:', value = '')
        ),
        mainPanel(
          DT::DTOutput('strain_info')
        )
      )
    )
  )
}

    
#' search_module Server Function
#'
#' @noRd 

mod_search_module_server <- function(input, output, session){
  ns <- session$ns
  strain_id <- reactive({as.numeric(as.vector(sapply(strsplit(input$id, split = '\\s', perl = TRUE),
                                function(x){x[!x=='']})))})
  strain_db <- read.table('data/strainInfo.tsv', sep = '\t',
                          quote = '',
                          as.is = TRUE)
  print(strain_db)
  output$strain_info <- DT::renderDataTable({
    strain_db[strain_db$ID %in% strain_id, ]
  })
}
    
## To be copied in the UI
# 
    
## To be copied in the server
# 
 
