clc; 
close all; 
clear all; 
% initialization
load('channel_ray_8_50.mat');
%num_users = 50;
for num_users = 20:5:50
X = Rayleigh_Gain(:,1:num_users)';
% for m=1:num_users%normalization
%     X(m,:)=X(m,:)./norm(X(m,:));
% end
%normalization
[X, mu, sigma] = featureNormalize(X);
run_times = 2000; % every run time use different-randomly generated initial centroids
K =16; % K is the number of centroids
max_iters = 128; % iteration time
cost = zeros(run_times,1);
idx = zeros(run_times, num_users);
for i = 1 : run_times
initial_centroids = [X(randi(size(X,1)),:); X(randi(size(X,1)),:); X(randi(size(X,1)),:); X(randi(size(X,1)),:); X(randi(size(X,1)),:); X(randi(size(X,1)),:); X(randi(size(X,1)),:); X(randi(size(X,1)),:);
    X(randi(size(X,1)),:); X(randi(size(X,1)),:); X(randi(size(X,1)),:); X(randi(size(X,1)),:);X(randi(size(X,1)),:); X(randi(size(X,1)),:); X(randi(size(X,1)),:); X(randi(size(X,1)),:)]; % randomly choose K points as the intitial centroids
idx(i,:) = findClosestCentroids(X, initial_centroids);
[centroids, idx(i,:)] = runkMeans(X, initial_centroids, max_iters, false);
for j = 1 : size(X, 1)
    cost(i) = cost(i) + (sum(X(j,:) - centroids(idx(i,j), :)))^2; %compute distortion
end
cost(i) = cost(i) / num_users;
%fprintf('Initial #%d:\n',i);
%fprintf('%d', idx(i, 1:num_users));
%fprintf('\n');
end
[min_cost, min_index] = min(cost);
fprintf('When there are %d users, Clustering result with the lowest distortion is #%d, the lowest distortion is %d\n', num_users, min_index, min_cost);
fprintf('%d,',idx(min_index,1:num_users));
fprintf('\n');

sel = floor(rand(1000, 1) * size(X, 1)) + 1;
%[X, mu, sigma] = featureNormalize(X);
[U, S] = pca(X);% visualization using pca
Z = projectData(X, U, 2);
figure;
plotDataPoints(Z(sel, :), idx(min_index,sel), K);
title('Clustering results shown with dimensionality reduction by using PCA');
end