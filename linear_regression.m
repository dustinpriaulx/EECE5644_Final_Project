%% 
% Logistic Regression

[r, c] = size(data);
training_size = 0.9;
idx = randperm(r);
Dtrain = framinghamclean(idx(1:round(training_size*r)),:);
Dtest = framinghamclean(idx(round(training_size*r)+1:end),:);
Xtrain = Dtrain(:,1:15);
Ytrain = Dtrain(:,16)+1; %MATLAB Notation
Xtest = Dtest(:,1:15);
Ytest = Dtest(:,16)+1;

W = -mnrfit(Xtrain, Ytrain); % w vector

XtrainwC = [ones(length(Xtrain(:,1)),1) Xtrain];
probstrain = sigmoid(W, XtrainwC');

XtestwC = [ones(length(Xtest(:,1)), 1) Xtest];
probstest = sigmoid(W, XtestwC');

%% ROC Curve to determine best threshold
num_points = 20000;
ROC_curve = zeros(20000, 2); % (1 - specificity, sensitivity)
gamma = linspace(0, 1, num_points); % close enough to infinity
decision_matrix = zeros(2,2); % index 1: decision, index 2: actual
for i = 1:num_points

    threshold = gamma(i);
    decision_matrix = zeros(2,2); % index 1: decision, index 2: actual
    for j = 1:length(Ytest)
       if Ytest(j) == 2 && probstest(j) >= threshold
           decision_matrix(2,2) = decision_matrix(2,2) + 1;   
        elseif Ytest(j) == 2 && probstest(j) < threshold
            decision_matrix(1,2) = decision_matrix(1,2) + 1;
        elseif Ytest(j) == 1 && probstest(j) < threshold
                decision_matrix(1,1) = decision_matrix(1,1) + 1;
        elseif Ytest(j) == 1 && probstest(j) >= threshold
                decision_matrix(2,1) = decision_matrix(2,1) + 1;    
       end
    end
    
    sensitivity = decision_matrix(2,2)/(decision_matrix(2,2) + decision_matrix(1,2)); % TP/(TP + FN)   
    specificity = decision_matrix(1,1)/(decision_matrix(1,1) + decision_matrix(2,1)); % TN/(TN + FP)

    if i == maxindex
        confusion_empirical = decision_matrix
        min_e_empirical = (decision_matrix(1,2) + decision_matrix(2,1))/ sum(sum(decision_matrix))
    end 
    
    ROC_curve(i, 1) = 1-specificity;
    ROC_curve(i, 2) = sensitivity;
end
compare = [gamma' ROC_curve];
% ROC Curve
gmean = sqrt(ROC_curve(:,2) .* (1 - ROC_curve(:,1)) );
[maxvalue, maxindex] = max(gmean);

empirical_threshold = gamma(maxindex)

figure(11)
plot(ROC_curve(:,1), ROC_curve(:,2))
hold on
plot([0, 1], [0,1], '--')
plot(ROC_curve(maxindex,1), ROC_curve(maxindex,2), '*', 'color', 'r', 'MarkerSize', 10); %actual
xlabel("1 - Specificity")
ylabel("Sensitivity")
legend("ROC Curve", "No Skill Curve", "Best Threshold = 0.1800")
title('ROC Curve for Logistic Regression Threshold')
hold off



%% 
% Logistic Regression with less features

less_features = [framinghamclean(:,1) framinghamclean(:,2) framinghamclean(:,10) framinghamclean(:,11) framinghamclean(:,15) framinghamclean(:,16)];
[r, c] = size(less_features);
idx = randperm(r);
training_size = 0.9;
Dtrain = less_features(idx(1:round(training_size*r)),:);
Dtest = less_features(idx(round(training_size*r)+1:end),:);
Xtrain = Dtrain(:,1:5);
Ytrain = Dtrain(:,6)+1; %MATLAB Notation class 1 or 2
Xtest = Dtest(:,1:5);
Ytest = Dtest(:,6)+1;

W = mnrfit(Xtrain, Ytrain) % w vector
%%
XtrainwC = [ones(length(Xtrain(:,1)),1) Xtrain];
probstrain = sigmoid(W, XtrainwC');

XtestwC = [ones(length(Xtest(:,1)), 1) Xtest];
probstest = sigmoid(W, XtestwC');

decision_matrix = zeros(2,2);

for i = 1:length(Ytest)
   if Ytest(i) == 2 && probstest(i) >= 0.5
       decision_matrix(2,2) = decision_matrix(2,2) + 1;   
    elseif Ytest(i) == 2 && probstest(i) < 0.5
        decision_matrix(1,2) = decision_matrix(1,2) + 1;
    elseif Ytest(i) == 1 && probstest(i) < 0.5
            decision_matrix(1,1) = decision_matrix(1,1) + 1;
    elseif Ytest(i) == 1 && probstest(i) >= 0.5
            decision_matrix(2,1) = decision_matrix(2,1) + 1;    
   end
end

decision_matrix

ytrainpred = probstrain > 0.5;
ytrainpred = ytrainpred + 1;
accuracy = mean(double(ytrainpred == Ytrain))*100

ytestpred = probstest > 0.5;
ytestpred = ytestpred + 1;
accuracy = mean(double(ytestpred == Ytest))*100

true_rainy = sum(double(Ytest == 2)) % Total Actual Label = 2
predicted_rainy = sum(double(ytestpred==2)) % Total Predicted Label = 2
true_positive = sum(double(Ytest == 2) .* double(ytestpred==2))
precision = true_positive/predicted_rainy
recall = true_positive/true_rainy

F1 = 2*precision*recall/(precision+recall)
%%
[coeff, score, latent, tsquaerd, explained, mu0] = pca(framinghamclean);

%%
sortdata = sortrows(framinghamclean, 16);
index1start = find(sortdata(:, 16), 1);

class0 = sortdata(1:index1start-1, 1:15);
class1 = sortdata(index1start:end, 1:15);

n0 = size(class0, 1);
n1 = size(class1, 1);
N = n0+n1;
mu0 = mean(class0);
mu1 = mean(class1);
mu = ((n0/N)*mu0 + (n1/N)*mu1);

s0 = cov(class0);
s1 = cov(class1);
sw=s0+s1;
invsw=inv(sw);

sb0 = n0 .* (mu0-mu)*(mu0-mu)';
sb1 = n1 .* (mu1-mu)*(mu1-mu)';
sb = sb0 + sb1;

invSw = inv(Sw);
invSw_by_SB = invSw * SB;
[vec, val] = eig(invSw * SB);
%%
val=double(real(val))
%%
W = LDA(X, L, [0.9828 0.0172])