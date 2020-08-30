%clc; 
close all; 
%clear all; 
% initialization
load('channel_complex_8_50.mat');
%num_users = 20;
for num_users = 20:5:50
X = Rayleigh_Gain(:,1:num_users);
[X, mu, sigma] = featureNormalize(X);
K =2; 
centroids = LBG(X,K);
idx = findClosestCentroids(X',centroids');
fprintf('%d users:', num_users);
fprintf('\n');
for i = 1 : num_users
    fprintf('%d,',idx(i));
end
fprintf('\n');
end
%