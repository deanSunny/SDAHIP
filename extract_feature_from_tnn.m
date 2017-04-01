function [ E ] = extract_feature_from_tnn(X, nnem, nlayer)
%EXTRACT_FEATURE_FROM_TNN Summary of this function goes here
%   Detailed explanation goes here
    [N, m] = size(X);
    datum = [ones(N,1) X];
    for emi = 1:(nlayer-1)
      hid = sigm( datum * nnem.W{emi}');
      datum = [ones(N,1) hid];
    end;
    E = datum(:,2:end);

end

