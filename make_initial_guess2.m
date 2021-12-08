function Param = make_initial_guess2(data_set)
%{ 
This function makes an inital guess for the EM algorithm to start from
Here we make the initial parameters manually but they can be calculated 
using methods such as k-means.

Input: 

Output: 
    Param: a structure containing the parameters of the two Normal 
        Distributions mu1 (1x2), mu2 (1x2), sigma1 (2x2), sigma2 (1x2), 
        lambda1 (1x1), lambda2 (1x1)
%}

Param = struct();
% Param.mu1 = data_set(1:15, randi(length(data_set)))';
Param.mu1 = [0.1 40 1 0.2 3 0 0 0 0 200 110 70 23 70 70];
% Param.mu2 = data_set(1:15, randi(length(data_set)))';
Param.mu2 = [0.9 60 4 0.8 12 1 1 1 1 260 140 90 30 100 90];
Param.sigma1 = eye(15);
Param.sigma2 = eye(15);
Param.lambda = [0.5, 0.5];
end