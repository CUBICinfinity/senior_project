library(tidyverse)
library(car)
# Compare Euclidean to angular

## Later realized error. Radius wasn't multiplied by 2, but by then I had a simpler visualization to tell the story.
# angular <- function(v1, v2) {
#   radius = 9/(2*pi)
#   v1 <- c(cos(v1[1]/radius), sin(v1[1]/radius), cos(v1[2]/radius), sin(v1[2]/radius))
#   v2 <- c(cos(v2[1]/radius), sin(v2[1]/radius), cos(v2[2]/radius), sin(v2[2]/radius))
#   # print(v1)
#   # print(v2)
#   return(acos((v1 %*% v2)/((2*radius^2)))*radius)
# }
# 
# dist(rbind(c(-2,0), c(0,2)))
# 
# plot(x=c(-2,0), y=c(0,2), xlim = c(-2,2), ylim = c(-2,2), pch = 16, xlab = "", ylab = "", main = "Segment of 2D wraparound with period of 9 (-4.5 to 4.5)")
# lines(x=c(-2,0), y=c(0,2), col = 'blue', lwd = 2)
# text(x=-1.15, y=1.45, labels = 'Euclidean = 2.828', col = 'blue', cex = 0.8)
# text(x=-1.5, y=1.2, labels = 'PseudoAnglular = 2.006', col = 'blue', cex = 0.8)
# points(x=-2, y=-2, pch = 16)
# lines(x=c(-2,-2), y=c(0,-2), col = 'red', lwd = 2)
# text(x=-1.62, y=-0.85, labels = 'Euclidean = 2', col = 'red', cex = 0.8)
# text(x=-1.36, y=-1.15, labels = 'PseudoAnglular = 1.378', col = 'red', cex = 0.8)
# points(x = 2, y = 0, pch = 16)
# lines(x=c(-2,2),y=c(0,0),lwd=2,col='green')
# text(x=-0.8, y=0.2, labels = 'Euclidean = 4', col = 'green', cex = 0.8)
# text(x=0.4, y=0.2, labels = 'PseudoAnglular = 2.208', col = 'green', cex = 0.8)
# points(x = 2, y = 1, pch = 16)
# lines(x=c(0,2),y=c(2,1),lwd=2,col='brown')
# text(x=0.35, y=1.5, labels = 'Euclidean = 2.236', col = 'brown', cex = 0.8)
# text(x=0.7, y=1.2, labels = 'PseudoAnglular = 1.569', col = 'brown', cex = 0.8)
# points(x = 2, y = -1, pch = 16)
# lines(x=c(2,2),y=c(0,-1),lwd=2,col='blue')
# text(x=1.6, y=-0.25, labels = 'Euclidean = 1', col = 'blue', cex = 0.8)
# text(x=1.35, y=-0.5, labels = 'PseudoAnglular = 0.765', col = 'blue', cex = 0.8)
# points(x = 1, y = -2, pch = 16)
# lines(x=c(1,2),y=c(-2,-1),lwd=2,col='red')
# text(x=1.1, y=-1.25, labels = 'Euclidean = 1.414', col = 'red', cex = 0.8)
# text(x=0.75, y=-1.5, labels = 'PseudoAnglular = 1.042', col = 'red', cex = 0.8)
# 
# df <- data.frame(leg1 = c(2,2,4,2,1,1,4.5,3,2.5,4,4,4.5,4,4,3,4.5,2.75,5,6),
#                  leg2 = c(2,0,0,1,0,1,0,3,2.5,4,3,4.5,1,2,1,2.25,0,0,0),
#                  pseudo = c(angular(c(-2,0), c(0,2))[1],
#                             angular(c(-2,0), c(-2,-2))[1],
#                             angular(c(-2,0), c(2,0))[1],
#                             angular(c(0,2),c(2,1))[1],
#                             angular(c(2,0),c(2,-1))[1],
#                             angular(c(1,-2),c(2,-1))[1],
#                             angular(c(0,0),c(0,4.5))[1],
#                             angular(c(0,0),c(3,3))[1],
#                             angular(c(0,0),c(2.5,2.5))[1],
#                             angular(c(0,0),c(4,3))[1],
#                             angular(c(0,0),c(4,4))[1],
#                             angular(c(0,0),c(4.5,4.5))[1],
#                             angular(c(0,0),c(4,1))[1],
#                             angular(c(0,0),c(4,2))[1],
#                             angular(c(0,0),c(3,1))[1],
#                             angular(c(0,0),c(4.5,2.25))[1],
#                             angular(c(0,0),c(2.75,0))[1],
#                             angular(c(0,0),c(5,0))[1],
#                             angular(c(0,0),c(6,0))[1]),
#                  euclid = c(dist(rbind(c(-2,0), c(0,2)))[1],
#                             dist(rbind(c(-2,0), c(-2,-2)))[1],
#                             dist(rbind(c(-2,0), c(2,0)))[1],
#                             dist(rbind(c(0,2),c(2,1)))[1],
#                             dist(rbind(c(2,0),c(2,-1)))[1],
#                             dist(rbind(c(1,-2),c(2,-1)))[1],
#                             dist(rbind(c(0,0),c(0,4.5)))[1],
#                             dist(rbind(c(0,0),c(3,3)))[1],
#                             dist(rbind(c(0,0),c(2.5,2.5)))[1],
#                             dist(rbind(c(0,0),c(4,3)))[1],
#                             dist(rbind(c(0,0),c(4,4)))[1],
#                             dist(rbind(c(0,0),c(4.5,4.5)))[1],
#                             dist(rbind(c(0,0),c(4,1)))[1],
#                             dist(rbind(c(0,0),c(4,2)))[1],
#                             dist(rbind(c(0,0),c(3,1)))[1],
#                             dist(rbind(c(0,0),c(4.5,2.25)))[1],
#                             dist(rbind(c(0,0),c(2.75,0)))[1],
#                             dist(rbind(c(0,0),c(5,0)))[1],
#                             dist(rbind(c(0,0),c(6,0)))[1]))
# 
# plot(leg2~leg1,df)
# 
# summary(m1 <- lm(pseudo ~ 0 + euclid, df))
# plot(pseudo ~ euclid, df, main = 'When period length is 9\ncolor intensity = short_leg / long_leg, (0 to 1)',
#      col = rgb((df$leg2/df$leg1), 0, 0), pch = 16, ylab = 'pseudo angular', xlab = 'Euclidean')
# lines(m1$fitted~df$euclid)
# plot(m1, which = 1)
# plot(m1, which = 2)
# m1$coef[1]
# 
# plot(pseudo/m1$coef[1] ~ euclid, df, main = 'When period length is 9\ncolor intensity = short_leg / long_leg, (0 to 1)',
#      col = rgb((df$leg2/df$leg1), 0, 0), pch = 16, ylab = 'scaled pseudo', xlab = 'Euclidean')
# 
# summary(m2 <- lm(pseudo ~ 0 + euclid + I(euclid^3), filter(df, leg1 == leg2)))
# summary(m3 <- lm(pseudo ~ 0 + euclid + I(euclid^3), filter(df, leg2 == 0)))
# plot(pseudo ~ euclid, df, main = 'When period length is 9\ncolor intensity = short_leg / long_leg, (0 to 1)',
#      col = rgb((df$leg2/df$leg1), 0, 0), pch = 16*(df$leg1<=4.5), ylab = 'pseudo angular', xlab = 'Euclidean')
# curve(x*m2$coef[1]+x^3*m2$coef[2], add = T)
# curve(x*m3$coef[1]+x^3*m3$coef[2], add = T)
# lines(rbind(c(6.363961, 4.1775934), c(4.500000, 2.2500000)), lty = 2)


angular <- function(v1, v2, radius = 1) {
  v1 <- c(cos(v1[1]/radius), sin(v1[1]/radius), cos(v1[2]/radius), sin(v1[2]/radius))
  v2 <- c(cos(v2[1]/radius), sin(v2[1]/radius), cos(v2[2]/radius), sin(v2[2]/radius))
  return((acos((v1 %*% v2)/((2*radius)^2))*radius)[1])
}

x <- data.frame(x = seq(-pi,pi,pi/50), binder = 0)
y <- data.frame(y = seq(-pi,pi,pi/50), binder = 0)
df2 <- select(full_join(x, y, by = 'binder'), -binder)
df2$angular <- 0
for (i in 1:nrow(df2)) {
  df2$angular[i] <- angular(c(0,0), c(df2$x[i], df2$y[i]))
}
df2 <- df2 %>% 
  mutate(euclidean = sqrt(x^2+y^2))

df2 %>% 
  ggplot(aes(x=x, y=y, fill = angular)) +
  geom_raster() +
  scale_fill_continuous(low = '#000000', high = '#ff6600') +
  geom_contour(aes(z=angular),color='white', breaks = seq(0.107, 2.75, 0.107)) + # don't know why breaks behave this way
  scale_x_continuous(breaks = seq(-3,3,1), minor_breaks = NULL) + 
  scale_y_continuous(breaks = seq(-3,3,1), minor_breaks = NULL) +
  labs(x="x radians", y="y radians", fill = "Angular distance\non 4D transformation") +
  theme_minimal() +
  theme(legend.position = 'top')

df2 %>% 
  ggplot(aes(x=x, y=y, fill = euclidean)) +
  geom_raster() +
  scale_fill_continuous(low = '#000000', high = '#0066ff') +
  geom_contour(aes(z = euclidean),color='white', breaks = seq(0.25,4.5,0.25)) +
  scale_x_continuous(breaks = seq(-3,3,1), minor_breaks = NULL) + 
  scale_y_continuous(breaks = seq(-3,3,1), minor_breaks = NULL) +
  labs(x="x radians", y="y radians", fill = "Euclidean distance\non 2D wraparound") +
  theme_minimal() +
  theme(legend.position = 'top')
