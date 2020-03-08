# -*- coding: utf-8 -*-
"""
Created on Sat Feb 22 21:32:41 2020

@author: Jim
"""

import numpy as np
from keras.layers import Input, Dense
from keras.models import Model
from keras.callbacks import EarlyStopping
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsRegressor as KNN
from matplotlib import pyplot as plt

# Make up data
y = np.arange(0, 30*np.pi, np.pi/7.1)
x = np.column_stack((np.sin(y), np.sin(y + np.pi/4)))
noise = np.random.normal(0, np.pi/30, len(y))
y = y+noise
y = np.mod(y, 2*np.pi)

# What data looks like
fig = plt.figure(figsize=(6,5))
ax = fig.add_subplot(111, xlabel = 'y', ylabel = 'x1 in red, x2 in blue')
ax.scatter(y, x[:,0], color=[1, 0, 0, 0.3])
ax.scatter(y, x[:,1], color=[0, 0, 1, 0.3])

# Train a model
y_transformed = np.column_stack((np.cos(y), np.sin(y)))

x_train, x_test, y_train, y_test = train_test_split(x, 
                                                    y_transformed, 
                                                    test_size=0.2)

inputs = Input(shape=(2,))
hidden1 = Dense(8, activation='elu')(inputs)
hidden2 = Dense(4, activation='elu')(hidden1)
outputs = Dense(2, activation='linear')(hidden2)

model = Model(inputs=inputs, outputs=outputs)
model.compile(optimizer='adam',
              loss='mean_absolute_error',
              metrics=['mean_squared_error'])

model.fit(x_train, y_train, 
          validation_data=(x_test, y_test), 
          epochs = 2000,
          callbacks = [EarlyStopping(monitor='val_loss', 
                                     mode='min', 
                                     patience = 150)])

# Test
y_pred = model.predict(x_test)
print("MLP results:")
print("MAE for cos(y) and sin(y) =", np.mean(np.abs(y_test - y_pred)))
real_y_test = np.mod(np.arctan2(y_test[:,1], y_test[:,0]), 2*np.pi)
real_y_pred = np.mod(np.arctan2(y_pred[:,1], y_pred[:,0]), 2*np.pi)
print("MAE for y =", np.mean(np.abs(real_y_test - real_y_pred)))

# Compare to a very simple model
knn_model = KNN(n_neighbors=2)
knn_model.fit(x_train.reshape(-1, 2), y_train)
knn_pred = knn_model.predict(x_test.reshape(-1, 2))
print("\nKNN results:")
print("MAE for cos(y) and sin(y) =", np.mean(np.abs(y_test - knn_pred)))
real_knn_pred = np.mod(np.arctan2(knn_pred[:,1], knn_pred[:,0]), 2*np.pi)
print("MAE for y =", np.mean(np.abs(real_y_test - real_knn_pred)))
