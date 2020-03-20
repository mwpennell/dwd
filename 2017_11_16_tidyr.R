library(tidyr)
library(tibble) #to see variable type
library(tidyverse) #brings in both tidyr and dplyr

gapminder    <- read.csv('gapminder_mod.csv', stringsAsFactors = FALSE,strip.white = TRUE, na.strings = c("") )

gap_mod      <- gather(gapminder, key = "year", value = "population", pop_1952:pop_2007) #key is the thing you want to flip around; value - thing of value
gap_mod$year <- gsub("pop_","",gap_mod$year) #gsub("thingthatneedstobereplaced","thingthatwillreplace",data)

as.tibble(gap_mod)                           #gives infor on variable type
gap_mod$year <- as.numeric(gap_mod$year)

#-------------------------------
sol         <- read.csv('solanaceae_chromosomes.csv') #doesnt work with normal pull in method
spor_only   <- select(sol, resolved_binomial, sporophytic) #select(data, desired colums,..)
spor_filter <- filter(spor_only,sporophytic >= 24)         #same as subset

spor_by_sp             <- group_by(spor_filter, resolved_binomial)  #keeps the data the same but groups by same name
spor_by_sp$sporophytic <- as.numeric(spor_by_sp$sporophytic)
sp_means               <- summarize(spor_by_sp, spp_avg_counts = round(mean(sporophytic))) #make new column with mean from all groups
res                    <- mutate(sp_means, inferred_gametophyte = spp_avg_counts/2)        #make new column based on mutation of another one

#use pipes gets same result
res2 <- sol %>% select(resolved_binomial, sporophytic) %>% 
                filter(sporophytic >= 24) %>% 
                group_by(resolved_binomial) %>% 
                summarize(spp_avg_counts = round(mean(sporophytic))) %>% 
                mutate(inferred_gametophyte = spp_avg_counts/2)  


#### ------------ CHALLENGES ------------ ####

#contienent medians for lifeexp
#only include data since 1980
library(gapminder)

gap <- gapminder

gap_yfil     <- filter(gapminder, year > 1980)
gap_grp_con  <- group_by(gap_yfil, continent) 
means        <- summarize(gap_grp_con, ct_means = mean(lifeExp))

gap_grp  <- group_by(gap, year) 
max_pop  <- summarize(gap_grp, max_pop = max(pop))