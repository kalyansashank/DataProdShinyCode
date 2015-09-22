library(shiny)
library(caret)
library(datasets)
data("mtcars")
set.seed(101)
mtTrainId <- createDataPartition(mtcars$mpg, p = 0.7, list = FALSE)
mtTrain <- mtcars[mtTrainId,]
mtTest <- mtcars[-mtTrainId,]
modelfit <- lm(mpg~wt+qsec+am+am:wt,data = mtTrain)
coef <- modelfit$coefficients
testPred <- predict(modelfit, mtTest)
testRMSError <- sqrt(mean((mtTest$mpg-testPred)^2)) 
shinyServer(
      function(input,output){
            wt <- reactive({as.numeric(input$wt)})
            qsec <- reactive({as.numeric(input$qsec)})
            am <- reactive({as.numeric(input$am)})
            output$am <- renderText(am())
            output$wt <- renderText({input$wt})
            output$qsec <- renderText({input$qsec})
            output$pred <- renderText(coef[1] + coef[2]*wt() + coef[3]*qsec() +
                                             coef[4]*am() + coef[5]*am()*wt())
            output$testerror <- renderText({testRMSError}) 
      }
)