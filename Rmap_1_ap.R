# How to Create Indonesia Map in R
# Modifikasi dari: https://www.linkedin.com/pulse/how-create-indonesia-map-r-bhara-yudhiantara/
# ~ap

setwd("~/Documents/LearnR/rmap/Rmap_pusriskan")

require(maps)  #loading maps package
require(mapdata) #loading mapdata package
library(ggplot2) #ggplot2 package
library(readxl) #package for read .xlsx file
library(ggthemes) #package for ggplot2 theme
library(ggrepel) #extendig the plotting package ggplot2 for maps
library(geosphere)

# setwd("your file's path") #set your own directory
# mydata<- read_xlsx("dummy.xlsx") #assign the data to "mydata"
# 
# View(mydata) #view the data, notice the column of "latitude","longitude", "woe_label"

myfma <- read_excel("Rmap_1_Indonesia_FMA.xlsx")
mydata <- read_excel("Rmap_1_Indonesia_provinces.xlsx")
View(mydata)
View(myfma)

# Step 1
global <- map_data("world") #World longitude and latitude data 

View(global) #view the data and notice the column of long, lat, and group

gg1 <- ggplot() + 
  geom_polygon(data = global, aes(x=long, y = lat, group = group), 
               fill = "gray85", color = "gray80") + 
  coord_fixed(1.3) 
#you can change the "fill" (fill color) and the "color" (line color)

print(gg1) #show the plot

# Step 2
Indo<-gg1 + xlim(94,142) + ylim(-11,7.5)

#try to change the values of xlim and ylim and see what you get

print(Indo)    

# Step 3
Indo<-gg1 + xlim(94,142) + ylim(-11,7.5) + theme_map()

#I am using command theme_map() to change the plot theme. You can check the other themes by reading more about ggtheme package 

print(Indo) 
#now, you can see the difference

# Step 4
Indo<-gg1 + xlim(94,142) + ylim(-11,7.5) + geom_point(data = mydata,aes(x = longitude, y = latitude), color = "purple", size=2, alpha = 0.5, show.legend = F) + theme_map()

#geom_point will add a layer that will show the point based on latitude and longitude of each province. Pay attention to the value inside aes(). 
#You can change the color, size, and alpha of the point. Alpha is the transparancy of the points.

print(Indo) 
#now, you can see the difference

# Step 5
Indo<-gg1 + xlim(94,142) + ylim(-11,7.5) +
  geom_point(data = mydata, aes(x = longitude, y = latitude), 
             color = "purple", size=2, alpha = 0.5, show.legend = F) +
  geom_text_repel(data = mydata, aes(x = longitude, y = latitude, 
                                     label= woe_label), color = "grey30",show.legend=F, size=2.5) + 
  ggtitle ("Map of Indonesia") + theme_map()

print(Indo)

#pay attention for values in aes() in geom_text_repel(). We add label = woe_label which means the information of "label" will be taken from the column of woe_label.
#you can change the color and the size of the label.
#adding the title using ggtitle.


# Data Visualisation
Indo<-gg1 + xlim(94,142) + ylim(-11,7.5) +
  geom_point(data = mydata,aes(x = longitude, y = latitude, size = population), 
             color = "purple", alpha = 0.5, show.legend = F)

print(Indo)

#notice now the function of "size = " is inside aes()
#You can change the value of size, for example size = population
#in this case, your data should have a column containing total of population for each province
#the size of each point will be different and depend on the size of population


# FMA
# Step 6
Indo<-gg1 + xlim(94,142) + ylim(-11,7.5) + geom_point(data = myfma, aes(x = LON, y = LAT), color = "purple", size=2, alpha = 0.5, show.legend = F) + theme_map()

#geom_point will add a layer that will show the point based on latitude and longitude of each province. Pay attention to the value inside aes(). 
#You can change the color, size, and alpha of the point. Alpha is the transparancy of the points.

print(Indo) 
#now, you can see the difference

# Step 7
Indo<-gg1 + xlim(94,142) + ylim(-11,7.5) +
  geom_point(data = myfma, aes(x = LON, y = LAT), 
             color = "purple", size=2, alpha = 0.5, show.legend = F) +
  geom_text_repel(data = myfma, aes(x = LON, y = LAT, 
                                    label= FMA_NAME), color = "grey30",show.legend=F, size=2.5) + 
  ggtitle ("Map of Indonesia Fisheries Management Area") + theme_map()

print(Indo)


# Data Visualisation
Indo<-gg1 + xlim(94,142) + ylim(-11,7.5) +
  geom_point(data = myfma,aes(x = LON, y = LAT, size = POPULATION), 
             color = "purple", alpha = 0.5, show.legend = F) +
  geom_text_repel(data = myfma, aes(x = LON, y = LAT, 
                                    label= FMA_NAME), color = "grey30",show.legend=F, size=2.5) + 
  theme_map()

print(Indo)