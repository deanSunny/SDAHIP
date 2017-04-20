for i = 34 : 35
   stru_name = ['result/layer_4/test_', num2str(i)];
   load(stru_name);
   %%
   disp([num2str(i), ' network:']);
   disp(t_SDAHIP.model.size);
   figure;imshow(t_SDAHIP.result{1}, []);
   
   im_dim = [];
   [im_dim(1), im_dim(2), im_dim(3)] = size(imread(t_SDAHIP.test_im{1})); 
   masks = get_masks(t_SDAHIP.test_f{1}, t_SDAHIP.clustering{1}, t_SDAHIP.clustering{2});
   figure;imshow(show_results_color(masks{1}, im_dim, t_SDAHIP.n_clusters), []);
   
   figure;imshow(t_SDAHIP.result{2}, []);
   pause
end