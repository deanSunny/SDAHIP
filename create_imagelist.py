# -*- coding: utf-8 -*-
"""
Created on Tue Dec 20 12:49:03 2016

@author: dean
"""

import os

def create_image_list(root_path, save_path):
    assert os.path.exists(root_path), '{:s} not existing!'.format(root_path)
    root_list = os.listdir(root_path)
    save_name = 'im_list.txt'
    im_dir = root_path.split('data/')[1]
    im_root = '/media/ghat/Sunny/dean/Dissertation/exp/data'
    im_dir = os.path.join(im_root, im_dir)
    with open(os.path.join(save_path, save_name), 'a') as f:
        for li in root_list:
            im_list = os.listdir(os.path.join(root_path, li))
            label_list = li.split('.')[0]
            for imli in im_list:
                im_name = os.path.join(im_dir, li, imli)
                f.write('{} {}\n'.format(im_name, label_list))

if __name__ == '__main__':
#    root_path = 'D:\\works\\exp\\data\\256_ObjectCategories'
    root_path = '../data/256_ObjectCategories_224_5_patch'
    save_path = os.path.join(os.path.abspath(os.curdir), '../')
    create_image_list(root_path, save_path)