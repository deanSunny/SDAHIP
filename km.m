% load features_encode4_16.mat
% delete(gcp);
% parpool local
%  = double(train_f);
n_clusters = 10;
% opt = statset('UseParallel', true);
tic;
[IDX, C, SUMD, D] = kmeans(train_f, n_clusters);%, 'options', opt);
toc;
% save('C_1-16-10.mat', 'C');