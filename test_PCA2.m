% im_path = 'test_09.jpg';
im_path= '../data/VOCdevkit/VOC2007/JPEGImages/005304.jpg';
n_clusters = 15;
%% train part
% [scores_train_PCA, min_fea_rank] = extract_feature_from_PCA(ims', 0, 0);
[scores_train_PCA] = pca(ims', 15);
CPCA = create_HIP(scores_train_PCA, n_clusters);


%% test part
[patches, im_dim] = get_test_im(im_path);
tic;
% [scores_test] = extract_feature_from_PCA(patches, min_fea_rank, 1);
[scores_test] = pca(patches, 15);
toc;
dpca = zeros(length(scores_test), 1);
for i = 1 : length(scores_test)
   pdt = pdist2(scores_test(i, :), CPCA{1});
   dpca(i) = find(pdt == min(pdt));
end

im_masks_PCA = get_masks(scores_test, CPCA{1}, CPCA{2});


%%

im_scales = round(linspace(1, 255, n_clusters*n_clusters));
porl = zeros(im_dim(1), im_dim(2));
mask_tag = 1;
for wi =1 : 8 : im_dim(1)
    for hi = 1 : 8 : im_dim(2)
        porl(wi:wi+7, hi:hi+7) = im_scales((im_masks_PCA{1}(mask_tag)-1)*n_clusters + im_masks_PCA{2}(mask_tag));
        mask_tag = mask_tag + 1;
    end
end
% a = uint8(porl*25);
imshow(porl/255, []);
% imwrite(uint8(porl), ['seg/PCA/' im_path], 'jpeg');