# dplyR practice

library(dplyr)
library(ggplot2)

df <- meta
df_filtered <- df %>% filter(df$nFeature_RNA > 1000)

df_selected <- df %>% 
  select(nCount_HTO, HTO_maxID, proportion_cnv_chr3, proportion_cnv_chr5, has_dupli_chr5) %>%
  filter(proportion_cnv_chr5 > 0 & proportion_cnv_chr3 >0) %>% 
  arrange(desc(proportion_cnv_chr3), desc(proportion_cnv_chr5)) %>%
  mutate(chr3.log = log(proportion_cnv_chr3)) %>%
  mutate(chr5.log = log(proportion_cnv_chr5)) %>%
  arrange(desc(chr3.log), desc(chr5.log)) 


df_sum <- df_selected %>% group_by(HTO_maxID) %>% summarize(mean_value = mean(proportion_cnv_chr5, na.rm = TRUE)) 

