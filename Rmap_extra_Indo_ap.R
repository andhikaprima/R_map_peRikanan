# Beautiful map of Indonesia
# modifikasi dari: https://www.r-graph-gallery.com/330-bubble-map-with-ggplot2.html
# ~ap

# Libraries
library(ggplot2)
library(dplyr)

# Get the world polygon and extract Indonesia
library(maps)
Indo <- map_data("world") %>% filter(region=="Indonesia")

# Get a data frame with longitude, latitude, and size of bubbles (a bubble = a city)
data <- world.cities %>% filter(country.etc=="Indonesia")

# Left chart
ggplot() +
  geom_polygon(data = Indo, aes(x=long, y = lat, group = group), fill="grey", alpha=0.3) +
  geom_point( data=data, aes(x=long, y=lat)) +
  theme_void() + ylim(-11,7.5) + coord_map() 

# Second graphic with names of the 10 biggest cities
library(ggrepel)
ggplot() +
  geom_polygon(data = Indo, aes(x=long, y = lat, group = group), fill="grey", alpha=0.3) +
  geom_point( data=data, aes(x=long, y=lat, alpha=pop)) +
  geom_text_repel( data=data %>% arrange(pop) %>% tail(10), aes(x=long, y=lat, label=name), size=5) +
  geom_point( data=data %>% arrange(pop) %>% tail(10), aes(x=long, y=lat), color="red", size=3) +
  theme_void() + ylim(-11,7.5) + coord_map() +
  theme(legend.position="none")

# virids package for the color palette
library(viridis)

# Left: use size and color
ggplot() +
  geom_polygon(data = Indo, aes(x=long, y = lat, group = group), fill="grey", alpha=0.3) +
  geom_point( data=data, aes(x=long, y=lat, size=pop, color=pop)) +
  scale_size_continuous(range=c(1,12)) +
  scale_color_viridis(trans="log") +
  theme_void() + ylim(-11,7.5) + coord_map() 

# Center: reorder your dataset first! Big cities appear later = on top
data %>%
  arrange(pop) %>% 
  mutate( name=factor(name, unique(name))) %>% 
  ggplot() +
  geom_polygon(data = Indo, aes(x=long, y = lat, group = group), fill="grey", alpha=0.3) +
  geom_point( aes(x=long, y=lat, size=pop, color=pop), alpha=0.9) +
  scale_size_continuous(range=c(1,12)) +
  scale_color_viridis(trans="log") +
  theme_void() + ylim(-11,7.5) + coord_map() + theme(legend.position="none")

# Right: just use arrange(desc(pop)) instead
data %>%
  arrange(desc(pop)) %>% 
  mutate( name=factor(name, unique(name))) %>% 
  ggplot() +
  geom_polygon(data = Indo, aes(x=long, y = lat, group = group), fill="grey", alpha=0.3) +
  geom_point( aes(x=long, y=lat, size=pop, color=pop), alpha=0.9) +
  scale_size_continuous(range=c(1,12)) +
  scale_color_viridis(trans="log") +
  theme_void() + ylim(-11,7.5) + coord_map() + theme(legend.position="none")

# Create breaks for the color scale
mybreaks <- c(0.02, 0.04, 0.08, 1, 7)

# Reorder data to show biggest cities on top
data <- data %>%
  arrange(pop) %>%
  mutate( name=factor(name, unique(name))) %>%
  mutate(pop=pop/1000000) 

# Build the map
data %>%
  ggplot() +
  geom_polygon(data = Indo, aes(x=long, y = lat, group = group), fill="grey", alpha=0.3) +
  geom_point(  aes(x=long, y=lat, size=pop, color=pop, alpha=pop), shape=20, stroke=FALSE) +
  scale_size_continuous(name="Population (in M)", trans="log", range=c(1,12), breaks=mybreaks) +
  scale_alpha_continuous(name="Population (in M)", trans="log", range=c(0.1, .9), breaks=mybreaks) +
  scale_color_viridis(option="magma", trans="log", breaks=mybreaks, name="Population (in M)" ) +
  theme_void() + ylim(-11,7.5) + coord_map() + 
  guides( colour = guide_legend()) +
  ggtitle("The 1000 biggest cities in the Indo") +
  theme(
    legend.position = c(0.85, 0.8),
    text = element_text(color = "#22211d"),
    plot.background = element_rect(fill = "#f5f5f2", color = NA), 
    panel.background = element_rect(fill = "#f5f5f2", color = NA), 
    legend.background = element_rect(fill = "#f5f5f2", color = NA),
    plot.title = element_text(size= 16, hjust=0.1, color = "#4e4d47", margin = margin(b = -0.1, t = 0.4, l = 2, unit = "cm")),
  )



# Load the plotly package
library(plotly)

# Rorder data + Add a new column with tooltip text
data <- data %>%
  arrange(pop) %>%
  mutate( name=factor(name, unique(name))) %>%
  mutate( mytext=paste(
    "City: ", name, "\n", 
    "Population: ", pop, sep="")
  )

# Make the map (static)
p <- data %>%
  ggplot() +
  geom_polygon(data = Indo, aes(x=long, y = lat, group = group), fill="grey", alpha=0.3) +
  geom_point(aes(x=long, y=lat, size=pop, color=pop, text=mytext, alpha=pop) ) +
  scale_size_continuous(range=c(1,15)) +
  scale_color_viridis(option="inferno", trans="log" ) +
  scale_alpha_continuous(trans="log") +
  theme_void() +
  ylim(-11,7.5) +
  coord_map() +
  theme(legend.position = "none")

p <- ggplotly(p, tooltip="text")
p
