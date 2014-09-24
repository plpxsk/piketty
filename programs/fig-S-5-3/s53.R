###############################################################################
## WHAT		recreating Piketty Figure S5.3. Financial assets in rich countries
##              Financial assets in rich countries: % of national income
## HOW	  	  
## NOTES	
## AUTHOR	Pawel Paczuski [github.com/pavopax]
###############################################################################

## ============================================================================ 
## DATA STEPS
## ============================================================================ 

source("../header.R")
library(reshape2)

df0 <- read.csv(paste0(datadir, "/ch5ts5-9.csv"), head=TRUE,
                stringsAsFactors=FALSE)


df1 <- tbl_df(df0)
names(df1)[1] <- "Year"

## need to have properly formatted numbers
tt <- apply(df1[,-1], 2, function(x) gsub("%", "", x))
tt2 <- apply(tt, 2, function(x) as.numeric(x))

df <- tbl_df(data.frame(df1$Year,tt2))
names(df)[1] <- "Year"


## for ggplot, to long format
dfl <- melt(df, id.vars="Year", variable.name="Country", value.name="Percent")
dfl <- tbl_df(dfl)


## ============================================================================ 
## OUTPUT
## ============================================================================ 
theme_set(theme_bw())

f1 <- ggplot(dfl, aes(x=Year, y=Percent, colour=Country)) + geom_line(size=1.4)

f2 <- f1 + 
    scale_x_continuous(breaks=seq(1970,2010,10)) +
    scale_y_continuous(limits=c(0,2200), breaks=seq(0,2200,200)) +
    scale_color_brewer(type="qual", palette=6) + 
    ggtitle(expression(atop("Figure S5.4. Financial Liabilities in rich countries",
        atop(italic("Based on T. Piketty (see README)"),"")))) +
    theme(panel.background = element_rect(fill = "gray40"),
          panel.grid.minor.y = element_blank(),
          panel.grid.minor.x = element_blank()
          )

ggsave(paste0(outdir,"/ch5_fs5-4.png"), f2, width=10, height=7)


