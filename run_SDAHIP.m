% load 256cate_5.mat;
% load model/30_4.mat

im_path = 'test_02.jpg';%test im
n_clusters = 15;
%% train part
layers = 3;
% XT = ims';
% train_f = extract_feature_from_tnn(XT, nnem, layers);
% 
% disp(['extract test SDA feature took ', num2str(t_test_f), ' seconds.']);
% % 
% CC = create_HIP(train_f, n_clusters);
%% test part

[Xtest, im_dim]= get_test_im(im_path);
tic;
test_f = extract_feature_from_tnn(Xtest, nnem, layers);
t_test_f = toc;

tic;
im_masks = get_masks(test_f, CC{1}, CC{2});
t_SDAHIP = toc;
disp(['SDAHIP took ', num2str(t_test_f + t_SDAHIP), ' seconds.']);
result = zeros(im_dim(1), im_dim(2));
im_scales = round(linspace(1, 255, n_clusters*n_clusters));
mask_tag = 1;
for i = 1 : 8 : im_dim(1)
   for j = 1 : 8 : im_dim(2)
       result(i:i+7, j:j+7) = im_scales((im_masks{1}(mask_tag)-1)*n_clusters + im_masks{2}(mask_tag));
       mask_tag = mask_tag + 1;
   end
end

result = uint8(result);
imshow(result, []);

