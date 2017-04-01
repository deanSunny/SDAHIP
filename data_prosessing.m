function [ ims ] = data_prosessing(im_list)
%DATA_PRESESSING Summary of this function goes here
%   Detailed explanation goes here
%   author: Dean
%     data = importdata('../im_list.txt')
    %[file_path, label] = textread(im_list, '%s%f', 'headerlines', 2);
    fid = fopen(im_list, 'rt');
    tmp_list = textscan(fid, '%s%f');
    file_path = tmp_list{1};
    ims = zeros(192, 784 * length(file_path));
    for i = 1 : length(file_path)
        tic
        im = imread(file_path{1});
        im_blocked = zeros(192, 784);
        block_num = 1;
        for l = 1 : 8 : length(im)
            for c = 1 : 8 : length(im)
                im_tmp = im(c:c+7, l:l+7, :);
                im_tmp = im_tmp(:);
                im_tmp = im2double(im_tmp);
                im_blocked(:, block_num) = im_tmp;
                block_num = block_num + 1;
            end
        end
        ims(:, 1 + (i - 1)*784 : i*784) = im_blocked;
        toc
    end
 
end

