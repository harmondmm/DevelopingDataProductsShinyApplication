#
# This is the user-interface definition of a Shiny web application. 
#
# Purpose: This Shiny application uses the mtcars data set to predict the miles per gallon (MPG)
# based on the users input speed which is used to determine the predicted gear of the car to
# perform the calculation.

library(shiny)

# Define UI for application
shinyUI(fluidPage(

    # Application title
    titlePanel("Predict MPG based on Forward Speed/Gear Ratio"),

    # Sidebar with a slider input
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderSpeed",
                        "What is the Speed of the car?",
                        min = 10,
                        max = 70,
                        value = 10),
            checkboxInput("showModel1", "Show/Hide Model 1 (Red)", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Model 2 (Blue)", value = TRUE),
            submitButton("Submit")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("Plot1"),
            
            h3("Model 1 - Predicted Miles Per Gallon based on Speed/Gear Ratio:"),
            textOutput("pred1"),
            
            h3("Model 2 - Predicted Mile Per Gallon based on One Gear Upshift Speed/Gear Ratio:"),
            textOutput("pred2")
        )
    )
  )
)
