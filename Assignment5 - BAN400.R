#Problem 2

#Loading packages
library(tidyverse)

#Importing data to memory
raw_data <- readLines('suites_dw_Table1.txt', warn = F)

head(raw_data,15)

#did it first by hardcoding the lines as i misread the assignment
cleaned_data <- read_delim('suites_dw_Table1.txt',
                          col_names = F,
                          delim = '|',
                          skip = 14)
colnames(cleaned_data) <- strsplit(
  readLines('suites_dw_Table1.txt', n=13)[13],"\\|")[[1]]

cleaned_data



# Defining seperator line
seperator_line <- grep("^-+", raw_data) #this function looks through all 
# Lines looking for lines that starts with one or more dashes (-)

# Saving the variable descriptions
var_descriptions <- raw_data[1:(seperator_line-2)]

# Extracting column headers
headers <- raw_data[seperator_line - 1]

# Extracting the actual data
data <- raw_data[(seperator_line + 1):length(raw_data)]

# Merging headers and the rest of the data
clean_data <- c(headers, data)

# Converting the data into a csv format
csv_data <- gsub("\\|", ",", clean_data)

# Saving as a csv-file
writeLines(csv_data, "clean_data.csv")

# Reading in the csv data.
final_data <- read.csv('clean_data.csv', 
                       header = TRUE, 
                       stringsAsFactors = FALSE, #default TRUE, so change to not get factors
                       strip.white = TRUE) #strips white-spaces

head(final_data)


# Problem 3

# Load necessary libraries
library(ggplot2)

# Plot
ggplot(final_data, aes(x=a_26)) + 
  geom_histogram(bins = 30, fill="blue", color = 'black') + 
  theme_minimal() + 
  labs(title="Distribution of Galaxy size (a_26)", 
       x="Diameter (kpc)", 
       y="Number of Galaxies")

#As we can see from the histogram, the smaller values are underepresented compared
#to the larger sized peak. One possible reason for this may be that smaller galaxies
#are harder to discover. This likely means that smaller galaxies will be less represented
#in the data as it is more likely that one in our proximity hasnt been discovered. 

