library(shiny)
shinyUI(fluidPage(
        titlePanel("The Swiss Fertility Project"),
        sidebarLayout(
                sidebarPanel(
                        selectInput("xvar","Choose a predictor variable",
                                    c("Agriculture","Education","Examination",
                                      "Infant.Mortality")),
                        radioButtons("rel","Religion",
                                     c("Catholic","Protestant","Both"),"Both"),
                        h3("Slope of the fit"),
                        textOutput("slopeOut"),
                        h3("Intercept"),
                        textOutput("intOut")
                ),
                mainPanel(
                        h1("Select your fitting window"),
                        plotOutput("plot1", brush = brushOpts(
                                id = "brush1"
                        ))
                )
        )
))