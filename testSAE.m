function testSAE
%TESTSAE Summary of this function goes here
%   Detailed explanation goes here
load 256cate_5.mat;
train_data = double(ims');
%%
rand('state',0)
sae = saesetup([192 1000]);
sae.ae{1}.activation_function       = 'sigm';
sae.ae{1}.learningRate              = 1;
sae.ae{1}.inputZeroMaskedFraction   = 0.5;
opts.numepochs =   1;
opts.batchsize = 80;
sae = saetrain(sae, train_data, opts);
% visualize(sae.ae{1}.W{1}(:,2:end)')
save('result/sda_r1.mat', '-struct', 'sae');
end

