library(shiny)

swiss2 <- swiss
swiss2$select <- swiss2$Agriculture
swiss2$Catholic <- ifelse(swiss2$Catholic <50,0,1)

shinyServer(function(input, output) {
    swissD <- reactive({
            if(input$rel == "Catholic"){
                    swiss2[swiss2$Catholic == 1,]
            }
            else if(input$rel == "Protestant") {
                    swiss2[swiss2$Catholic == 0,]
            }
            else {
                    swiss2
                    } 
    })
    model <- reactive({
        swissC <- swissD()
        swissC$select <- swissC[,input$xvar]
        brushed_data <- brushedPoints(swissC, input$brush1,
                                      xvar = input$xvar, yvar = "Fertility")
        if(nrow(brushed_data) < 2){
            return(NULL)
        }
        if(length(unique(brushed_data$select)) < 2){
                return(NULL)
        }
        lm(Fertility ~ select, data = brushed_data)
    })
    output$slopeOut <- renderText({
        if(is.null(model())){
            "No Model Found"
        } else {
            model()[[1]][2]
        }
    })
    output$intOut <- renderText({
        if(is.null(model())){
            "No Model Found"
        } else {
            model()[[1]][1]
        }
    })
    output$plot1 <- renderPlot({
        plot(swiss2[,input$xvar], swiss2$Fertility, xlab = input$xvar,
             ylab = "Fertility", main = paste("Fertility vs. ",input$xvar),
             cex = 1.5, pch = 16, type="n")
        points(swissD()[swissD()$Catholic==1,input$xvar], swissD()[swissD()$Catholic==1,1], xlab = input$xvar,
                 ylab = "Fertility", main = paste("Fertility vs. ",input$xvar),
                 cex = 1.5, pch = 16, col="red")
        points(swissD()[swissD()$Catholic==0,input$xvar], swissD()[swissD()$Catholic==0,1], xlab = input$xvar,
               ylab = "Fertility", main = paste("Fertility vs. ",input$xvar),
               cex = 1.5, pch = 16, col="salmon")
        if(!is.null(model())){
            abline(model(), col = "blue", lwd = 2)
        }
    })
})