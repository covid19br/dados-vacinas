##############################
## Packages
##############################

if(!require(tidyverse)){install.packages("tidyverse"); library(tidyverse)}

################
### Load data
###############

da_month <- read.csv("doses_cobertura_proporcao_mes_ordem.csv",
                     colClasses = c("month" = "Date",
                                    "agegroup" = "factor",
                                    "dose" = "factor",
                                    "first_dose" = "factor",
                                    "UF" = "factor"))

da_week <- read.csv("doses_cobertura_proporcao_semana_ordem.csv",
                    colClasses = c("month" = "Date",
                                   "agegroup" = "factor",
                                   "dose" = "factor",
                                   "first_dose" = "factor",
                                   "UF" = "factor"))

################
### Plots
###############

### Plot: dados de cobertura vacinal agregados por mês e faixa etária

gage_month <- da_month %>% 
  filter(!dose %in% c("D1","D2","D3","D4","D5")) %>%
  mutate(dose = factor(dose,
                       levels = c("D5cum","D4cum","D3cum","D2cum","D1cum"),
                       ordered = T),
         agegroup = factor(agegroup, levels = 2:11,
                           labels = c("5 a 11",
                                      "12 a 17",
                                      "18 a 29",
                                      "30 a 39",
                                      "40 a 49",
                                      "50 a 59",
                                      "60 a 69",
                                      "70 a 79",
                                      "80 a 89",
                                      "90+"))) %>%
  ggplot(aes(x = month, y = n, fill = dose)) +
  geom_col() +
  facet_wrap(~agegroup, ncol = 4, scale = "free_y") +
  scale_x_date(date_breaks = "3 months", date_labels = "%b-%y") +
  xlab("")  + ylab("") + theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  scale_fill_viridis_d("Dose",
                    labels = c("5ª dose",
                               "4ª dose",
                               "3ª dose",
                               "2ª dose",
                               "1ª dose"))

gage_month

### Plot: dados de cobertura vacinal agregados por semana e faixa etária

  gage_week <- da_week %>% 
  filter(!dose %in% c("D1","D2","D3","D4","D5")) %>%
  mutate(dose = factor(dose,
                       levels = c("D5cum","D4cum","D3cum","D2cum","D1cum"),
                       ordered = T),
         agegroup = factor(agegroup, levels = 2:11,
                           labels = c("5 a 11",
                                      "12 a 17",
                                      "18 a 29",
                                      "30 a 39",
                                      "40 a 49",
                                      "50 a 59",
                                      "60 a 69",
                                      "70 a 79",
                                      "80 a 89",
                                      "90+"))) %>%
  ggplot(aes(x = week, y = n, fill = dose)) +
  geom_col() +
  facet_wrap(~agegroup, ncol = 4, scale = "free_y") +
  scale_x_date(date_breaks = "3 months", date_labels = "%b-%y") +
  theme_set(theme_gray(base_size = 30)) +
  xlab("")  + ylab("") + theme_minimal() +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  scale_fill_viridis_d("Dose",
                       labels = c("5ª dose",
                                  "4ª dose",
                                  "3ª dose",
                                  "2ª dose",
                                  "1ª dose"))


gage_week
  
### Plot: dados de cobertura vacinal agregados por mês e Unidade Federativa
  
guf_month <- da_month %>%
  filter(!dose %in% c("D1","D2","D3","D4","D5")) %>%
  mutate(dose = factor(dose,
                       levels = c("D5cum","D4cum","D3cum","D2cum","D1cum"),
                       ordered = T),
         agegroup = factor(agegroup, levels = 2:11,
                           labels = c("5 a 11",
                                      "12 a 17",
                                      "18 a 29",
                                      "30 a 39",
                                      "40 a 49",
                                      "50 a 59",
                                      "60 a 69",
                                      "70 a 79",
                                      "80 a 89",
                                      "90+"))) %>%
  ggplot(aes(x = month, y = n, fill = dose)) +
  geom_col() +
  facet_wrap(~UF, scale = "free_y") +
  scale_x_date(date_breaks = "3 months", date_labels = "%b-%y") +
  theme_set(theme_gray(base_size = 30)) +
  xlab("")  + ylab("") + theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  scale_fill_viridis_d("Dose",
                       labels = c("5ª dose",
                                  "4ª dose",
                                  "3ª dose",
                                  "2ª dose",
                                  "1ª dose"))

guf_month

### Plot: dados de cobertura vacinal agregados por semana e Unidade Federativa

guf_week <- da_week %>%
  filter(!dose %in% c("D1","D2","D3","D4","D5")) %>%
  mutate(dose = factor(dose,
                       levels = c("D5cum","D4cum","D3cum","D2cum","D1cum"),
                       ordered = T),
         agegroup = factor(agegroup, levels = 2:11,
                           labels = c("5 a 11",
                                      "12 a 17",
                                      "18 a 29",
                                      "30 a 39",
                                      "40 a 49",
                                      "50 a 59",
                                      "60 a 69",
                                      "70 a 79",
                                      "80 a 89",
                                      "90+"))) %>%
  ggplot(aes(x = week, y = n, fill = dose)) +
  geom_col() +
  facet_wrap(~UF, scale = "free_y") +
  scale_x_date(date_breaks = "3 months", date_labels = "%b-%y") +
  theme_set(theme_gray(base_size = 30)) +
  xlab("")  + ylab("") + theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  scale_fill_viridis_d("Dose",
                       labels = c("5ª dose",
                                  "4ª dose",
                                  "3ª dose",
                                  "2ª dose",
                                  "1ª dose"))

guf_week


