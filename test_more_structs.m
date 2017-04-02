% load 256cate_5.mat
Xi = ims';
[N,m] = size(Xi); 
test_im = {'test_01.jpg', '003580.jpg'};
base_layer = [256, 200, 150, 128, 100, 64, 32];
one_layer = nchoosek(base_layer, 1);
two_layers = nchoosek(base_layer, 2);

n_clusters = 15;
t_SDAHIP.n_clusters = n_clusters;
t_SDAHIP.test_im = test_im;

layer = [];
% layer = cell(length(one_layer) + length(two_layers), 1);
for la = 1 : length(one_layer)
   layer{end + 1} = [192, one_layer(la), 15]; 
end
for lb = 1 : length(two_layers)
   layer{end + 1} = [192, two_layers(lb, :), 15]; 
end
num_layer = length(layer);

rand('state',0)

for nl = 1 : num_layer

    %% init sae
    sae = saesetup(layer{nl});
    layers = length(layer{nl});
    for l = 1:(layers-1) %这是分别设定每一层的激活函数和其他参数
        sae.ae{l}.activation_function       = 'sigm';
        sae.ae{l}.learningRate              = 1;
        sae.ae{l}.inputZeroMaskedFraction   = 0.0;
    end;
    opts.numepochs =   1;
    opts.batchsize = 80;
    sae = saetrain(sae, Xi, opts);
    %% train tnn
    rlayer = layer{nl}(end:-1:1);
    tnn = [layer{nl} rlayer(1,2:end)];
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
    nnem = nntrain(nnem, Xi, Xi, opts); 
    
    t_SDAHIP.model = nnem;
    %% train part

    train_f = extract_feature_from_tnn(Xi, nnem, length(layer{nl}));
    CC = create_HIP(train_f, n_clusters);
    
    t_SDAHIP.train_f = train_f;
    t_SDAHIP.clustering = CC;
    
    %% test part
    results = [];
    test_fs = [];
    for tn = test_im
        [Xtest, im_dim]= get_test_im(tn{1});
        tic;
        test_f = extract_feature_from_tnn(Xtest, nnem, length(layer{nl}));
        t_test_f = toc;
        disp(['extract test SDA feature took ', num2str(t_test_f), ' seconds.']);
        test_fs{end + 1} = test_f;
        
        tic;
        im_masks = get_masks(test_f, CC{1}, CC{2});
        t_s = toc;
        disp(['SDAHIP took ', num2str(t_test_f + t_s), ' seconds.']);
        result = zeros(im_dim(1), im_dim(2));
        im_scales = round(linspace(1, 255, n_clusters*n_clusters));
        mask_tag = 1;
        for i = 1 : 8 : im_dim(1)
           for j = 1 : 8 : im_dim(2)
               result(i:i+7, j:j+7) = im_scales((im_masks{1}(mask_tag)-1)*n_clusters + im_masks{2}(mask_tag));
               mask_tag = mask_tag + 1;
           end
        end

        result = uint8(result);
        results{end + 1} = result;
    end
    
    t_SDAHIP.test_f = test_fs;
    t_SDAHIP.result = results;
    
    save(['result/test_', num2str(nl), '.mat'], 't_SDAHIP');
end