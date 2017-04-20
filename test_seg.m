function test_seg(Xtest, im_name, type, n_clusters, stru, layers, im_dim, save_dir)
%UNTITLED Summary of this function goes here
%   type: 0 -> SDAHPI
%         1 -> PCA
%         2 -> ML
%         3 -> orl
    result = zeros(im_dim(1), im_dim(2));
    result_c1 = result;
    im_scales = round(linspace(0, 255, n_clusters*n_clusters));
    im_scales_c1 = round(linspace(0, 255, n_clusters));
    
    if type == 0 || type == 2
        test_f = extract_feature_from_tnn(Xtest, stru.model, layers);
        im_masks = get_masks(test_f, stru.clustering{1}, stru.clustering{2});
       
    elseif type == 1
        [scores_test] = pca(Xtest, 15);  
        im_masks = get_masks(scores_test, stru.clustering{1}, stru.clustering{2});
    elseif type == 3
        im_masks = get_masks(Xtest, stru.clustering{1}, stru.clustering{2}); 
    end
    mask_tag = 1;
        for i = 1 : 8 : im_dim(1)
           for j = 1 : 8 : im_dim(2)
               result(i:i+7, j:j+7) = im_scales((im_masks{1}(mask_tag)-1)*n_clusters + im_masks{2}(mask_tag));
               result_c1(i:i+7, j:j+7) = im_scales_c1((im_masks{1}(mask_tag)));
               mask_tag = mask_tag + 1;
           end
        end
    result = uint8(result);
    result_c1 = uint8(result_c1);
    save_name = fullfile(num2str(type), im_name);
    imwrite(cat(2, result_c1, result), ['test/result/', save_dir, '/', save_name])
end

