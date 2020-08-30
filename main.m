close all;
[s2,fs]=audioread('s7t.wav');
[s1,fs]=audioread('s7.wav');
[s3,fs]=audioread('s4t.wav');
[ts2,fs]=audioread('s4.wav');
ts2n=ts2./max(ts2);
s1n=s1./max(s1);
s2n=s2./max(s2);
s3n=s3./max(s3);
h=mfcc(s1n,fs,100,256);
h2=mfcc(s2n,fs,100,256);
hh=mfcc(s3n,fs,100,256);
h3=mfcc(ts2n,fs,100,256);
%hhh=mfcc(s11,fs,256,100);
figure(1);
imagesc(abs(h));
set(gca,'YDir','normal')
colorbar
xlabel('Time frame number');
ylabel('mfcc');
title('s7.wav train');
%figure(2);
%imagesc(abs(hh));

figure(2);
imagesc(abs(h2));
set(gca,'YDir','normal')
colorbar
xlabel('Time frame number');
ylabel('mfcc');
title('s7.wav test');
figure(3);
imagesc(abs(hh));
set(gca,'YDir','normal');
colorbar
xlabel('Time frame number');
ylabel('mfcc');
title('s4.wav train');
figure(4);
imagesc(abs(h3));
set(gca,'YDir','normal');
colorbar
xlabel('Time frame number');
ylabel('mfcc');
title('s4.wav test');