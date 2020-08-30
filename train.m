function code = train(traindir, n)
% Speaker Recognition: Training Stage
%
% Input:
%       traindir : string name of directory contains all train sound files
%       n        : number of train files in traindir
%
% Output:
%       code     : trained VQ codebooks, code{i} for i-th speaker
%
% Note:
%       Sound files in traindir is supposed to be: 
%                       s1.wav, s2.wav, ..., sn.wav
% Example:
%       >> code = train('C:\data\train\', 8);

k = 80;                         % number of centroids required

for i = 1:n                     % train a VQ codebook for each speaker
    file = sprintf('%ss%d.wav', traindir, i);           
    disp(file);
   
    [s, fs] = audioread(file);
    s=s./max(s);        %normalize
    s=s(:,1);       %monochannel
    v = mfcc(s, fs,100,256);            % Compute MFCC's
   
    code{i} = testvq(v, k);      % Train VQ codebook
end