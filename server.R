library(shiny)
shinyServer(function(input, output) {
  trees$Girth2 <- ifelse(trees$Girth - 12 > 0, trees$Girth - 12, 0)
  m1 <- lm(Height ~ Girth, data = trees)
  m2 <- lm(Height ~ Girth2 + Girth, data = trees)
  
  m1pred <- reactive({
    GirthInput <- input$sliderGirth
    predict(m1, newdata = data.frame(Girth = GirthInput))
  })
  
  m2pred <- reactive({
    GirthInput <- input$sliderGirth
    predict(m2, newdata = 
              data.frame(Girth = GirthInput,
                         Girth2 = ifelse(GirthInput - 12 > 0,
                                        GirthInput - 12, 0)))
  })
  
  output$plot1 <- renderPlot({
    GirthInput <- input$sliderGirth
    
    plot(trees$Girth, trees$Height, xlab = "Girth (MPH)", 
         ylab = "Heigh(Feet)", bty = "n", pch = 16,
         xlim = c(8,21), ylim = c(50, 100))
    if(input$showM1){
      abline(m1, col = "brown", lwd = 2)
    }
    if(input$showM2){
      m2lines <- predict(m2, newdata = data.frame(
        Girth = 8:21, Girth2 = ifelse(8:21 - 12 > 0, 8:21 - 12, 0)
      ))
      lines(8:21, m2lines, col = "blue", lwd = 2)
    }
    legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
           col = c("red", "blue"), bty = "n", cex = 1.2)
    points(GirthInput, m1pred(), col = "brown", pch = 16, cex = 2)
    points(GirthInput, m2pred(), col = "blue", pch = 16, cex = 2)
  })
  
  output$p1 <- renderText({paste("Predicted Tree Height - Model 1:",round(m1pred(),1),"feet"
  )})
  
  output$p2 <- renderText({paste("Predicted Tree Height - Model 2:",round(m2pred(),1),"feet"
  )})

})