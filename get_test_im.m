function [im_patches, new_dim] = get_test_im(im_path)
%GET_TEST_IM Summary of this function goes here
%   Detailed explanation goes here
    im = imread(im_path);
    [ow, oh, oc] = size(im);
%     im = rgb2gray(im);
    w = round(ow / 8) * 8;
    h = round(oh / 8) * 8;
    new_dim = [w h];
    im = imresize(im, new_dim);
    im_patches = [];
    for wi =1 : 8 : w
        for hi = 1 : 8 : h
            patch = im(wi:wi+7, hi:hi+7, :);
            im_patches(end+1, :) = patch(:);
        end
    end

end

