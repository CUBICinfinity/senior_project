# Visualization of 2d wrapfield
library(plotly)
library(tidyverse)

s = data.frame(s = seq(0, 2*pi, by = pi/24), id = 0)
t = data.frame(t = seq(0, 2*pi, by = pi/24), id = 0)
param = select(full_join(s, t, 'id'), -id)

map = data.frame(x = cos(param$s), y = sin(param$s), z = cos(param$t), w = sin(param$t))


# The Cylinder
plot_ly(map, x = ~x, y = ~y, z = ~z, color = ~w, text = ~paste('w:', w), type = 'scatter3d', mode = 'markers', 
        marker = list(size = ~(w+1)*6)) %>% 
  add_trace(x = ~x, y = ~y, z = ~z, type = 'scatter3d', mode = 'lines',
            line = list(size = ~(w+1)*6,
                        color = '#000000'), 
            marker = NULL)

line_s = seq(-pi/4, pi/4, by = pi/24)
line_t = seq(-pi/4, pi/4, by = pi/24)
line = data.frame(x = cos(line_s), y = sin(line_s), z = cos(line_t), w = sin(line_t))

plot_ly(map, x = ~x, y = ~y, z = ~z, color = ~w, text = ~paste('w:', w), type = 'scatter3d', mode = 'markers', 
        marker = list(size = ~(w+1)*6)) %>% 
  add_lines(x = line$x, y = line$y, z = line$z, mode = 'lines',
            line = list(size = (line$w + 1)*6), 
            marker = NULL)


# The Rotated Cylinder
R1 = rbind(c(1,0,0,0), c(0,1,0,0), c(0,0,cos(pi/4), -sin(pi/4)), c(0,0,sin(pi/4), cos(pi/4)))

R2 = rbind(c(1,0,0,0), c(0,cos(pi/4), -sin(pi/4), 0), c(0,sin(pi/4), cos(pi/4), 0), c(0,0,0,1))

R3 = rbind(c(cos(pi/4), -sin(pi/4), 0, 0), c(sin(pi/4), cos(pi/4), 0, 0), c(0,0,1,0), c(0,0,0,1))

rotation = R3 %*% R2 %*% R1
r_map <- rotation %*% t(map) %>% t() %>% data.frame()
colnames(r_map) <- c('x','y','z','w')
plot_ly(r_map, x = ~x, y = ~y, z = ~z, color = ~w, text = ~paste('w:', w), type = 'scatter3d', mode = 'markers', 
        marker = list(size = ~(w+1)*6))

plot_ly(map, x = ~x, y = ~y, z = ~z, color = ~w, text = ~paste('w:', w), type = 'scatter3d', mode = 'markers', 
        marker = list(size = ~(w+1)*6))
