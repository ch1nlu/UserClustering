function test(testdir, n, code)
% Speaker Recognition: Testing Stage
%
% Input:
%       testdir : string name of directory contains all test sound files
%       n       : number of test files in testdir
%       code    : codebooks of all trained speakers
%
% Note:
%       Sound files in testdir is supposed to be: 
%               s1.wav, s2.wav, ..., sn.wav
%
% Example:
%       >> test('C:\data\test\', 8, code);

for k = 1:n                     % read test sound file of each speaker
    file = sprintf('%ss%dt.wav', testdir, k);
    [s, fs] = audioread(file);      
     s=s./max(s);       %normailze the amplitude
     s=s(:,1);          %take only one channel
    v = mfcc(s, fs,100,256);            % Compute MFCC's
   
    distmin = inf;
    k1 = 0;
   
    for l = 1:length(code)      % each trained codebook, compute distortion
        d = disteu(v, code{l}); 
        dist = sum(min(d,[],2)) / size(d,1);
      
        if dist < distmin
            distmin = dist;
            k1 = l;
        end      
    end
   
    msg = sprintf('Tester %d matches with codebook %d', k, k1);
    disp(msg);
end