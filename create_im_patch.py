#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Mon Mar 20 22:09:46 2017

@author: Sunny
"""
from PIL import Image
import os
def get_image_patch(im_path, dim, im_save_path):
    im_root, ext = os.path.splitext(im_path)
    im_root_dir = im_root.split('/')[-2]
    im_root_name = im_root.split('/')[-1]
    with Image.open(im_path) as im:
        x, y = im.size
        
        for xi in xrange(0, x, dim[0]):
            for yi in xrange(0, y, dim[1]):
                im_save_name = im_root_name + '_'+ str(xi) + '_' + str(yi) + ext
                bbox = [xi, yi, xi+dim[0], yi+dim[1]]
                crop_im = im.crop(bbox)
                save_dir = os.path.join(im_save_path, im_root_dir)
                if not os.path.exists(save_dir):
                    os.makedirs(save_dir)
                crop_im.save(os.path.join(save_dir, im_save_name))


def get_image_patch_single(im_path, dim, im_save_path):
    im_name, ext = os.path.splitext(im_path)
    with Image.open(im_path) as im:
        x, y = im.size
        for xi in xrange(0, x, dim[0]):
            for yi in xrange(0, y, dim[1]):
                im_save_name = im_name + '_'+ str(xi) + '_' + str(yi) + ext
                bbox = [xi, yi, xi+dim[0], yi+dim[1]]
                crop_im = im.crop(bbox)     
                save_dir = os.path.join(im_save_path, im_name)
                if not os.path.exists(save_dir):
                    os.makedirs(save_dir)
                crop_im.save(os.path.join(save_dir, im_save_name))                          
                

if __name__ == "__main__":
#    im_path = '../data/256_ObjectCategories_224_5/001.ak47/001_0071.jpg'
#    im_dir = '../data/256_ObjectCategories_224_5'
#    dim = [8, 8]
#    im_save_dir = '../data/256_ObjectCategories_224_5_patch'
#    im_dir_list = os.listdir(im_dir)
#    im_tag = 1
#    for im_dl in im_dir_list:
#        im_cls_dir = os.path.join(im_dir, im_dl)
#        im_cls_dir_list = os.listdir(im_cls_dir)
#        for im_cdl in im_cls_dir_list:
#            im_path = os.path.join(im_cls_dir, im_cdl)      
#            get_image_patch(im_path, dim, im_save_dir)
#            print 'Processing... im: {}'.format(im_tag)
#            im_tag += 1
    im_path = '064_0004.jpg'
    dim = [8, 8]
    save_dir = './'
    get_image_patch_single(im_path, dim, save_dir)