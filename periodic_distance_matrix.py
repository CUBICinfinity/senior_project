# -*- coding: utf-8 -*-
"""
Created on Sat Jan 25 20:26:51 2020

@author: Jim
"""

import numpy as np
from scipy.spatial import distance_matrix
import pandas as pd
import warnings

"""
dat: 
    A pandas dataframe or object that can be converted into pandas dataframe
ranges: 
    A list describing each column using any of these elements:
        Float or integer that indicates the length of the period.
        A list or tuple containing the min and max values of the period.
        None. Indicates that the column is not periodic.
"""

def periodic_distance_matrix(dat, ranges = None):
    if type(dat) != pd.core.frame.DataFrame:
        dat = pd.DataFrame(dat)
        
    if type(ranges) == type(None):
        warnings.warn("No range information supplied. " +
                      "Taking max-min for each column.")
        ranges = []
        for col in dat:
            ranges.append(np.ptp(dat[col]))
    else:
        if type(ranges) != list:
            raise ValueError("Argument 'ranges' needs to be of type list.")
        ranges = [np.ptp(r) if type(r) == list or type(r) == tuple 
                  else r for r in ranges]
        print(ranges)
    distances = np.zeros((dat.shape[0],dat.shape[0])).astype('float64')
    for i in range(dat.shape[1]):
        values = dat.iloc[:,i].values.reshape(len(dat), 1)
        col_dist = distance_matrix(values, values)
        if ranges[i] != None:
            col_dist[col_dist > ranges[i]/2] -= ranges[i]
        distances += col_dist**2
    return np.sqrt(distances)

