function plotDataPoints(X, idx, K)
%plots data points in X, coloring them so that those with the same
%index assignments in idx have the same color
%   PLOTDATAPOINTS(X, idx, K) plots data points in X, coloring them so that those 
%   with the same index assignments in idx have the same color

% Create palette
palette = hsv(K + 3);
colors = palette(idx, :);
% Plot the data
scatter(X(:,1), X(:,2), 100, colors, 'filled');
end
