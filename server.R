#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
#

library(shiny)

# Define server logic required to draw a plot
shinyServer(function(input, output) {
    
    mtcars$gearext <- ifelse(mtcars$gear > 1, mtcars$gear + 1, mtcars$gear)
    
    model1 <- lm(mpg ~ gear, data = mtcars) # model based on observation gear
    model2 <- lm(mpg ~ gearext, data = mtcars) # model based on one gear upshift
    
    model1pred <- reactive({
        sliderSpeedInput <- input$sliderSpeed
        gearSpdInput <- if (sliderSpeedInput == 10) 1
                        else if (sliderSpeedInput > 10 && sliderSpeedInput <= 30) 2
                        else if (sliderSpeedInput >= 31 && sliderSpeedInput <= 38) 3
                        else if (sliderSpeedInput >= 39 && sliderSpeedInput <= 50) 4
                        else if (sliderSpeedInput >= 51) 5
        
        predict(model1, newdata = data.frame(gear = gearSpdInput))
    })
    
    model2pred <- reactive({
        sliderSpeedInput <- input$sliderSpeed
        gearSpdInput <- if (sliderSpeedInput == 10) 1
                        else if (sliderSpeedInput > 10 && sliderSpeedInput <= 30) 2
                        else if (sliderSpeedInput >= 31 && sliderSpeedInput <= 38) 3
                        else if (sliderSpeedInput >= 39 && sliderSpeedInput <= 50) 4
                        else if (sliderSpeedInput >= 51) 5
        
        predict(model2, newdata = data.frame(gear = gearSpdInput,
                                             gearext = ifelse(gearSpdInput > 1, gearSpdInput + 1, gearSpdInput)))
    })
    
    output$Plot1 <- renderPlot({
        
        sliderSpeedInput <- input$sliderSpeed
        
        gearSpdInput <- if (sliderSpeedInput == 10) 1
                        else if (sliderSpeedInput > 10 && sliderSpeedInput <= 20) 2
                        else if (sliderSpeedInput >= 21 && sliderSpeedInput <= 30) 3
                        else if (sliderSpeedInput >= 31 && sliderSpeedInput <= 50) 4
                        else if (sliderSpeedInput >= 51) 5
        
        
        plot(mtcars$gear, mtcars$mpg, 
             xlab = "Speed/Gear Ratio",
             ylab = "Miles Per Gallon", 
             bty = "n", 
             pch = 16,
             xlim = c(1, 6),
             ylim = c(10,35)
        )
        
        if(input$showModel1){
            abline(model1, col = "red", lwd = 2)
        }
        
        if(input$showModel2){
            model2lines <- predict(model2, newdata = data.frame(
                                 gear = 1:5, 
                                 gearext = ifelse(1:5 > 1, 1:5 + 1, 1:5)
                             ))
                             lines(1:5, model2lines, col = "blue", lwd = 2)
        }
        
        legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), 
                           pch = 16,
                           col = c("red", "blue"),
                           bty = "n",
                           cex = 1.2)
        
        points(gearSpdInput, model1pred(), col = "red", pch = 16, cex = 2)
        points(gearSpdInput, model2pred(), col = "blue", pch = 16, cex = 2)
    })
    
    
    output$pred1 <- renderText({
        model1pred()
    })
    
    output$pred2 <- renderText({
         model2pred()
    })
})
