load('256cate_5.mat')
tic
[ind, c] = kmeans(ims, 100);
toc