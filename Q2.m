[Audio, fs] = audioread('Arnold.wav');
[Calif, fs] = audioread('California.wav');

sound(Audio, fs);

%% calculating the correlation of two audio files
cor = normxcorr2(Calif, Audio);
plot(cor)

%% the peak of the graph is where 'California' is said
[CalifMax ,CalifIndex] = max(cor);
[ypeak,xpeak] = find(cor==max(cor(:)));

%% replacing it with another signal
t=[0:length(Calif)]/fs;
f0 = 1000;
CensorNoise = sin(2*pi*f0*t);

CensoredAudio = Audio;
CensoredAudio(CalifIndex - length(Calif) : CalifIndex) = CensorNoise;

%sound(CensoredAudio, fs);
audiowrite('Censored.wav', CensoredAudio, fs)