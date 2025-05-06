clear;close all;clc
set(0, 'DefaultFigureColormap', jet);
%% data
load('Record.mat')
load("shift_data.mat")
load("waveforms.mat")
%% parameters
time=(1:size(Record,1))/1000;

%% add
original=waveforms;
waveforms_nosie=add_noise(original,0.01);

%% plot
figure
plot(time,original(:,50),'DisplayName','orignal','Color','#0099e5');hold on;
plot(time,waveforms_nosie(:,50),'DisplayName','add gauss','Color','#ff4c4c');
xlabel('Time/s')
ylabel('Amplitude')
legend('show')

% figure
% plot(time,Record(:,50)-original,'DisplayName','orignal','Color','#0099e5');hold on;
% plot(time,Record(:,50)-data_gauss,'DisplayName','add gauss','Color','#ff4c4c');
% xlabel('Time/s')
% ylabel('Amplitude')
% legend('show')
% t = 0:0.001:1; % 时间向量
% signal = sin(2 * pi * 10 * t); % 10 Hz的正弦波
% 
% % 添加25 dB的高斯白噪声
% signalPower = mean(signal.^2); % 计算信号功率
% snr = 25; % 设置信噪比为25 dB
% noisePower = signalPower / 10^(snr/10); % 计算噪声功率
% noise1 = sqrt(noisePower) * randn(size(signal)); % 生成高斯白噪声
% noisySignal1 = signal + noise1; % 添加噪声到信号
% 
% % 添加10%的相对噪声
% noiseAmplitude = 0.1 * max(abs(signal)); % 计算10%信号幅度的噪声幅度
% noise2 = noiseAmplitude * randn(size(signal)); % 生成噪声
% noisySignal2 = signal + noise2; % 添加噪声到信号
% 
% % 绘制原始信号和添加噪声后的信号
% figure;
% subplot(3, 1, 1);
% plot(t, signal);
% title('原始信号');
% 
% subplot(3, 1, 2);
% plot(t, noisySignal1);
% title('添加25 dB SNR噪声后的信号');
% 
% subplot(3, 1, 3);
% plot(t, noisySignal2);
% title('添加10%噪声后的信号');
