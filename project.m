
dt=0.001;
%time-vector
t= 0:dt:1;

% create a signal with 5 frequencies
x =  sin(2*pi*25*t)+ sin(2*pi*50*t)+sin(2*pi*70*t)+sin(2*pi*120*t)+sin(2*pi*150*t);

figure(1)
plot(t,x)
title('Input Signal')
hold on

%Add noise to signal
% The Gaussian random noise with variance of two   adds  noise to the signal.
y= x + 2*randn(size(x));
plot(t,y)
axis([0 .25 -5.5 5.5])
xlabel('time(s)')
ylabel ('amplitude')
legend('Clean','Noisy');

%compute the Fast Fourier Transform (FFT)

figure(2)

N= length(t); % length of data points 

Y=fft(y,N); %computes Fast Fourier Transform (FFT)
PSD= Y.*conj(Y)/N; %Power spectrum density (PSD)  shows how much power is present in each frequency (Magnitude of the Fourier coefficient)

freq=1/(dt*N)*(0:N)
L= 1:floor (N/2);

plot(freq(L),PSD(L))
xlabel('Frequency (Hz)')
ylabel('intensity')
title('Power Spectral Density (Signal in Fourier Space)')

% use PSD(powerspectral density) to filter out noise
figure (3)
indices=PSD>24; %find all indices with  large power
PSD=PSD.*indices; % zero out all other

plot(freq(L),PSD(L))
xlabel('frequency(Hz)')
ylabel('intensity')
title('Masked Signal in Fourier space')

figure (4)
Y=indices.*Y;
yfilt=ifft(Y); %inverse FFT

plot(t,yfilt)
axis([0 .25 -5 5])
xlabel('time (s)')
ylabel('amplitude')
title('Output Signal')


