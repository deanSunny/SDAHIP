function [scores, min_fea_rank] = extract_feature_from_PCA(ims, fea_rank, type)
%EXTRACT_FEATURE_FROM_PCA Summary of this function goes here
%   Detailed explanation goes here
    tic;
    [coeff, score, latent, tsquare] = princomp(zscore(ims), 'econ');
    t_PCA = toc;
    disp(['PCA took ', num2str(t_PCA), ' seconds']);
    min_fea_rank = find(cumsum(latent)./sum(latent) > 0.98, 1, 'first');
    if type == 1  %test
        min_fea_rank = fea_rank;
    end
    scores = bsxfun(@minus,ims,mean(ims,1))*coeff(:, 1:min_fea_rank);

end

