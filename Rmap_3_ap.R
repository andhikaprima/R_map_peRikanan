# Mapping with Local GADM
# Modifikasi dari: https://github.com/rasyidstat/indonesia
# ~ap

# install.packages("devtools")
install.packages("sf")
devtools::install_github("tidyverse/ggplot2")
devtools::install_github("rasyidstat/indonesia")

library(indonesia)
hai()
#> [1] "Selamat Datang di Indonesia!"

library(sf)
library(indonesia)

# get indonesia map for 'provinsi' level
indonesia_provinsi <- id_map("indonesia", "provinsi")

print(indonesia_provinsi)
plot(indonesia_provinsi)

# get indonesia map for 'kota' level
indonesia_kota <- id_map("indonesia", "kota")

# get jakarta map for 'kelurahan' level
jakarta_kelurahan <- id_map("jakarta", "kelurahan")

head(jakarta_kelurahan)