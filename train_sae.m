load 256cate_5.mat
Xi = ims';
[N,m] = size(Xi); 
% train the autoencoder layer表示自己设定的网络结构，比如[192 2]或其他结构，[192 100 2]...
layer = [192 15];
layers = length(layer);
rand('state',0)
sae = saesetup(layer);

for l = 1:(layers-1) %这是分别设定每一层的激活函数和其他参数
    sae.ae{l}.activation_function       = 'sigm';
    sae.ae{l}.learningRate              = 1;
    sae.ae{l}.inputZeroMaskedFraction   = 0.0;
end;
opts.numepochs =   1;
opts.batchsize = 80;
sae = saetrain(sae, Xi, opts); %这里就进行了pretrain

% fine tune the autoencoder ，刚才的ae是每一层分别训练的，这里重新构造一个新的神经网络，用pretrain的权重来初始化这个网络，用bp优化一下就实现finetune了
% 新的网络的结构保存在tnn里，如果encoder的结构是[192 2]，则tnn的结构是[192 2 192]，如果encoder是[192 100 2]，则tnn结构为[192 100 2 100 192]，依次类推
rlayer = layer(end:-1:1);
tnn = [layer rlayer(1,2:end)];
nnem = nnsetup(tnn);
nnem.activation_function              = 'sigm';
nnem.learningRate                     = 1;
nwi = 1;
for wi = 1:2
    for ai = 1:(layers-1)
        if wi==1
           nnem.W{nwi} = sae.ae{ai}.W{wi};
        end;
        if wi==2
           nnem.W{nwi} = sae.ae{layers-ai}.W{wi};
        end;
       nwi = nwi + 1;
    end;
end;

opts.numepochs =   1;
opts.batchsize = 80;
nnem = nntrain(nnem, Xi, Xi, opts); %优化这个新的神经网络，然后用优化后的权重，可对新的数据降维了

