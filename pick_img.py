#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Wed Feb 15 16:59:38 2017

@author: Sunny
"""
import os
import random

def pick_im_from_data(path):
    file_dir = os.listdir(path)
    category_num = len(file_dir)
    dir_name = path.split('/')[-1]
    dir_names = []
    dir_names.append(dir_name)
    dir_names.append(dir_name+'_C')
    
    dir_save_path = '../data/{}_5'
    
    for cate in file_dir:
        im_list = os.listdir(os.path.join(path, cate))
        random.shuffle(im_list)
        im_list_ran = random.sample(im_list, 5)
        ind = 0
        for dn in dir_names:
            if not os.path.exists(dir_save_path.format(dn)):
                os.mkdir(dir_save_path.format(dn))
            cate_path = os.path.join(dir_save_path.format(dn), cate)
            if not os.path.exists(cate_path):
                os.mkdir(cate_path)
            if dn != dir_name:
                path_ = path + '_C'
            else:
                path_ = path
            for im_name in im_list_ran:
                im_loca_path = os.path.join(path_, cate, im_name)
                im_save_path = os.path.join(cate_path, im_name)
    #            print im_loca_path, im_save_path
                os.system('cp {} {}'.format(im_loca_path, im_save_path))    

if __name__ == '__main__':
    path = '../data/256_ObjectCategories_224'
    pick_im_from_data(path)