
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)


shinyServer(function(input, output) {
    
    if (!exists("censusTrain") 
        | !exists("censusTest") 
        | !exists("c50Model")
        | !exists("logisticModel")
        | !exists("cartModel")) {
        message("Downloading files from archive")
        download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data", "census_train.csv",
                      method = "curl")
        download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.test", "census_test.csv",
                      method = "curl")
        
        message("Reading CSV files")
        censusTrain = read.csv("census_train.csv", sep = ",", header = FALSE,
                               strip.white = TRUE,
                               col.names = c("age", "workClass", "fnlwgt",
                                             "education", "educnum",
                                             "maritalStatus", "occupation",
                                             "relationship", "race", "gender",
                                             "capitalGain", "capitalLoss",
                                             "hoursPerWeek", "nativeCountry",
                                             "incomeFlag"), na.strings = c(" ?"))
        censusTrain = censusTrain[which(complete.cases(censusTrain)),
                                  -grep("fnlwgt|educnum",  colnames(censusTrain))]
        
        
        censusTest = read.table("census_test.csv", sep = ",", skip = 1, header = FALSE,
                                strip.white = TRUE,
                                col.names = c("age", "workClass", "fnlwgt",
                                              "education", "educnum",
                                              "maritalStatus", "occupation",
                                              "relationship", "race", "gender",
                                              "capitalGain", "capitalLoss",
                                              "hoursPerWeek", "nativeCountry",
                                              "incomeFlag"), na.strings = c(" ?"))
        censusTest = censusTest[which(complete.cases(censusTest)),
                                -grep("fnlwgt|educnum",  colnames(censusTest))]
        censusTest$incomeFlag = gsub("\\.","",censusTest$incomeFlag)
        
        
        message("loading libraries")
        library(C50)
        library(caret)
        library(rpart)
        
        message("Building models")
        c50Model = C5.0(incomeFlag ~ ., data = censusTrain)
        
        cartModel = rpart(incomeFlag ~ ., data = censusTrain)
        
        logisticModel = glm(incomeFlag ~ ., data = censusTrain, family = "binomial")
        message("Load and build complete")
    }
    
    message("Application ready for input")

    datarow <- reactive({data.frame(age = input$age, 
                                    workClass = input$workClass,
                                    education = input$education,
                                    maritalStatus = input$maritalStatus, 
                                    occupation = input$occupation,
                                    relationship = input$relationship,
                                    race = input$race,
                                    gender = input$gender,
                                    capitalGain = input$capitalGain,
                                    capitalLoss = input$capitalLoss,
                                    hoursPerWeek = input$hoursPerWeek,
                                    nativeCountry = input$nativeCountry)})
    output$age = renderText({input$age})
    output$workClass = renderText({input$workClass})
    output$education = renderText({input$education})
    output$occupation = renderText({input$occupation})
    output$maritalStatus = renderText({input$maritalStatus})
    output$relationship = renderText({input$relationship})
    output$race = renderText({input$race})
    output$gender = renderText({input$gender})
    output$capitalGain = renderText({input$capitalGain})
    output$capitalLoss = renderText({input$capitalLoss})
    output$hoursPerWeek = renderText({input$hoursPerWeek})
    output$nativeCountry = renderText({input$nativeCountry})

    c50Prob <- reactive({a = predict(c50Model,
                                       newdata = datarow(), type = "prob")
                        a[,2]})
  
    cartProb <- reactive({b = predict(cartModel, newdata = datarow(), 
                                        type = "prob")
                         b[,2]})

    logisticProb <- reactive({c = predict(logisticModel, 
                                  newdata = datarow(), type = "response")
                             c})
  
   output$c50Text <- renderText({ 
        paste("Probability of $50K+ according to C5.0:" , round(c50Prob(),2))
   })
    output$cartText <- renderText({ 
        paste("Probability of $50K+ according to Cart: ", round(cartProb(),2))
    })
    output$logisticText <- renderText({ 
        paste("Probability of $50K+ according to logistic regression: ",
              round(logisticProb(),2))
    })
    
})
