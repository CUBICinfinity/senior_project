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


y = np.arange(0, 30*np.pi, np.pi/7)
x = np.sin(y)
noise = np.random.rand(0, np.pi/15)
y = y+noise

y_mod = np.mod(y, 2*np.pi)

x_train, x_test, y_train, y_test = train_test_split(x, y_mod, test_size=0.2)

inputs = Input(shape=(1,))
hidden1 = Dense(8, activation='sigmoid')(inputs)
hidden2 = Dense(4, activation='sigmoid')(hidden1)
outputs = Dense(1, activation='linear')(hidden2)

model = Model(inputs=inputs, outputs=outputs)
model.compile(optimizer='sgd',
              loss='mean_squared_error',
              metrics=['mean_squared_error'])

stopping = EarlyStopping(monitor='val_loss', mode='min', patience = 250)

model.fit(x_train, y_train, 
          validation_data=(x_test, y_test), 
          epochs = 2000, # max
          callbacks = [stopping])

predictions = model.predict(x_test)
print("MSE:", np.mean((predictions - y_test)**2))


# Compare to a very simple model
nearest_neighbor = KNN(n_neighbors=1)
nearest_neighbor.fit(x_train.reshape(-1, 1), y_train)
knn_pred = nearest_neighbor.predict(x_test.reshape(-1, 1))
print("MSE:", np.mean((knn_pred - y_test)**2))



