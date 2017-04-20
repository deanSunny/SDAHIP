test_folder = 'test';
im_ = dir(test_folder);
n_clusters = 15;
%%

sda_model = {'test_11.mat', 'test_12.mat', 'test_13.mat', 'layer_4/test_12_t.mat', 'layer_4/test_23.mat', ...
    'layer_4/test_30.mat'};
lay = [4, 4, 4, 5, 5, 5];
lay_ind = 1;
for sda_ = sda_model
% SDA = load('result/192_100_15_all.mat');
% PCA = load('result/PCA.mat');
% ML = load('result/test_11.mat');
disp(sda_{1});
lays = lay(lay_ind);
lay_ind = lay_ind + 1;
SDA = load(['result/', sda_{1}]);
[~, save_dir_name, ~]= fileparts(sda_{1});
if ~exist(['test/result/', save_dir_name, '/0'], 'dir')
    mkdir(['test/result/', save_dir_name, '/0']);
end
%%
im_count = 1;
for i_ = 1 : length(im_)
    if im_(i_).isdir
       continue; 
    end
    im_name = im_(i_).name;
    disp(['im_id : ', num2str(im_count)]);
%     im_test = imread(fullfile(test_folder, im_name));
    [Xtest, im_dim]= get_test_im(fullfile(test_folder, im_name));
    % SDA
    tic;
    test_seg(Xtest, im_name, 0, n_clusters, SDA.t_SDAHIP, lays, im_dim, save_dir_name);
    tsda = toc;
    disp(['SDA ', im_name, ' : ', num2str(tsda)]);
    % PCA
%     tic;
%     test_seg(Xtest, im_name, 1, n_clusters, PCA.t_SDAHIP, 0, im_dim);
%     tpca = toc;
%     disp(['PCA ', im_name, ' : ', num2str(tpca)]);
%     % ML
%     tic;
%     test_seg(Xtest, im_name, 2, n_clusters, ML.t_SDAHIP, 4, im_dim);
%     tml = toc;
%     disp(['ML ', im_name, ' : ', num2str(tml)]);
    %%
    im_count = im_count + 1;
end 
end