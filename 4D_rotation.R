R1 = rbind(c(1,0,0,0), c(0,1,0,0), c(0,0,cos(pi/4), -sin(pi/4)), c(0,0,sin(pi/4), cos(pi/4)))

R2 = rbind(c(1,0,0,0), c(0,cos(pi/4), -sin(pi/4), 0), c(0,sin(pi/4), cos(pi/4), 0), c(0,0,0,1))

R3 = rbind(c(cos(pi/4), -sin(pi/4), 0, 0), c(sin(pi/4), cos(pi/4), 0, 0), c(0,0,1,0), c(0,0,0,1))

rotation = R3 %*% R2 %*% R1

rotation %*% t(data)

