# Create map from GADM data
# Modifikasi dari: https://keithnewman.co.uk/r/maps-in-r-using-gadm.html
# ~ap


library(sp)     
library(raster)

Indo_gadm <-  getData('GADM', country = "IDN", level =1 )

plot(Indo_gadm)

plot(Indo_gadm, col = 'lightgrey', border = 'darkgrey')

plot(Indo_gadm, col = 'forestgreen', border = 'lightgrey')

myColours <- rep("forestgreen", 192)
myColours[71] <- "red"

plot(Indo_gadm, col = myColours, border = 'grey')

regionalValues <- runif(192)  # Simulate a value for each region between 0 and 1
plot(Indo_gadm, col = gray(regionalValues), border = 0)
