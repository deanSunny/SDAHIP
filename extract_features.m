% get the embeddings
% load 256cate_5.mat;
im_path = 'test_04.jpg';
XT = ims';

Xtest = get_test_im(im_path);
train_f = extract_feature_from_tnn(XT, nnem, 4);
test_f = extract_feature_from_tnn(Xtest, nnem, 4);