library(tidyverse)
library(car)

# Make some fake data I "don't" actually know the relationships of.
df <- data.frame(x1 = runif(30, 0, 10), 
                 x2 = runif(30, 0, 24),
                 x3 = rnorm(30, 0, 5))
df <- df %>% 
  mutate(y = sin(x1/4*2*pi) + 
           cos(x1/5*2*pi) + 
           sin(x2/7*2*pi) + 
           cos(x2*3*2*pi) + 
           x3/4 + 
           rnorm(30, 0, 0.4))

View(df)

# Let's pretend I already know x1 and x2 are cyclical.
df <- df %>% 
  mutate(x1a = sin(x1/10*2*pi), x1b = cos(x1/10*2*pi),
         x2a = sin(x2/10*2*pi), x2b = cos(x2/10*2*pi))

pairs(df)
# There are some clear relationships between y and the other variables.

m1 <- lm(y ~ x1a + x1b + x2a + x2b + x3, data = df)
summary(m1)
plot(m1, which=1)
qqPlot(m1)

pairs(cbind(res = m1$res, df[-c(1,2)]))

m1 <- lm(y ~ x1b + I(x1a^2) + x2a + x2b + x3 + I(x2a^3), data = df)
summary(m1)
plot(m1, which=1)
qqPlot(m1)

pairs(cbind(res = m1$res, df[-c(1,2)]))
