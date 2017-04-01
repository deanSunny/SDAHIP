% load 064_0004_norm_16.mat;
% load C_1-16-10.mat;
% load feature/C-2.mat
dd = zeros(length(test_f), 1);
orl = zeros(224, 224);
for i = 1: length(test_f)
    dt = pdist2(double(test_f(i, :)), CC{1});
    dd(i, 1) = find(dt == min(dt));
end

[w, h] = size(orl);
dd_tag = 1;
for wi =1 : 8 : w
    for hi = 1 : 8 : h
        orl(wi:wi+7, hi:hi+7) = dd(dd_tag);
        dd_tag = dd_tag + 1;
    end
end
a = uint8(orl*25);
imshow(a, []);