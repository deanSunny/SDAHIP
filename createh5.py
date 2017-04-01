#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Mon Mar 20 09:23:01 2017

@author: Sunny
"""
import os
import scipy
import h5py
import numpy as np

def load_mat(mat, save_path, save_name, index_file):
    matrix = scipy.io.loadmat(mat)
    x, n = matrix['ims'].shape
    im = matrix['ims']
    s_file = os.path.join(save_path, save_name)
    
    split_tag = 10000
    split_num = int(round(n *1.0 / split_tag))
    data_tag = 0
    with open(index_file, 'w') as indf:    
        for sn in xrange(split_num):
            s_file_name = s_file + str(sn) + '.h5'
            indf.write(s_file_name + '\n')
    
            with h5py.File(s_file_name, 'w') as f:
                if sn == split_num - 1:
                    f.create_dataset('data', (n - split_tag *(split_num-1),1,1,192),dtype=np.float32)
                    f.create_dataset('label', (n - split_tag *(split_num-1),1), dtype=np.int8)
                else:
                    f.create_dataset('data', (split_tag,1,1,192),dtype=np.float32)
                    f.create_dataset('label', (split_tag,1), dtype=np.int8)
                for i in xrange(split_tag):
                    f['data'][i,...] = im[:, data_tag] 
                    f['label'][i] = 1
                    data_tag += 1
#    return matrix
    print 'Done.'
 
def load_h5(h5):
    with h5py.File(h5, 'r') as f:
        data = f['data']
        print data[0].shape
        label = f['label']
    
if __name__ == '__main__':
    mat_path = '256cate_5_v7.mat'
    ind_file = 'sae_train.txt'
#    h5_name = 'test.h5'
    load_mat(mat_path, 'h5', 'train', ind_file)
#    load_h5(h5_name)
