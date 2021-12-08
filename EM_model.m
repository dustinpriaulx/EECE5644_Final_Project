%% EM Algoithm K=2
% sortdata = sortrows(dataset', 16);
% index1start = find(sortdata(:, 16), 1);
% 
% class0 = sortdata(1:index1start-1, 1:15);
% class1 = sortdata(index1start:end, 1:15);
true_mean_array = mean(dataset, 2)';
true_mean_array = true_mean_array(1:15);

[r, c] = size(dataset);
EMK = 2;
K=10;
means1 = zeros(15, 10);
means2 = zeros(15, 10);
covs1 = zeros(15, 15, 10);
covs2 = zeros(15, 15, 10);
priors = zeros(EMK, 10);
perror = zeros(1, 10);
Param = make_initial_guess2(dataset);

for k = 1:K
    shift_data = circshift(dataset(1:16, :), round(length(dataset(1,:))*((k-1)/K)), 2); 
    Data = [shift_data(1:15,1:round(0.9*c))' randi(2, round(0.9*c), 1)];

    [Data10K, Param10K] = EM2(Data, Param);
    while isnan(Param10K.mu1(1)) || isnan(Param10K.mu2(1))...
        || isnan(Param10K.sigma1(1,1)) || isnan(Param10K.sigma2(1,1))

        newParam = make_initial_guess2(dataset);
        [Data10K, Param10K] = EM2(Data, newParam);
    end
    means1(:, k) = Param10K.mu1';
    covs1(:,:,k) = Param10K.sigma1;
    means2(:, k) = Param10K.mu2';
    covs2(:,:,k) = Param10K.sigma2;
    priors(:,k) = Param10K.lambda';
    
    mean_array = [Param10K.mu1' Param10K.mu2']';
    cov_array = zeros(15, 15, EMK);
    cov_array(:,:,1) = Param10K.sigma1;
    cov_array(:,:,2) = Param10K.sigma2;
    probability_of_error = poe_finder2(shift_data, EMK, c, true_mean_array, mean_array, cov_array, Param10K.lambda);
    perror(k) = probability_of_error;
end
K2_10K_mean1 = mean(means1, 2);
K2_10K_mean2 = mean(means2, 2);
K2_10K_covs1 = mean(covs1, 3);
K2_10K_covs2 = mean(covs2, 3);
K2_10K_priors = mean(priors, 2);
K2_10K_perror = mean(perror);