library("tidyverse")

bbv_data <- read_csv("data-raw/Suppldata1170228PARV4metadatafile.csv")
colnames(bbv_data) <- tolower(make.names(colnames(bbv_data))) %>%
  gsub('[.]{1,}','.', .) %>%
  gsub('[.]$','', .)

bbv_data[bbv_data == "No data"] <- NA
bbv_data[bbv_data == "Positive"] <- TRUE
bbv_data[bbv_data == "Negative"] <- FALSE
bbv_data[bbv_data == "Pending"] <- NA
bbv_data[bbv_data == "pending"] <- NA

bbv_data <- bbv_data %>%
  mutate(
    hiv.status = recode(
      hiv.status,
      "TRUE" = "HIV positive",
      "FALSE" = "HIV negative",
      .missing = "NA"
    ),
    hbsag.status = recode(
      hbsag.status,
      "TRUE" = "HBsAg positive",
      "FALSE" = "HBsAg negative",
      .missing = "NA"
    ),
    hcv.rna.status = recode(
      hcv.rna.status,
      "TRUE" = "HCV RNA positive",
      "FALSE" = "HCV RNA negative",
      .missing = "NA"
    ),
    parv4.igg.status = recode(
      parv4.igg.status,
      "TRUE" = "PARV4 IgG positive",
      "FALSE" = "PARV4 IgG negative",
      .missing = "NA"
    ),
    parv4.dna.status = recode(
      parv4.dna.status,
      "TRUE" = "PARV4 DNA positive",
      "FALSE" = "PARV4 DNA negative",
      .missing = "NA"
    )
  )


make_truth_table <- function(data, columns) {
  grp_tally <- data %>%
    group_by_(.dots = columns)  %>%
    count() %>%
    ungroup()
  
  measure_columns <- select_if(grp_tally, is.character) %>%
    colnames()
  
  
  lbls <- as.character()
  for (i in 1:nrow(grp_tally)) {
    lbls <-
      append(lbls, paste(unlist(grp_tally[i, measure_columns], use.names = F), collapse = " <br> "))
  }
  
  grp_tally["label"] = lbls
  
  grp_tally
  
}

virus_columns <- c("hiv.status","hbsag.status", 
                   "hcv.rna.status", "parv4.igg.status", "parv4.dna.status")

bbv_truth_table <- bbv_data %>%
  select(one_of(virus_columns)) %>%
  na.omit() %>%
  make_truth_table(virus_columns)

write_csv(bbv_truth_table, "data/bbv_truth_table.csv")


