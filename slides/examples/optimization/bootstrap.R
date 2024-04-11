# Code under MIT License by Michael Mayer and Lukas Widmer.
# See file LICENSE.
# Original code at https://github.com/luwidmer/fastR-website/blob/master/materials/2023-12-06%20BBS%20Next%20Gen/code/fastR-example-code/optimizebootstrap.R. # nolint
# Adapted by Daniel Sabanes Bove, March 2024.

library(tidyverse)
library(data.table)

n_patients <- 1000
bootstrap_n <- 5000
bootstrap_size <- 100

set.seed(1337)
population <- data.table(
    patient_id = 1:n_patients,
    dummy_measurement = runif(n_patients),
    analysis_flag = rbinom(n_patients, 1, 0.8) > 0
)

impl_1 <- function(population) {
    result <- NULL
    for (i in seq_len(bootstrap_n)) {
        bootstrap_data_rows <- sample(
            x = seq_len(nrow(population)),
            size = bootstrap_size,
            replace = TRUE
        )
        current_bootstrap <- population[bootstrap_data_rows, ]
        analysis_pop <- filter(current_bootstrap, analysis_flag == T)
        current_result <- tibble(
            bootstrap_index = i,
            computed_output = median(analysis_pop$dummy_measurement)
        )
        result <- bind_rows(result, current_result)
    }
    return(result)
}
