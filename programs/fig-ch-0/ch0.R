###############################################################################
## WHAT		recreating Piketty ch. 0 fig 1 
## HOW	  	  
## NOTES	
## AUTHOR	Pawel Paczuski [github.com/pavopax]
###############################################################################

## ============================================================================ 
## DATA STEPS
## ============================================================================ 

source("../header.R")
library(gridExtra)


df0 <- read.csv(paste0(datadir, "/ch0ts1-1.csv"), head=FALSE)

df <- tbl_df(df0)
names(df) <- c("year", "share")
df$share <- as.numeric(gsub("%", "", df$share))



## ============================================================================
## OUTPUT
## ============================================================================


f1 <- ggplot(data=df, aes(year, share)) + geom_point() + geom_line() +
    labs(x="", y="Share of top decile in national income") +
    scale_x_continuous(breaks=seq(1910, 2010, 10)) +
    ggtitle("Figure I.1. Income Inequality in the United States, 1910-2010")

subt=textGrob("The top decile share in U.S. national income dropped from 45-50% in the 1910s-1920s to less than 35% in the 1950s (this is the fall documented by Kuznets);\nit then rose from less than 35% in the 1970s to 45-50% in the 2000s-2010s. Sources and series: see piketty.pse.ens.fr/capital21c.", x=-0.1, hjust=-0.2, vjust=-0.5,
    gp = gpar(fontface = "italic", fontsize=8))

f2 <- arrangeGrob(f1, sub=subt)

ggsave(paste0(outdir,"/ch0f1.png"), f2, width=10, height=7)


 

