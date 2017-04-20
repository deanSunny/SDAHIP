gt_name = {'005304', '005368', '007154', '007649', '009327', '009654'};
for gt_ = gt_name
   gt = imread(['../data/VOCdevkit/VOC2007/SegmentationObject/', gt_{1}, '.png']);
%    gt_gray = rgb2gray(gt);
    gt_g = im2double(gt);
   
    gt_cls = unique(gt_g);
    [w, h] = size(gt_g);
    gt_scale = linspace(0, 1, length(gt_cls));

    gt_g(gt_g==gt_cls(end)) = 0;
    for gi = 1 : length(gt_cls) - 1
       gt_g (gt_g==gt_cls(gi)) = gt_scale(gi);
    end
    figure;imshow(gt_g);
    save(['gt/', gt_{1}, '.mat'], 'gt_g', 'gt_scale', 'gt_cls');
end


% [mltrain, mlmapping] = compute_mapping(ims', 'ManifoldChart', 15);



% for wi_ = 1 : w
%    for hi_ = 1 : h
%        
%    end
% end
% gt(gt == 255) = 0;
