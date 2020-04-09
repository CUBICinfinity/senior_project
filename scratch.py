# -*- coding: utf-8 -*-
"""
Created on Thu Apr  9 13:20:51 2020

@author: Jim
"""

import numpy as np 
from matplotlib import pyplot as plt

# Make up data
y = np.arange(0, 60*np.pi, np.pi/7.11)
x = np.column_stack((np.sin(y), np.sin(y + np.pi/4)))
noise = np.random.normal(0, np.pi/30, len(y))
y = y+noise
y = np.mod(y, 2*np.pi)

# What data looks like
fig = plt.figure(figsize=(12,10))
ax = fig.add_subplot(111, xlabel = 'y', ylabel = 'x1 in red, x2 in blue')
ax.scatter(y, x[:,0], color=[1, 0, 0, 0.3])
ax.scatter(y, x[:,1], color=[0, 0, 1, 0.3])