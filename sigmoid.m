function y = sigmoid(x,w)
% sigmoid evaluates a simple sigmoid function along x: 
% 
%         ______1________
%     y =        -w^(T)*(x)
%          1 + e^
% 
%% Syntax 
% 
% y = sigmoid(x)
% y = sigmoid(x,w)
% 
%% Description
% 
% y = sigmoid(x) generates a sigmoid function along x. 
% 
% y = sigmoid(x,w) specifies w, the rate of change. If w is close to
% zero, the sigmoid function will be gradual. If w is large, the sigmoid
% function will have a steep or sharp transition. If w is negative, the 
% sigmoid will go from 1 to zero. A default value of w = 1 is assumed if 
% w is not declared. 
% 
%% Example 1 
% A simple sigmoid: 
% 
% x = -10:.01:10;
% plot(x,sigmoid(x))
% 
%% Perform mathematics: 
y = 1./(1 + exp(- w'*x));