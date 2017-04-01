#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Tue Mar 21 15:14:09 2017

@author: ghat
"""
import os
from sklearn.cluster import KMeans
import numpy as np
import time
import scipy.io as sio

def load_feature(feature):
    assert os.path.exists(feature), '{:s} not existing!'.format(feature)
    f = np.load(feature)
    num_clusters = 100
    t0 = time.time()
    cr = KMeans(n_clusters=num_clusters, init='k-means++')
    s = cr.fit(f)
    print 'used {} s'.format(time.time() - t0)
    km_label = cr.labels_
    km_center = cr.cluster_centers_
    np.save('label_indx.npy', km_label)
    np.save('centers.npy', km_center)
#    return s
    return s

def save_mat(feature):
    assert os.path.exists(feature), '{:s} not existing!'.format(feature)
    f = np.load(feature)
    sio.savemat('feature/064_0004_16.mat', {'test_16': f})
    print 'Done.'
if __name__ == "__main__":
#    f = load_feature('feature/features.npy')
    save_mat('feature/064_0004_16.npy')
#    save_mat('feature/064_0004.npy')
