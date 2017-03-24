library (plyr)
library (dplyr)
library(reshape2)
source("genBirdDensity.R")

generateThreatenedDensity <- function(ebd_density) {
  
  ebd_density  <- ebd_density[ebd_density$IUCN != "",]
  
  if (nrow(ebd_density) == 0)  { return (NULL) }
  
  # First five columns are metadata and not values. This hard-coding is dangereous and need to be removed
  ebd_density <- cbind (ebd_density["English.India"], ebd_density["IUCN"],ebd_density [6:ncol(ebd_density)])
  
  colnames(ebd_density)[1] <- "Species"
  return (ebd_density)
}

# Test Code 
testHarness_generateThreatenedDensity <- function () {
  unzip('..\\data\\ebird_1489816770850.zip')
  ebd     <- read.csv('MyEbirdData.csv', header = TRUE, sep = ",") 
  species <- read.csv('Species.csv', header = TRUE, sep = ",") 
  
  # Obtain details of birds by joining with species file
  ebd <- join (ebd, species, by = 'Scientific.Name')
  ebd$RANGE <- 'Vazhachal'
  ebd$RANGE [100:500] <- 'Sholayar'
  
  output <- generateBirdDensity(ebd) %>% generateThreatenedDensity()
  write.csv(output, 'testout.csv')
  print (nrow(output))
}

#testHarness_generateThreatenedDensity()
