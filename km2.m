% clear;
% load ind_1.mat
% load features.mat
% delete(gcp);
% parpool local
% fea = double(fea);
n_clusters = 10;
% opt = statset('UseParallel', true);
IDXs = cell(n_clusters,1);
Cs = cell(n_clusters,1);
for i=1:n_clusters
    first_clustering_ind = find(IDX == i);
    first_clustering_cls_me = train_f(first_clustering_ind, :);
    tic;
%     disp('cluster : ' + i);
    [IDX_nd, C_nd] = kmeans(first_clustering_cls_me, n_clusters);%, 'options', opt);
    toc;
    IDXs{i} = IDX_nd;
    Cs{i} = C_nd;
end

save('feature/C-2.mat', 'Cs');