load 256cate_5.mat
Xi = ims';
[N,m] = size(Xi); 
% train the autoencoder layer��ʾ�Լ��趨������ṹ������[192 2]�������ṹ��[192 100 2]...
layer = [192 15];
layers = length(layer);
rand('state',0)
sae = saesetup(layer);

for l = 1:(layers-1) %���Ƿֱ��趨ÿһ��ļ��������������
    sae.ae{l}.activation_function       = 'sigm';
    sae.ae{l}.learningRate              = 1;
    sae.ae{l}.inputZeroMaskedFraction   = 0.0;
end;
opts.numepochs =   1;
opts.batchsize = 80;
sae = saetrain(sae, Xi, opts); %����ͽ�����pretrain

% fine tune the autoencoder ���ղŵ�ae��ÿһ��ֱ�ѵ���ģ��������¹���һ���µ������磬��pretrain��Ȩ������ʼ��������磬��bp�Ż�һ�¾�ʵ��finetune��
% �µ�����Ľṹ������tnn����encoder�Ľṹ��[192 2]����tnn�Ľṹ��[192 2 192]�����encoder��[192 100 2]����tnn�ṹΪ[192 100 2 100 192]����������
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
nnem = nntrain(nnem, Xi, Xi, opts); %�Ż�����µ������磬Ȼ�����Ż����Ȩ�أ��ɶ��µ����ݽ�ά��

