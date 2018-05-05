library(shiny)
shinyUI(fluidPage(
  titlePanel(fluidRow(align="center","Predict Tree Height From Girth")),
  sidebarLayout(
    sidebarPanel(h5("Use the sliderbar below to select the girth of the tree.  The girth of a tree is a measurement of the distance around the trunk measured  at 4.5 feet above ground level."),
      sliderInput("sliderGirth","" , 8, 21, value = 8),
      h5("Click the checkboxes below to select which models to view"),
      checkboxInput("showM1", "Show/Hide Model 1", value = TRUE),
      checkboxInput("showM2", "Show/Hide Model 2", value = TRUE)
     
    ),
    mainPanel(
      plotOutput("plot1"),
      fluidRow(align="center",textOutput("p1")),
      fluidRow(align="center",textOutput("p2"))) 
    )
  )
)