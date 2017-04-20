load gt/005304.mat

% trans_ind = [1,2,3,4,10,6,7,14,9,8,12,13,11,14,15];

% t_SDAHIP.clustering{1} = t_SDAHIP.clustering{1}(trans_ind, :);
% t_SDAHIP.clustering{2} = t_SDAHIP.clustering{2}(trans_ind);
% gt_g(gt_g > 0.33) = 1;
% imshow(gt_g, []);
result_t = im2double(result);
result_t = resizem(result_t, size(gt_g));
re = [result_t; result_t(1:100, :)];
gt_ret = [gt_g; gt_g(1:100, :)];
prec_rec(result_t(:), gt_g(:), 'plotPR', 0, 'holdFigure', 1);

pca_result = porl/255;
pca_result_R = resizem(pca_result, size(gt_g));

gt_g = im2bw(gt_g, 0.6);
pca_result = im2bw(pca_result, 0.6);

prec_rec(pca_result_R(:), gt_g(:), 'plotPR', 0, 'holdFigure', 1);

% x1 = rand(10000, 1);
% % y1 = round(x1 + 0.5*(rand(1000,1) - 0.5));
% % prec_rec(x1, y1);
% y1 = round(x1 + 0.75 * (rand(10000,1)-0.5));
% x2 = x1 - 0.2;
% x3 = x1 + 0.3;
% 
% x2(x2<0) = 0;
% x3(x3>1) = 1;
% y2 = round(x2 + 0.75 * (rand(10000,1)-0.5));
% y3 = round(x3 + 0.75 * (rand(10000,1)-0.5));
% S
% % prec_rec(x1, y1, 'holdFigure', 1);
% % legend('baseline','x1/y1','x2/y2','Location','SouthEast');
% % prec_rec(x2, y2, 'holdFigure', 1);
% % prec_rec(x3, y3, 'holdFigure', 1);
% x4 = [0:0.05:1];
% y4 = [repmat([0], 1, 2), repmat([1], 1, 19)];
% prec_rec(x4, y4, 'holdFigure', 1);