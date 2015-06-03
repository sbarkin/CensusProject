
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Census 1996: Estimate Probability of Income > $50K"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
        selectInput("workClass", "Working Class", 
                     c("Private", 
                       "Self-emp-not-inc",
                       "Self-emp-inc", "Federal-gov", "Local-gov", "State-gov",
                       "Without-pay", "Never-worked"), selected = "Federal-gov"),
        selectInput("education", "Education",
        c("Bachelors", "Some-college", "11th", "HS-grad", "Prof-school", 
          "Assoc-acdm", "Assoc-voc", 
        "9th", "7th-8th", "12th", "Masters", "1st-4th", "10th",
        "Doctorate", "5th-6th", "Preschool")),
        selectInput("maritalStatus", "Marital Status", 
                    c("Married-civ-spouse", "Divorced", 
        "Never-married", "Separated", "Widowed", "Married-spouse-absent", 
        "Married-AF-spouse")),
        selectInput("occupation", "Occupation",
        c("Tech-support", "Craft-repair", "Other-service", "Sales",
          "Exec-managerial", "Prof-specialty", "Handlers-cleaners", 
          "Machine-op-inspct", "Adm-clerical", "Farming-fishing",
        "Transport-moving", "Priv-house-serv", "Protective-serv", "Armed-Forces")),
        selectInput("relationship", "Relationship",
                     c("Wife", "Own-child", "Husband", "Not-in-family",
                       "Other-relative", "Unmarried")),
        selectInput("race", "Race",
                     c("White", "Asian-Pac-Islander", "Amer-Indian-Eskimo",
                       "Other", "Black")),
        radioButtons("gender", "Gender", c("Male", "Female")),
        sliderInput("capitalGain", "Capital Gain", min=0, max=100000, value = 0),
        sliderInput("capitalLoss", "Capital Loss", min = 0, max = 5000, value = 0),
        sliderInput("hoursPerWeek", "Hours Per Week", min=0, max = 99, value = 40),
        selectInput("nativeCountry", "Native Country",
                    c("United-States", "Cambodia", "England",
                      "Puerto-Rico", "Canada", "Germany",
                      "Outlying-US(Guam-USVI-etc)",
                      "India", "Japan", "Greece", "South", "China", "Cuba",
                      "Iran", "Honduras", "Philippines", "Italy",
                      "Poland", "Jamaica", "Vietnam", "Mexico", "Portugal",
                      "Ireland", "France", "Dominican-Republic",
                      "Laos", "Ecuador", "Taiwan", "Haiti", 
                      "Columbia", "Hungary", "Guatemala", "Nicaragua", 
                      "Scotland", "Thailand","Yugoslavia", "El-Salvador",
                      "Trinadad&Tobago", "Peru", "Hong", "Holand-Netherlands")),
        
      sliderInput("age",
                  "Age",
                  min = 17,
                  max = 90,
                  value = 30)
    ),

    # Show a plot of the generated distribution
    mainPanel(
  #      textOutput("age"),
  #      textOutput("gender"),
  #      textOutput("workClass"),
  #      textOutput("education"),
  #      textOutput("relationship"),
  #      textOutput("occupation"),
  #      textOutput("maritalStatus"),
  #      textOutput("race"),
  #      textOutput("capitalGain"),
  #      textOutput("capitalLoss"),
  #      textOutput("hoursPerWeek"),
  #      textOutput("nativeCountry"),
        p("Instructions"),
        p("This application provides the probability of a given US individual"),
        p("having annual income of $50K+, based on user-selected census characteristics"),
        p("Please make your selections on the left panel, and observe the"),
        p("probabilities below predicted by three predictive methods."),
        p("Note there will likely be a 30-60 second lag before these probabilities appear."),
        textOutput("c50Text"),
        textOutput("cartText"),
        textOutput("logisticText"))
     
    )
)
)
