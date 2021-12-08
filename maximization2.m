function Param = maximization2(Data, Param)
%{ 
This function calculates the second step of the EM algorithm, Maximization.
It updates the parameters of the Normal distributions according to the new 
labled dataset.

Input: 
    Data : nx16 (number of data points , [x, y, label])
    Param: (mu, sigma, lambda)

Output: 
    Param: updated parameters 
%}

points_in_cluster1 = Data(Data(:,16) == 1,:);
points_in_cluster2 = Data(Data(:,16) == 2,:);

percent_cluster1 = size(points_in_cluster1,1) / size(Data,1);
percent_cluster2 = 1 - percent_cluster1;

% calculate the weights
Param.lambda = [percent_cluster1, percent_cluster2];

% calculate the means
Param.mu1 = [mean(points_in_cluster1(:,1)), mean(points_in_cluster1(:,2)), ...
    mean(points_in_cluster1(:,3)), mean(points_in_cluster1(:,4)), ...
    mean(points_in_cluster1(:,5)), mean(points_in_cluster1(:,6)), ...
    mean(points_in_cluster1(:,7)), mean(points_in_cluster1(:,8)), ...
    mean(points_in_cluster1(:,9)), mean(points_in_cluster1(:,10)), ...
    mean(points_in_cluster1(:,11)), mean(points_in_cluster1(:,12)), ...
    mean(points_in_cluster1(:,13)), mean(points_in_cluster1(:,14)), ...
    mean(points_in_cluster1(:,15))];
Param.mu2 = [mean(points_in_cluster2(:,1)), mean(points_in_cluster2(:,2)), ...
    mean(points_in_cluster2(:,3)), mean(points_in_cluster2(:,4)), ...
    mean(points_in_cluster2(:,5)), mean(points_in_cluster2(:,6)), ...
    mean(points_in_cluster2(:,7)), mean(points_in_cluster2(:,8)), ...
    mean(points_in_cluster2(:,9)), mean(points_in_cluster2(:,10)), ...
    mean(points_in_cluster2(:,11)), mean(points_in_cluster2(:,12)), ...
    mean(points_in_cluster2(:,13)), mean(points_in_cluster2(:,14)), ...
    mean(points_in_cluster2(:,15))];

% calculate the variances
Param.sigma1 = [std(points_in_cluster1(:,1)) 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 
                0 std(points_in_cluster1(:,2)) 0 0 0 0 0 0 0 0 0 0 0 0 0;
                0 0 std(points_in_cluster1(:,3)) 0 0 0 0 0 0 0 0 0 0 0 0;
                0 0 0 std(points_in_cluster1(:,4)) 0 0 0 0 0 0 0 0 0 0 0;
                0 0 0 0 std(points_in_cluster1(:,5)) 0 0 0 0 0 0 0 0 0 0;
                0 0 0 0 0 std(points_in_cluster1(:,6)) 0 0 0 0 0 0 0 0 0;
                0 0 0 0 0 0 std(points_in_cluster1(:,7)) 0 0 0 0 0 0 0 0;
                0 0 0 0 0 0 0 std(points_in_cluster1(:,8)) 0 0 0 0 0 0 0;
                0 0 0 0 0 0 0 0 std(points_in_cluster1(:,9)) 0 0 0 0 0 0;
                0 0 0 0 0 0 0 0 0 std(points_in_cluster1(:,10)) 0 0 0 0 0;
                0 0 0 0 0 0 0 0 0 0 std(points_in_cluster1(:,11)) 0 0 0 0;
                0 0 0 0 0 0 0 0 0 0 0 std(points_in_cluster1(:,12)) 0 0 0;
                0 0 0 0 0 0 0 0 0 0 0 0 std(points_in_cluster1(:,13)) 0 0;
                0 0 0 0 0 0 0 0 0 0 0 0 0 std(points_in_cluster1(:,14)) 0;
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 std(points_in_cluster1(:,15))
                ];
Param.sigma2 = [std(points_in_cluster2(:,1)) 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
                0 std(points_in_cluster2(:,2)) 0 0 0 0 0 0 0 0 0 0 0 0 0;
                0 0 std(points_in_cluster2(:,3)) 0 0 0 0 0 0 0 0 0 0 0 0;
                0 0 0 std(points_in_cluster2(:,4)) 0 0 0 0 0 0 0 0 0 0 0;
                0 0 0 0 std(points_in_cluster2(:,5)) 0 0 0 0 0 0 0 0 0 0;
                0 0 0 0 0 std(points_in_cluster2(:,6)) 0 0 0 0 0 0 0 0 0;
                0 0 0 0 0 0 std(points_in_cluster2(:,7)) 0 0 0 0 0 0 0 0;
                0 0 0 0 0 0 0 std(points_in_cluster2(:,8)) 0 0 0 0 0 0 0;
                0 0 0 0 0 0 0 0 std(points_in_cluster2(:,9)) 0 0 0 0 0 0;
                0 0 0 0 0 0 0 0 0 std(points_in_cluster2(:,10)) 0 0 0 0 0;
                0 0 0 0 0 0 0 0 0 0 std(points_in_cluster2(:,11)) 0 0 0 0;
                0 0 0 0 0 0 0 0 0 0 0 std(points_in_cluster2(:,12)) 0 0 0;
                0 0 0 0 0 0 0 0 0 0 0 0 std(points_in_cluster2(:,13)) 0 0;
                0 0 0 0 0 0 0 0 0 0 0 0 0 std(points_in_cluster2(:,14)) 0;
                0 0 0 0 0 0 0 0 0 0 0 0 0 0 std(points_in_cluster2(:,15))
                ];

end