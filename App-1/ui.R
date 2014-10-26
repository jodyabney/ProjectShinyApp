###############################################################################
## ui.R for Shiny App: Personal Fitbit Data Explorer                         ##
## Author: Jody P. Abney                                                    ##
## Date: 16-Oct-2014                                                         ##
## Project: Coursera John Hopkins University Data Science Specialization -   ##
##          Developing Data Products Project                                 ##
###############################################################################


# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/


library(shiny)
library(rCharts)

shinyUI(
    # Setup a navigation bar interface with Plot, About, and Insight tabs
    navbarPage("Personal Fitbit Data Explorer",
               tabPanel("Plot",
                        sidebarPanel(
                            sliderInput("range", 
                                        "Year Range:", 
                                        min = 2012, 
                                        max = 2014, 
                                        value = c(2012, 2014),
                                        format="####"),
                            uiOutput('dayNameControls')
                        ), # end of sidebarPanel
                        
                        mainPanel(
                            tabsetPanel(
                                
                                # Plot steps using a simple ggplot linechart with trend line and goal line
                                tabPanel('Overview of Steps',
                                         column(7,
                                                plotOutput("stepsByDate")
                                         ) # end column
                                ), # end tabPanel
                                
                                # Linechart timeseries of Steps
                                tabPanel('Line Chart',
                                         h4("Line Chart: rChart Time Series Line Chart Plot of Steps",
                                            align = "center"),
                                         showOutput("chartStepsByDate", "nvd3")
                                ), # end of tabPanel
                                
                                # Display data and make it available for download
                                tabPanel('Data',
                                         downloadButton('downloadData', 'Download'),
                                         dataTableOutput(outputId="table")
                                ) # end of tabPlanel
                                
                            ) # end Plot mainPanel tabsetPanel
                        ) # end Plot mainPanel
                        
               ), # end of Plot tabPanel
               
               # Provide general instructions and some background information
               tabPanel("About",
                        mainPanel(
                            includeMarkdown("about.md")
                        )
               ), # end of About tabPanel
               
               # Provide some personal insights based on use of the app and my personal Fitbit data
               tabPanel("Insights",
                        mainPanel(
                            includeMarkdown("insights.md")
                        )
               ) # end of Insights tabPanel
               
    ) # end of navbarPage
)

