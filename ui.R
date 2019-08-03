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
                        tabsetPanel(type = "tabs", 
                                    tabPanel("Documentation", br(), 
                                             h1("Documentation"),
                                             p("This app lets you play around
                                                with the Swiss Fertility dataset
                                                that is included with R. You can
                                                plot the Fertility rate in various
                                                states, against one of four possible
                                                predictors. You can choose whether you
                                                want to look at all states, or only at
                                                Catholic/Protestant majority states.
                                                Then you can make a linear fit to the
                                                displayed data by selecting a range
                                                of the points. The output slope and
                                                intercept will be displayed in the
                                                side bar. Please use the tabs above
                                                to switch between this documentation
                                                and the output window. Enjoy!"),
                                             br(),p("Written by Patrick Simon, 
                                                    August 3rd 2019")),
                                    tabPanel("Output", br(),
                                             h1("Select your fitting window"),
                                             plotOutput("plot1", 
                                                        brush = brushOpts(
                                                                id = "brush1"
                                                                )
                                                        )
                                    )
                        )
                )
        )
))