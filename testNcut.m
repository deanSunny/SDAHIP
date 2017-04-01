I = imread_ncut('../data/test/256_OC/ak47_1.jpg', 224, 224);
figure(1);clf; imagesc(I);colormap(gray);axis off;
nbSegments = 5;
tic;
[SegLabel,NcutDiscrete,NcutEigenvectors,NcutEigenvalues,W,imageEdges]= NcutImage(I,nbSegments);
% figure(2);clf; imagesc(imageEdges); axis off;
% figure(3);clf
% bw = edge(SegLabel,0.01);
% J1=showmask(I,imdilate(bw,ones(2,2))); imagesc(J1);axis off