# -*- coding: utf-8 -*-
"""
Created on Sat Jan 11 23:51:07 2020

@author: Jim
"""

import numpy as np


X = np.array([0, -1, 0.5, 1, 2, 3, 1.5, 2.6, 4, 4.125, 6])

radius = np.pi*2

X-np.roll(X, 1)
X-np.roll(X, 2)
# Fix cycle
X = X % radius

x = np.cos(X)
y = np.sin(X)

# Find the midpoint.
abs(X-np.roll(X, 1)) <
