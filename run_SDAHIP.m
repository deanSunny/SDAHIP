% load 256cate_5.mat;
% load model/30_4.mat

im_path = 'test_11.jpg';%test im
% im_path= '../data/VOCdevkit/VOC2007/JPEGImages/005304.jpg';
n_clusters = 15;
layers = 3;
%% train part
% XT = ims';
% train_f = extract_feature_from_tnn(XT, nnem, layers);
% % 
% CC = create_HIP(t_SDAHIP.train_f, n_clusters);
%% test part

[Xtest, im_dim]= get_test_im(im_path);
tic;
test_f = extract_feature_from_tnn(Xtest, t_SDAHIP.model, layers);
t_test_f = toc;
disp(['extract test SDA feature took ', num2str(t_test_f), ' seconds.']);

tic;
im_masks = get_masks(test_f, t_SDAHIP.clustering{1}, t_SDAHIP.clustering{2});%, CC{1}, CC{2});
t_SDAHIP_t = toc;
disp(['SDAHIP took ', num2str(t_test_f + t_SDAHIP_t), ' seconds.']);
result = zeros(im_dim(1), im_dim(2));
result_c1 = result;
im_scales = round(linspace(0, 255, n_clusters*n_clusters));
im_scales_c1 = round(linspace(0, 255, n_clusters));
mask_tag = 1;
for i = 1 : 8 : im_dim(1)
   for j = 1 : 8 : im_dim(2)
       result(i:i+7, j:j+7) = im_scales((im_masks{1}(mask_tag)-1)*n_clusters + im_masks{2}(mask_tag));
       result_c1(i:i+7, j:j+7) = im_scales_c1((im_masks{1}(mask_tag)));
       mask_tag = mask_tag + 1;
   end
end

result = uint8(result);

figure;
% subplot(1,2,1);
% imshow(result_c1, []);subplot();
% 
% subplot(1,2,2);
% imshow(result, []);
imshow(cat(2, result_c1, result));
% color_result = show_results_color(im_masks{1}, im_dim, n_clusters);
% figure;imshow(color_result, []);

% rc_mix = imadd(imresize(im2double(imread(im_path)), size(color_result)), 0.5*color_result);
% figure;imshow(rc_mix, []);
