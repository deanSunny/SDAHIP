function testWS
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    ti1 = imread('../data/test/256_OC/computer-mouse_3.jpg');
%     ti1 = imread('../data/test/256_OC/ak47_1.jpg');
    I = rgb2gray(ti1);
    hy = fspecial('sobel');
    hx = hy';
    Iy = imfilter(double(I), hy, 'replicate');
    Ix = imfilter(double(I), hx, 'replicate');
    gradmag = sqrt(Ix.^2 + Iy.^2);
    se = strel('disk', 20);
    Io = imopen(I, se);
%     imshow(Io);
    Ie = imerode(I, se);
    Iobr = imreconstruct(Ie, I);
    Ioc = imclose(Io, se);
    Iobrd = imdilate(Iobr, se);
    Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
    Iobrcbr = imcomplement(Iobrcbr);
%     imshow(Iobrcbr)
    fgm = imregionalmax(Iobrcbr);
    I2 = I;
    I2(fgm) = 255;
    se2 = strel(ones(5,5));
    fgm2 = imclose(fgm, se2);
    fgm3 = imerode(fgm2, se2);
    fgm4 = bwareaopen(fgm3, 20);
    I3 = I;
    I3(fgm4) = 255;
%     imshow(I3)
    level = graythresh(Iobrcbr);
    bw = im2bw(Iobrcbr, level);
    figure 
    imshow(bw);
    D = bwdist(bw);
    DL = watershed(D);
    bgm = DL == 0;
    figure
    imshow(bgm)
    gradmag2 = imimposemin(gradmag, bgm | fgm4);
    L = watershed(gradmag2);
%     imshow(L);
    I4 = I;
    I4(imdilate(L == 0, ones(3, 3)) | bgm | fgm4) = 255;
    Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');
    figure
%     imshow(I)
%     hold on
%     himage = imshow(Lrgb);
%     himage.AlphaData = 0.3;
%     title('Lrgb superimposed transparently on original image')
    imshow(Lrgb)
end

