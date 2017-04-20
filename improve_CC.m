close all;

for ni = 1 : n_clusters
    result_icc = zeros(im_dim(1), im_dim(2));
    mask_tag = 1;
    for i = 1 : 8 : im_dim(1)
       for j = 1 : 8 : im_dim(2)
           if im_masks_PCA{1}(mask_tag) == ni
               result_icc(i:i+7, j:j+7) = 1;
           else
               result_icc(i:i+7, j:j+7) = 0;
           end
           mask_tag = mask_tag + 1;
       end
    end 
    figure; imshow(result_icc, []);
end