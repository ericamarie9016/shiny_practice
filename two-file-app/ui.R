
ui <- navbarPage( # Sets top navbar for each page
  
  title = "LTER Animal Data Explorer",
  
  # Page 1
  tabPanel(title = "About this App", # sets different pages
          "background info here"
           ),  # END page 1
  
  # Page 2
  tabPanel(title = "Explore the Data",
           
           # tabset panel
           tabsetPanel(
             
             # trout tab
             tabPanel(
               
             )    # END trout tab
             
           )   # END tabsetPanel
           
           
           )   # END page 2
)
