function [CC] = create_HIP(train_f, n_clusters)
%CREATE_HIP Summary of this function goes here
%   Detailed explanation goes here
    CC = cell(2,1);
    tic;
    [IDX, C, SUMD, D] = kmeans(train_f, n_clusters);
    t_clustering_st = toc;
    disp(['The first clustering took ', num2str(t_clustering_st), ' seconds.']);
    C_cls_d = C;
    CC{1} = C;
    
    IDXs = cell(n_clusters,1);
    Cs = cell(n_clusters,1);
    for i=1:n_clusters
        first_clustering_ind = find(IDX == i);
        first_clustering_cls_me = train_f(first_clustering_ind, :);
        tic;
        [IDX_nd, C_nd] = kmeans(first_clustering_cls_me, n_clusters);%, 'options', opt);
        t_clustering_nd = toc;
        disp(['The second clustering part ', num2str(i), ' took ', num2str(t_clustering_nd), ' seconds']);
        IDXs{i} = IDX_nd;
        Cs{i} = C_nd;
    end
    CC{2} = Cs;
end

