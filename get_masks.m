function [ im_mask ] = get_masks( test_fea, C_st, C_nd)
%TEST_SDAHIP Summary of this function goes here
%   Detailed explanation goes here
%     load C_1.mat;
%     load C_2.mat;
    
    im_mask = cell(2,1);
%     w = dim(1);
%     h = dim(2);
    im_mask1 = zeros(length(test_fea), 1);
    im_mask2 = zeros(length(test_fea), 1);
    for i = 1 : length(test_fea)
          dist1 = pdist2(C_st, test_fea(i, :));
          mask1 = find(dist1 == min(dist1));
          dist2 = pdist2(C_nd{mask1}, test_fea(i, :));
          mask2 = find(dist2 == min(dist2));
          if length(mask2) > 1
              if i > 1
                  if ~isempty(find(mask2 == im_mask2(i-1), 1))
                      im_mask2(i) = im_mask2(i-1);
                  else
                      im_mask2(i) = mask2(1);
                  end
              else
                  im_mask2(i) = mask2(1);
              end
          else
              im_mask2(i) = mask2;
          end
          im_mask1(i) = mask1;
    end
    im_mask{1} = im_mask1;
    im_mask{2} = im_mask2;
end

