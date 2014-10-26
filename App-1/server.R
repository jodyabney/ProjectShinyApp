###############################################################################
## server.R for Shiny App: Personal Fitbit Data Explorer                     ##
## Author: Jody P. Abney                                                    ##
## Date: 16-Oct-2014                                                         ##
## Project: Coursera John Hopkins University Data Science Specialization -   ##
##          Developing Data Products Project                                 ##
###############################################################################

#### Load required libraries ####
library(shiny)
library(ggplot2)
#library(data.table)
library(rCharts)
#library(reshape2)
library(markdown)
#library(GGally)

#### Read the data and format the data frame ####
fbdata <- as.data.frame(read.csv('data/fitbit_data.csv'))
fbdata <- fbdata[!(fbdata$steps==0),] # drop any days with 0 steps
fbdata$date <- as.Date(as.character(fbdata$date))
fbdata <- fbdata[,-1,] # remove rowstamp column

#### Set up the controls for days of the week ####
dayNameTypes <<- c("Sunday", "Monday", "Tuesday", "Wednesday", 
                   "Thursday", "Friday", "Saturday")

#### ShinyServer ####
shinyServer(function(input, output) {
    
    ## Steps by Date
    dataSteps <- reactive({
        tmp <- fbdata[fbdata$year >= input$range[1] & fbdata$year <= input$range[2] &
                          fbdata$dayName %in% input$dayNameTypes,]
        tmp
    })
    
    
    ## Days of the Week UI Control
    output$dayNameControls <- renderUI({
        if(1) {
            checkboxGroupInput('dayNameTypes', 
                               'Days of Week', 
                               dayNameTypes, 
                               selected=dayNameTypes)
        }
    })
    
    ## Data Table    
    output$table <- renderDataTable({dataSteps()}, 
                                    options = list(searching = TRUE, 
                                                   pageLength = 50)
    )
    
    output$downloadData <- downloadHandler(filename = 'data.csv',
                                           content = function(file) {
                                               write.csv(fbdata, file, 
                                                         row.names=FALSE)
        }
    )
    
    ## Plot Steps By Date
    output$stepsByDate <- renderPlot({
        data <- dataSteps()
        
        title <- paste("Steps by Date", input$range[1], "-", input$range[2])
        p <- ggplot(data=data, aes(x=date, y=as.numeric(steps))) + geom_line()
        p <- p + geom_line() + geom_smooth(method = "lm", size=2)
        p <- p + labs(x = "Date", y = "Total Steps", title = title)
        p <- p + geom_hline(yintercept=10000, colour = "red", linetype="dashed")
        print(p)
    })
    
    ## Linechart rCharts Plot of Steps by Date
    output$chartStepsByDate <- renderChart({
        data <- dataSteps()
        
        chartStepsByDate <- nPlot(steps ~ date,
                                  data = data,
                                  dom = 'chartStepsByDate',
                                  type = 'lineChart')
        chartStepsByDate$chart(margin = list(left = 100, right = 100))
        chartStepsByDate$chart(forceY = c(0, 25000)) # force the scale
        chartStepsByDate$yAxis(axisLabel = "Steps")
        chartStepsByDate$xAxis(
            tickFormat = "#!function(d) {return d3.time.format('%b %Y')(new Date( d * 86400000 ));}!#"
        ) # Force the date format as "mmm YYYY" for the x-axis
        return(chartStepsByDate)
    })
    
})

