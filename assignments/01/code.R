# read data
df <- read.csv("data/raw/loansData.csv")

# preprocessing
# remove percents
df$Interest.Rate <- as.numeric(gsub("%$","",df$Interest.Rate))
# remove months
df$Loan.Length.Num <- as.numeric(gsub(" months","",df$Loan.Length))
# FICO: 640-644, 645-649, ... 830-834
# converting to 1, 2, 3, ..., 38
levels(df$FICO.Range) = seq(38)
# convert factor to numerical
df$FICO.Range <- as.numeric(df$FICO.Range)

# using ggplot2
require(ggplot2)

# colorize Loan.Length: correlation is seen: 60 months gets higher percents
qplot(FICO.Range, Interest.Rate, data=df, colour=Loan.Length)
qplot(FICO.Range, Interest.Rate, data=df, colour=Amount.Requested, xlab="FICO score", ylab="Interest rate (%)")
qplot(FICO.Range, Interest.Rate, data=df, colour=Amount.Funded.By.Investors)
qplot(FICO.Range, Interest.Rate, data=df, xlab="FICO score", ylab="Interest rate (%)")

# Fitting linear regression
lm(formula = df$Interest.Rate ~ df$FICO.Range)
summary(lm1)
anova(lm1)

lm(formula = df$Interest.Rate ~ as.factor(df$FICO.Range) + df$Loan.Length.Num)
summary(lm1)
anova(lm1)

lm(formula = df$FICO.Range ~ df$Amount.Requested)
summary(lm1)

lm(formula = df$FICO.Range ~ df$Amount.Funded.By.Investors)
summary(lm1)