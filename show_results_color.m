function [ color_mask ] = show_results_color(mask, dim, n_clusters)
%SHOW_RESULTS_COLOR Summary of this function goes here
%   Detailed explanation goes here
    color_mask = [];
    mask = double(mask);
    color_mask = rand(dim(1), dim(2), 3);
    r = [0, 0.5, 1];
    g = [0, 0.5, 1];
    b = [0, 0.5, 1];
    base_color = unique(nchoosek([r, g, b], 3), 'rows');
    color_scale = base_color(1:n_clusters, :);
%     color_scale = rand(15,1,3);
    mask_tag = 1;
    for w = 1: 8 : dim(1)
        
        for h = 1: 8 : dim(2)
           color_ind = mask(mask_tag);
           mask_tag = mask_tag + 1;
           inds = [];
           for i = 1 : 8
               for j = 1 : 8
%                     ind_r = sub2ind(size(color_mask), w + i -1, h + j - 1, 1);
%                     ind_g = sub2ind(size(color_mask), w + i -1, h + j - 1, 2);
%                     ind_b = sub2ind(size(color_mask), w + i -1, h + j - 1, 3);
% %                     inds{end + 1} = [ind_r; ind_g; ind_b];
%                     color_mask([ind_r, ind_g, ind_b]) = color_scale(color_ind, :);
                    color_mask(w + i -1, h + j -1, :) = color_scale(color_ind, :);
               end
           end
           
%            for k = inds   
%                 color_mask(k{1}) = color_scale(color_ind,:);
%            end
        end
    end
%     color_mask = uint8(color_mask);
end

