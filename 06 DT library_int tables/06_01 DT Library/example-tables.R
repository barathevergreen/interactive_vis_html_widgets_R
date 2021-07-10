library("tidyverse") 
library("DT")

transport_data <- read_csv("data/transport_data.csv")

## =========== Basic table
#Single filter
datatable(transport_data)

## =========== Column Filters
#multiple filter
#Range Slider
#Date Range Data
datatable(transport_data, 
          rownames = FALSE,
          filter = list(position = "top"))

## =========== Fixed Columns
## Fixed columns - freezing certain columns 
datatable(
  transport_data,
  extensions = c("FixedColumns"),
  rownames = FALSE,
  options = list(
    dom = 't',
    scrollX = TRUE,
    fixedColumns = list(leftColumns = 2)
  )
)

## =========== Add/remove columns
#Create a button to select/deselect columns
datatable(
  transport_data,
  rownames = FALSE,
  extensions = 'Buttons',
  options = list(dom = 'Bfrtip', buttons = I('colvis'))
)

## =========== Responsive
## https://rstudio.github.io/DT/extensions.html
#Shrinked columns - expand on selection
datatable(transport_data,
          rownames = FALSE,
          extensions = c("Responsive"))
