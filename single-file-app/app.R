### load packages ----
library(shiny)
library(palmerpenguins)
library(tidyverse)
library(DT)

### UI ----
# fluidpage contains all components of ui, establishes webpage of rows and columns that adjusts to window size

ui <- fluidPage(
  
  # app title
  tags$h1("First App Title"),  # could also h1("title)
  
  # app subtitle
  tags$p(strong("Exploring Antarctic Penguin Data")),
  
  # body mass sliderInput
  sliderInput(inputId = "body_mass_input",
              label = "Select a range of body masses (g)",
              min = 2700, max = 6300, value = c(3000, 4000)),
  
  # body mass plot output
  plotOutput(outputId = "bodyMass_scatterPlot"), # connect with server
  
  # select year data 
  checkboxGroupInput(inputId = "year_input", label = "Select year(s):",
                     choices = c("The Year 2007" = "2007", "2008", "2009"), # or unique(penguins$year)
                     selected = c("2007","2008")),

  # table year output
  DT::dataTableOutput(outputId = "penguin_data")
  
  
) # END fluidPage



### Server ----

server <- function(input, output) {
  
  # filter data
  body_mass_df <- reactive({ # need to create reactive dataframe
    penguins |> 
      filter(body_mass_g %in% input$body_mass_input[1]:input$body_mass_input[2])
  })
  
  # render scatter plot
  output$bodyMass_scatterPlot <- renderPlot({
    
  # code to generate plot
    # must call reactive dataframe with name()
  ggplot(na.omit(body_mass_df()), aes(x = flipper_length_mm, y = bill_length_mm,
  color = species, shape = species)) +
  geom_point() +
      # important to set colors per variable for shiny app
  scale_color_manual(values = c("Adelie" = "#FEA346", "Chinstrap" = "#B251F1", "Gentoo" = "#4BA4A4")) +
  scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15)) +
  xlab("Flipper Length (mm)") +
  ylab("Bill Length (mm)")
  
  })
    
  # filter years
  filtered_years <- reactive({
    penguins |> 
      filter(year %in% c(input$year_input))
  })
  
  # data table
  output$penguin_data <- DT::renderDataTable({
    DT::datatable(filtered_years())
    
    
  }) # curly brackets allow endless lines of code
  
  
} # END server


### combine ui & server ----
shinyApp(ui = ui, server = server)
