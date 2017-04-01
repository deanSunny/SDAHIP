% load 256cate_5.mat
% tar_ims = ims';
[scores] = extract_feature_from_PCA(zscore(tar_ims));



n_clusters = 15;
% opt = statset('UseParallel', true);
tic;
[IDX, C, SUMD, D] = kmeans(scores, n_clusters);%, 'options', opt);
toc;
