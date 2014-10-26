library(httr)
library(lubridate)

# Set working directory
setwd("~/Documents/R_Programming/ReproducibleResearch/FitBit")

token_url = "https://api.fitbit.com/oauth/request_token"
access_url = "https://api.fitbit.com/oauth/access_token"
auth_url = "https://www.fitbit.com/oauth/authorize"
key = "3c6a42d960bf48de8dd2ed5ded275bd5"
secret = "secret"

fbr = oauth_app('JHUDDP_JPA',key,secret)
fitbit = oauth_endpoint(token_url,auth_url,access_url)
token = oauth1.0_token(fitbit,fbr)
sig = config(token = token)

# get all step data from my first day of use to the current date:
steps = GET("http://api.fitbit.com/1/user/-/activities/steps/date/2012-04-24/today.json",sig)


library(RColorBrewer)
library(rjson)

# convert JSON to a dataframe:
data = NULL
for (i in 1:length(content(steps)$`activities-steps`)) {
    x = c(content(steps)$`activities-steps`[i][[1]]$dateTime,content(steps)$`activities-steps`[i][[1]]$value)
    data = cbind(data,x)
}
data = t(data)
colnames(data) = c("date","steps")
data = as.data.frame(data,row.names=1)
data$date <- as.Date(as.character(data$date)) # setup date field
data$dayName <- weekdays(data$date) # get day of week from date
data$year <- year(data$date) # get year from date

# Add weekend indicator
data$weekend <- FALSE
data$weekend[data$dayName == "Saturday"] <- TRUE
data$weekend[data$dayName == "Sunday"] <- TRUE

# Create a CSV file for data
write.csv(data, "fitbit_data.csv")

# extract step counts and convert to numeric:
steps = as.numeric(as.character(data$steps))

# set up and plot the graph:
brew = brewer.pal(3,"Set1") # red, blue, green
cols = rep(brew[1],length(steps))
cols[steps > 10000] = brew[3]
barplot(steps,ylim=c(0,max(steps)*1.2),col=cols,ylab="Steps",names=gsub("2013-","",data$date),las=2,border=0,cex.axis=0.8)
abline(h=10000,lty=2)
