function [precision, recall] =  Evaluations(seg, gt)
%EVALUATIONS Summary of this function goes here
%   Detailed explanation goes here
SEG = im2bw(seg, 0.1);  
GT = im2bw(gt, 0.1);  
  
dr = Dice_Ratio(SEG, GT)  
hd = Hausdorff_Dist(SEG, GT)  
jaccard = Jaccard_Index(SEG, GT)  
apd = Avg_PerpenDist(SEG, GT)  
confm_index = ConformityCoefficient(SEG, GT)  
precision = Precision(SEG, GT)  
recall = Recall(SEG, GT)  

end
%%
function dr = Dice_Ratio(SEG, GT)  
    % SEG, GT are the binary segmentation and ground truth areas, respectively.  
    % dice ratio  
    dr = 2*double(sum(uint8(SEG(:) & GT(:)))) / double(sum(uint8(SEG(:))) + sum(uint8(GT(:))));  
end  

%%

function hd = Hausdorff_Dist(SEG, GT)  
    % SEG, GT are the binary segmentation and ground truth areas, respectively.  
    % erode element  
    s = cat(3, [0 0 0 ; 0 1 0 ; 0 0 0], [0 1 0 ; 1 1 1 ; 0 1 0], [0 0 0 ; 0 1 0 ; 0 0 0]);  
    % generate boundary  
    Boundary_SEG = logical(SEG) & ~imerode(logical(SEG), s);  
    Boundary_GT = logical(GT) & ~imerode(logical(GT), s);  
    % distance to nearest boundary point  
    Dist_SEG = bwdist(Boundary_SEG, 'euclidean');  
    Dist_GT = bwdist(Boundary_GT, 'euclidean');  
    % distance to another boundary  
    min_S2G = sort(Dist_GT( Boundary_SEG(:) ), 'ascend');  
    min_G2S = sort(Dist_SEG( Boundary_GT(:) ), 'ascend');  
    % hausdorff distance  
    hd = max(min_S2G(end), min_G2S(end));  
end  

%%
function jaccard = Jaccard_Index(SEG, GT)  
    % SEG, GT are the binary segmentation and ground truth areas, respectively.  
    % jaccard index  
    jaccard = double(sum(uint8(SEG(:) & GT(:)))) / double(sum(uint8(SEG(:) | GT(:))));  
end  

%%

function apd = Avg_PerpenDist(SEG, GT)  
    % SEG, GT are the binary segmentation and ground truth areas, respectively.  
    % erode element  
    s = cat(3, [0 0 0 ; 0 1 0 ; 0 0 0], [0 1 0 ; 1 1 1 ; 0 1 0], [0 0 0 ; 0 1 0 ; 0 0 0]);  
    % generate boundary  
    Boundary_SEG = logical(SEG) & ~imerode(logical(SEG), s);  
    Boundary_GT = logical(GT) & ~imerode(logical(GT), s);  
    % distance to nearest boundary point  
    Dist_GT = bwdist(Boundary_GT, 'euclidean');  
    % distance to another boundary  
    min_S2G = Dist_GT( Boundary_SEG(:) );  
    % average perpendicular distance from SEG to GT  
    apd = sum(min_S2G(:)) / length(min_S2G(:));  
end 

%%
function confm_index = ConformityCoefficient(SEG, GT)  
    % SEG, GT are the binary segmentation and ground truth areas, respectively.  
    % dice ratio  
    dr = 2*double(sum(uint8(SEG(:) & GT(:)))) / double(sum(uint8(SEG(:))) + sum(uint8(GT(:))));  
    % conformity coefficient  
    confm_index = (3*dr - 2) / dr;  
end  

%%
function precision = Precision(SEG, GT)  
    % SEG, GT are the binary segmentation and ground truth areas, respectively.  
    % precision  
    precision = double(sum(uint8(SEG(:) & GT(:)))) / double(sum(uint8(SEG(:))));  
end  
%%
function recall = Recall(SEG, GT)  
    % SEG, GT are the binary segmentation and ground truth areas, respectively.  
    % recall  
    recall = double(sum(uint8(SEG(:) & GT(:)))) / double(sum(uint8(GT(:))));  
end  
