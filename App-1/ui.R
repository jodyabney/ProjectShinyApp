
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/


library(shiny)
library(rCharts)

shinyUI(
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
                                
                                # Plot steps
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
                                
                                # Display data
                                tabPanel('Data',
                                         downloadButton('downloadData', 'Download'),
                                         dataTableOutput(outputId="table")
                                ) # end of tabPlanel
                                
                            ) # end Plot mainPanel tabsetPanel
                        ) # end Plot mainPanel
                        
               ), # end of Plot tabPanel
               
               tabPanel("About",
                        mainPanel(
                            includeMarkdown("about.md")
                        )
               ), # end of About tabPanel
               
               tabPanel("Insights",
                        mainPanel(
                            includeMarkdown("insights.md")
                        )
               ) # end of Insights tabPanel
               
    ) # end of navbarPage
)

