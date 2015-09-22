library(shiny)
shinyUI(
      fluidPage(
            titlePanel("Predicting fuel efficiency(mpg) of a car"),
            
            sidebarLayout(
                  
                  sidebarPanel(
                        h2("Input Panel"),
                        sliderInput(inputId = "wt", label = "Weight of the car(lb/1000):",
                                    min = 1.500, max = 5.500, value = 3.325, step = 0.001),
                        sliderInput(inputId = "qsec", label = "1/4 mile time(seconds):",
                                    min = 14.00, max = 23.00, value = 17.71, step = 0.01),
                        radioButtons(inputId = "am", label = "Transmission type:",
                                     choices = c("Automatic" = 0,"Manual" = 1)),
                        p("The ranges of the input variables weight and 1/4 mile 
                          time are selected so that these variables fall within
                          their respective ranges in the mtcars dataset in R"),
                        h4("Note:"),
                        p("Since this predictor app is based on the mtcars dataset and the 
                          mtcars data set was compiled in 1974, this app will give
                          reasonalble results for 1970s model cars. For modern cars
                          it may not work so well."),
                        p("Also some improbable combinations like very high weight
                          and less 1/4 mile time will give negative values for mpg.
                          That simply tells us that a car with such configuration was
                          not possible during 1970s")
                  ),
                  
                  mainPanel(
                        tabsetPanel(
                              tabPanel("Prediction Outcome",
                                       p("Read the Documentation tab to get started with using this app."),
                                       p("Few users may experience slight lag(1 or 2 seconds) before their inputs are evaluated
                                         and results shown. We beg you to bear with us."),
                                       h2("Result of Prediction"),
                                       p("You entered the car weight(lb/1000) as"),
                                       verbatimTextOutput("wt"),
                                       p("You entered the quater mile time(seconds) as"),
                                       verbatimTextOutput("qsec"),
                                       p("You entered the transmission type as
                                         (0 = Automatic, 1 = Manual)"),
                                       verbatimTextOutput("am"),
                                       p("The mileage (miles per gallon) of a car 
                                         with the given weight, quater mile time
                                         and transmission type is"),
                                       verbatimTextOutput("pred")
                                       ),
                              tabPanel("Documentation",
                                       h3("What does this application do?"),
                                       p("This app predicts the mileage(miles per gallon)
                                         of a car which has a certain weight, quater mile time(
                                         measure of velocity; more the quater mile time less the 
                                         velocity and vice versa) and transmission type."),
                                       h3("How to use this application?"),
                                       p("The sliders in the side bar can be used to input 
                                         the weight(lb/1000) and quater mile time(seconds).
                                         The radio buttons can be used to select the type of transmission.
                                         Based on these inputs the miles per gallon (mpg) 
                                         estimate of the car is shown in the Prediction Outcome
                                         tab of the main panel"),
                                       h3("How was this predictor app built?"),
                                       h4("Data Processing"),
                                       p("This predictor was trained on the mtcars
                                         data set in R. The data set was first partitioned
                                         into training and testing data sets. The training
                                         set was chosen so that it contains only 
                                         70% of randomly selected rows of the entire 
                                         mtcars dataset. The remaining data is in the 
                                         test dataset and was used to estimate out 
                                         of sample error"),
                                       h4("Building The Model"),
                                       p("A linear regression model is fit on the
                                         training data with miles per gallon (mpg)
                                         as the outcome and weight(wt), quater mile 
                                         time(qsec) and type of transmission(am) as the 
                                         predictors. An interaction term between 
                                         type of transmission and weight(am:wt) was aslo
                                         selected as another predictor. Even though other 
                                         variables like horsepower(hp), no. of cylinders
                                         (cyl), etc. were also available in the data set,
                                          they were not used as predictors. The choice 
                                         of predictors is based on an elaborate strategy.
                                         The selected model explains about 87% of variability
                                         in the data. Hence, it can be seen as a pretty good model."),
                                       h4("Applying the model on test set and estimating out of 
                                          sample error"),
                                       p("The linear model built on the training set was
                                         applied to the test set. The root mean squared error
                                         is used as the error measure for the continuous mpg
                                         values and the out of sample error rate was found as"),
                                       verbatimTextOutput("testerror"),
                                       p("As the error rate of this model is quite low we can
                                         say that the mpg predictions from this model are quite
                                         reliable.")
                                       )
                        )
                  )
            )
      )
)