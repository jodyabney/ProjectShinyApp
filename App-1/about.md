### Welcome to my Personal Fitbit Data Explorer

This application is based on my personal Fitbit data collected between April 2012 and October 2014.

Source code is available on the [GitHub](http://github.com/jodyabney/ProjectShinyApp).

#### General Instructions
The `Year` range and `Day of Week` selections can be adjusted using control panel located in the left-side panel of the Shiny app. These are reactive controls which change the `Plot` results displayed in the right-side panel:

* `Overview of Steps` displays a simple line chart with a simply linear trend line for the number of steps per day
* `Line Chart` displays a line chart allowing a user to see the cooresponding number of steps for a given date by simply mousing-over the line chart itself
* `Data` displays the Fitbit dataset based on the reactive control selections and includes the ability to search and download the dataset

#### Background

Owning a [Fitbit](http://www.fitbit.com/store) device has changed my life and it just might change your life too. The ability to log my daily activity changed the way I look at getting walking steps completed. I strive for 10,000 steps per day and my steps are logged automatically by the Fitbit device to my Fitbit Dashboard. I can there review by activity by day and for the last week. They offer a pay service which provides more trending options, but I decided to use their API (application programming interface) and the R programming language with R Studio to build a Shiny data product on the web allowing me to review my step activity data/trend.

#### Obtaining the Source Data

Dataset has been obtained via the API (Application Programming Interface) from the [Fitbit Developer Site](http://http://dev.fitbit.com) and processed as follows:

* Authenticate my user account and app access via the Fitbit API
* Retrieve the activities for "steps" (total steps for a given date) from my Fitbit account
* Clean up the `date` and `steps` to be "date" and "numeric" types, respectively
* Add `dayName` column for Day of the Week calculated based on `date`
* The resulting data is then stored in `fitbit_data.csv` used as source data for the Shiny application



