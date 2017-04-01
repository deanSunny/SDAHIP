function testKM
%TESTWS Summary of this function goes here
%   Detailed explanation goes here
ti1 = imread('../data/test/256_OC/computer-mouse_3.jpg');
cform = makecform('srgb2lab');
lab_ti1 = applycform(ti1, cform);

ab = double(lab_ti1(:,:,2:3));
nrows = size(ab, 1);
ncols = size(ab, 2);
ab = reshape(ab, nrows*ncols, 2);
nColors = 3;

[cluster_idx, cluster_center] = kmeans(ab, nColors, 'distance', 'sqEuclidean',...
                                        'Replicates', 3);
                                    
pixel_labels = reshape(cluster_idx,nrows,ncols);
imshow(pixel_labels,[]), title('image labeled by cluster index');

segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = ti1;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end
imshow(segmented_images{1}), title('objects in cluster 1');
new_im = segmented_images{1:3};
% imshow(new_im);

mean_cluster_value = mean(cluster_center,2);
[tmp, idx] = sort(mean_cluster_value);
blue_cluster_num = idx(1);

L = lab_ti1(:,:,1);
blue_idx = find(pixel_labels == blue_cluster_num);
L_blue = L(blue_idx);
level = graythresh(L_blue);
is_light_blue = im2bw(L_blue, level);
nuclei_labels = repmat(uint8(0),[nrows ncols]);
nuclei_labels(blue_idx(is_light_blue==false)) = 1;
nuclei_labels = repmat(nuclei_labels,[1 1 3]);
blue_nuclei = ti1;
blue_nuclei(nuclei_labels ~= 1) = 0;
% imshow(blue_nuclei), title('blue nuclei');
end

