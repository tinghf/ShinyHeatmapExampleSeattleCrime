# data from https://data.seattle.gov/Public-Safety/Seattle-Police-Department-Police-Report-Incident/7ais-f98f
seaCrime <- read.csv('data/Seattle_Police_Department_Police_Report_Incident.csv', stringsAsFactors=FALSE)
# slice data to Date/Offence/Lat/Long
seaCrime <- seaCrime[c(8,7,15,16)]
names(seaCrime)[names(seaCrime)=="Date.Reported"] <- "Date"
names(seaCrime)[names(seaCrime)=="Summarized.Offense.Description"] <- "Offence"

# optionall sample instead of taking fullset
seaCrime <- seaCrime[sample(nrow(seaCrime),1000),]
seaCrime$Date <- substring(seaCrime$Date, 1, 10)
seaCrime$Date <- as.Date(seaCrime$Date, "%m/%d/%Y")

x <- unique(seaCrime[c("Offence")])
offence <- as.character(x[order(x),])    # get all offence categories 
