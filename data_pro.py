# -*- coding: utf-8 -*-
"""
Created on Thu Dec 22 16:28:58 2016

@author: dean
"""

import os
from PIL import Image

def image_resize_constrain(im_path, resize_dim=224):
    
    im = Image.open(im_path)
    w, h = im.size
    if w >= h:
        rate = w * 1.0 / resize_dim
        nw = resize_dim
        nh = int(h / rate)
        anchor = (0, int((resize_dim - nh)/2))
    else:
        rate = h * 1.0 / resize_dim
        nw = int(w / rate)
        nh = resize_dim
        anchor = (int((resize_dim - nw)/2), 0)
    im = im.resize((nw, nh), Image.ANTIALIAS)
    im_new = Image.new('RGB', (224,224))
    im_new.paste(im, anchor)
#    im_new.save(im_path, 'jpeg')
    return im_new
    
def image_resize(im_path, resize_dim=224):

    im = Image.open(im_path)
#    im_name = im_path.split('\')[-1]
    im = im.resize((resize_dim, resize_dim), Image.ANTIALIAS)
#    im.save(im_path, 'jpeg')
    return im

def image_processing(root_path):
    cls_list = os.listdir(root_path)
#    data_name = root_path.split('\\')[-1]
    data_name_224_C = '{}_224_C'.format(root_path)
    data_name_224 = '{}_224'.format(root_path)
    i = 1
    for cls in cls_list:
        print i, cls
        i += 1
        im_list = os.path.join(root_path, cls)
        im_list_224_C = os.path.join(data_name_224_C, cls)
        im_list_224 = os.path.join(data_name_224, cls)
        if not os.path.exists(im_list_224):
            os.makedirs(im_list_224)
      
        if not os.path.exists(im_list_224_C):
            os.makedirs(im_list_224_C)
            im_list_path = os.listdir(im_list)
            for im_cls in im_list_path:
                im_path = os.path.join(im_list, im_cls)
                im_224_save_path = os.path.join(im_list_224, im_cls)
                im_224_C_save_path = os.path.join(im_list_224_C, im_cls)
                im_224 = image_resize(im_path, 224)
                im_224.save(im_224_save_path, 'jpeg')
                im_224_C = image_resize_constrain(im_path, 224)
                im_224_C.save(im_224_C_save_path, 'jpeg')
            
    

def get_image_folder(path):
    assert os.path.exists(path), 'no such dir.'
    return path
        

if __name__ == '__main__':
#    image_resize('D:\\works\\exp\\data\\test\\n02085620-Chihuahua\\n02085620_7.jpg')
#    image_resize_constrain('D:\\works\\exp\\data\\test\\n02085620-Chihuahua\\n02085620_2517.jpg')
    path = get_image_folder('../data/256_ObjectCategories')
    image_processing(path)