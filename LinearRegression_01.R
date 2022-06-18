#no import statements needed for this code

#pull in TSLA stock price data as a dataframe and display the first few rows
setwd("D:/")
df <- read.csv("TSLA_stock_prices_ytd.csv")
head(df)

#"Day number" is a numeric representation of the date for easy data manipulation
#(days that the stock market isn't open aren't counted here)

#check the data types of your data
sapply(df, class)

#define x and y for input into the linear regression formula
y <- df$Close
x <- df$Day.number

#fit the model and print a summary of the results
linearmodel <- lm(y ~ x)
summary(linearmodel)

#pull out the constant (b) and coefficient(m) values for easy reference
coef(linearmodel)

#add y_pred back to your initial dataset for easy comparison
y_pred <- predict(linearmodel, as.list(x))
df$Predicted.Close <- y_pred
#head(df) if you want to check to make sure the column added correctly

#plot the results
plot(x, y, type = "l", col = "blue", main="Tesla stock price movement from Jan 3 to June 15, 2022", xlab = "Day number", ylab = "Stock price $/share")
lines(x, df$Predicted.Close, col="orange")
legend(0, 725, legend = c("Actual closing prices", "Predicted closing prices with linear fit"), col = c("blue", "orange"), lty=1:1)

#Although the trend is not linear, there are periods in time that the price movement appears linear. 
#Let's check that out next!

#Let's filter the dataset to a period which appears pretty linear in the graph above and look at the data visually 
#Days ~49-63 look pretty linear in the graph above (which correspond to the March 14 - April 1 timeframe)
df.filtered <- subset(df, df$Day.number >=49 &  df$Day.number <= 63)
y <- df.filtered$Close
x <- df.filtered$Day.number
plot(x, y, type = "l", col = "blue", main="Tesla stock price movement from March 14 to April 1, 2022", xlab = "Day number", ylab = "Stock price $/share")
legend(53, 825, legend = c("Actual closing prices"), col = c("blue"), lty=1)

#let's repeat the same steps we went through before to create a new linear regression over this period
linearmodel <- lm(y ~ x)
summary(linearmodel)

#Isn't that interesting! 
#The R-squared value is now 0.926 which definitely indicates a linear fit! 

#plot the results
y_pred <- predict(linearmodel, as.list(x))
df.filtered$Predicted.Close <- y_pred
plot(x, y, type = "l", col = "blue", main="Tesla stock price movement from March 14 to April 1, 2022", xlab = "Day number", ylab = "Stock price $/share")
lines(x, df.filtered$Predicted.Close, col="orange")
legend(53, 825, legend = c("Actual closing prices", "Predicted closing prices with linear fit"), col = c("blue", "orange"), lty=1:1)

#with most datsets, be careful when only looking at part of the dataset!
#just like in this example where I show that over a period of almost a month there was a very linear trend in this dataset,
#you can find this in other datasets too
#make sure you're trying to use as much data possible (within reason) to make your predictions
#this is a great example which demonstrates short-term patterns in stock prices
#if you catch on to these soon enough, you can profit from these trends, but you need to watch closely and make sure 
#that you can recognize when the trend isn't holding any more. 
