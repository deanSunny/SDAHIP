load result/orlcc.mat

test_folder = 'test';
test_im = {'4ba987f74f526690f5cbb83622d01e59.jpg', '15a311bc86624f79335994b0987529a9.jpg',...
    'a1b4c5665f0dcbac975fad25f4c977af.jpg', 'b303b5666a27c77ceba0680c52ec90fd.jpg', ...
    'cf843ee8ac32ede38632ba05a7759c3d.jpg'};

for ii = 1 : length(test_im)
    im_path = fullfile(test_folder, test_im{ii});
    [Xtest, im_dim]= get_test_im(im_path);
    test_seg(Xtest, test_im{ii}, 3, n_clusters, t_SDAHIP, 0, im_dim);
end