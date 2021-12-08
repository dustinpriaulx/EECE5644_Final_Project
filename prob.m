function p = prob(point, mu, sigma, lambda)
%{
%% calculate probability / likelihood
% Probability that given a set of parameters \theta for the PDFs the data X can be
% observed.; this is equivalent of the likelihood of the parameters \theta
% given data points X
%
% point = [x y]
% mu = 1x15
% sigma = 15x15
% lambda = 1x2
% sigma has to be square (actually semi definite positive)
% TODO: check sigma for that and fix it if it is not.
%}
p = log(lambda);
for ii = 1:length(point)
    if sigma(ii,ii) == 0
        sigma(ii,ii) = 0.00001;
    end
    p = p + log(normpdf(point(1,ii), mu(1,ii), sigma(ii,ii)));
end
end